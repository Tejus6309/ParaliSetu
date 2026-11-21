package org.paralisetu;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.*;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;
import static org.paralisetu.Accounts.require;
import static org.springframework.http.HttpStatus.*;

@RestController
@RequestMapping("/api")
class Listings {
    static final String SELECT = """
        SELECT l.id,l.farmer_id,u.name AS farmer_name,l.crop,l.district,l.description,
               l.available_kg,l.price_per_kg,l.status,l.version,
               l.harvest_date,l.available_from,l.available_until
        FROM listings l JOIN users u ON u.id=l.farmer_id
        """;

    record ListingInput(@NotBlank @Size(max=40) String crop, @NotBlank @Size(max=80) String district,
                        @NotBlank @Size(max=1000) String description,
                        @NotNull @Min(0) @Max(10000000) Integer availableKg,
                        @NotNull @DecimalMin("0.01") @Digits(integer=8,fraction=2) BigDecimal pricePerKg,
                        @NotNull LocalDate harvestDate, @NotNull LocalDate availableFrom,
                        @NotNull LocalDate availableUntil, @PositiveOrZero Long version) {}
    record StatusInput(@NotBlank String status) {}
    private final JdbcTemplate db;

    Listings(JdbcTemplate db) { this.db = db; }

    @GetMapping("/listings")
    List<Map<String,Object>> browse(HttpServletRequest r,
        @RequestParam(defaultValue="") String q, @RequestParam(defaultValue="") String crop,
        @RequestParam(defaultValue="") String district, @RequestParam(defaultValue="1") int minKg,
        @RequestParam(defaultValue="0") int offset, @RequestParam(required=false) LocalDate harvestAfter) {
        require(r);
        if (minKg < 1 || offset < 0 || q.length()>100 || crop.length()>40 || district.length()>80)
            throw new ApiProblem(BAD_REQUEST, "Invalid marketplace filters.");
        return db.queryForList(SELECT + """
            WHERE l.status='ACTIVE' AND l.available_until>=CURRENT_DATE AND l.available_kg>=?
            AND l.harvest_date>=COALESCE(?,l.harvest_date)
            AND LOCATE(LOWER(?), LOWER(CONCAT_WS(' ',l.crop,l.district,l.description,u.name)))>0
            AND (?='' OR LOWER(l.crop)=LOWER(?)) AND (?='' OR LOWER(l.district)=LOWER(?))
            ORDER BY l.id DESC LIMIT 100 OFFSET ?
            """, minKg,harvestAfter,q.strip(),crop.strip(),crop.strip(),district.strip(),district.strip(),offset);
    }

    @GetMapping("/listings/{id}")
    Map<String,Object> detail(@PathVariable long id, HttpServletRequest r) {
        var user = require(r);
        var rows = db.queryForList(SELECT + """
            WHERE l.id=? AND ((l.status='ACTIVE' AND l.available_until>=CURRENT_DATE) OR (l.status<>'DELETED' AND (l.farmer_id=? OR ?='ADMIN')))
            """, id,user.id(),user.role());
        if (rows.isEmpty()) throw new ApiProblem(NOT_FOUND, "Listing not found.");
        return rows.getFirst();
    }

    @GetMapping("/farmer/listings")
    List<Map<String,Object>> mine(HttpServletRequest r) {
        return db.queryForList(SELECT + "WHERE l.farmer_id=? AND l.status<>'DELETED' ORDER BY l.id DESC",
            require(r,"FARMER").id());
    }

    @PostMapping("/farmer/listings")
    @ResponseStatus(CREATED)
    void create(@Valid @RequestBody ListingInput body, HttpServletRequest r) {
        var user = require(r,"FARMER");
        validateDates(body);
        db.update("""
            INSERT INTO listings(farmer_id,crop,district,description,available_kg,price_per_kg,harvest_date,available_from,available_until)
            VALUES (?,?,?,?,?,?,?,?,?)
            """, user.id(),body.crop().strip(),body.district().strip(),body.description().strip(),
            body.availableKg(),body.pricePerKg(),body.harvestDate(),body.availableFrom(),body.availableUntil());
    }

    @PutMapping("/farmer/listings/{id}")
    @ResponseStatus(NO_CONTENT)
    void edit(@PathVariable long id, @Valid @RequestBody ListingInput body, HttpServletRequest r) {
        var user = require(r,"FARMER");
        validateDates(body);
        if (body.version()==null) throw new ApiProblem(BAD_REQUEST,"An edit requires the listing version.");
        int changed = db.update("""
            UPDATE listings SET crop=?,district=?,description=?,available_kg=?,price_per_kg=?,
                harvest_date=?,available_from=?,available_until=?,version=version+1
            WHERE id=? AND farmer_id=? AND version=? AND status IN ('ACTIVE','PAUSED')
            """,body.crop().strip(),body.district().strip(),body.description().strip(),body.availableKg(),
            body.pricePerKg(),body.harvestDate(),body.availableFrom(),body.availableUntil(),id,user.id(),body.version());
        if (changed==0) {
            var rows = db.queryForList("SELECT id FROM listings WHERE id=? AND farmer_id=? AND status IN ('ACTIVE','PAUSED')",id,user.id());
            if (rows.isEmpty()) throw new ApiProblem(NOT_FOUND,"Listing not found or unavailable for editing.");
            throw new ApiProblem(CONFLICT,"The listing changed. Close the editor and reopen the latest listing.");
        }
    }

    @PatchMapping("/farmer/listings/{id}/status")
    @ResponseStatus(NO_CONTENT)
    void status(@PathVariable long id, @Valid @RequestBody StatusInput body, HttpServletRequest r) {
        var user = require(r,"FARMER");
        if (!Set.of("ACTIVE","PAUSED").contains(body.status()))
            throw new ApiProblem(BAD_REQUEST,"Choose ACTIVE or PAUSED.");
        check(db.update("UPDATE listings SET status=? WHERE id=? AND farmer_id=? AND status IN ('ACTIVE','PAUSED')",
            body.status(),id,user.id()));
    }

    @DeleteMapping("/farmer/listings/{id}")
    @ResponseStatus(NO_CONTENT)
    void delete(@PathVariable long id, HttpServletRequest r) {
        check(db.update("UPDATE listings SET status='DELETED' WHERE id=? AND farmer_id=? AND status<>'DELETED'",
            id,require(r,"FARMER").id()));
    }

    @GetMapping("/admin/listings")
    List<Map<String,Object>> moderation(HttpServletRequest r) {
        require(r,"ADMIN");
        return db.queryForList(SELECT + "WHERE l.status<>'DELETED' ORDER BY l.id DESC");
    }

    @PatchMapping("/admin/listings/{id}/status")
    @ResponseStatus(NO_CONTENT)
    void moderate(@PathVariable long id, @Valid @RequestBody StatusInput body, HttpServletRequest r) {
        require(r,"ADMIN");
        if (!Set.of("REMOVED","PAUSED").contains(body.status()))
            throw new ApiProblem(BAD_REQUEST,"Choose REMOVED or PAUSED.");
        String sourceCondition = body.status().equals("REMOVED") ? "status IN ('ACTIVE','PAUSED')" : "status='REMOVED'";
        check(db.update("UPDATE listings SET status=? WHERE id=? AND " + sourceCondition,body.status(),id));
    }

    private void validateDates(ListingInput body) {
        if (body.harvestDate().isAfter(body.availableFrom()) || body.availableFrom().isAfter(body.availableUntil())
            || body.harvestDate().getYear()<1000 || body.availableUntil().getYear()>9999)
            throw new ApiProblem(BAD_REQUEST,"Use valid dates in harvest, available from, available until order.");
    }

    private void check(int count) {
        if (count==0) throw new ApiProblem(NOT_FOUND,"Listing not found or unavailable for this action.");
    }
}
