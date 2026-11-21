package org.paralisetu;

import jakarta.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.*;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;
import static org.paralisetu.Accounts.require;
import static org.paralisetu.Orders.number;
import static org.springframework.http.HttpStatus.BAD_REQUEST;

@RestController
@RequestMapping("/api")
class Insights {
    record Match(Map<String,Object> listing, int score, List<String> reasons) {}
    private final JdbcTemplate db;

    Insights(JdbcTemplate db) { this.db=db; }

    @GetMapping("/matches")
    List<Match> matches(HttpServletRequest r, @RequestParam String crop, @RequestParam String district,
                        @RequestParam int quantityKg, @RequestParam(required=false) BigDecimal maxPrice) {
        require(r,"BUYER");
        if (crop.isBlank() || crop.length()>40 || district.isBlank() || district.length()>80
            || quantityKg<1 || quantityKg>10000000 || (maxPrice!=null && maxPrice.signum()<=0))
            throw new ApiProblem(BAD_REQUEST,"Enter a crop, district, positive quantity and optional positive price.");
        return db.queryForList(Listings.SELECT + """
            WHERE l.status='ACTIVE' AND l.available_until>=CURRENT_DATE AND l.available_kg>=? AND LOWER(l.crop)=LOWER(?)
            """,quantityKg,crop.strip()).stream().map(row -> rank(row,district,maxPrice))
            .sorted(Comparator.comparingInt(Match::score).reversed()
                .thenComparing(m -> (BigDecimal)m.listing().get("price_per_kg"))
                .thenComparingLong(m -> number(m.listing(),"id")))
            .limit(20).toList();
    }

    static Match rank(Map<String,Object> row, String district, BigDecimal maxPrice) {
        List<String> reasons = new ArrayList<>(List.of("Crop matches (+50)", "Enough stock (+25)"));
        boolean local = district.strip().equalsIgnoreCase((String)row.get("district"));
        boolean withinBudget = maxPrice != null && ((BigDecimal)row.get("price_per_kg")).compareTo(maxPrice)<=0;
        reasons.add(local ? "Preferred district (+15)" : "Different district (+0)");
        if (maxPrice!=null) reasons.add(withinBudget ? "Within budget (+10)" : "Above budget (+0)");
        return new Match(row,75+(local ? 15 : 0)+(withinBudget ? 10 : 0),reasons);
    }

    @GetMapping("/impact")
    @org.springframework.transaction.annotation.Transactional(readOnly=true)
    public Map<String,Object> impact(HttpServletRequest r) {
        require(r);
        var totals = db.queryForMap("""
            SELECT COUNT(*) AS deliveries, COALESCE(SUM(quantity_kg),0) AS delivered_kg
            FROM orders WHERE status='DELIVERED'
            """);
        var crops = db.queryForList("""
            SELECT crop, SUM(quantity_kg) AS delivered_kg FROM orders
            WHERE status='DELIVERED' GROUP BY crop ORDER BY crop
            """);
        return Map.of("deliveries", totals.get("deliveries"), "delivered_kg", totals.get("delivered_kg"),
            "by_crop", crops, "estimated_diverted_kg", totals.get("delivered_kg"),
            "caveat","Demo estimate assumes all delivered residue would otherwise have been burned. "
                + "This counterfactual is unverified. The estimate does not measure avoided emissions or certify carbon credits.");
    }
}
