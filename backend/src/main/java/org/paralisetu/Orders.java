package org.paralisetu;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import java.util.*;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import static org.paralisetu.Accounts.require;
import static org.springframework.http.HttpStatus.*;

@RestController
@RequestMapping("/api")
class Orders {
    record RequestInput(@NotNull @Positive Long listingId, @NotNull @Min(1) @Max(10000000) Integer quantityKg) {}
    record ActionInput(@NotBlank String action, @Positive Long carrierId) {}
    record Transition(String status, int reserveSign) {}

    private final JdbcTemplate db;

    Orders(JdbcTemplate db) { this.db = db; }

    @GetMapping("/orders")
    List<Map<String,Object>> orders(HttpServletRequest r) {
        var user = require(r);
        String filter = switch (user.role()) {
            case "FARMER" -> "WHERE o.farmer_id=?";
            case "BUYER" -> "WHERE o.buyer_id=?";
            case "LOGISTICS" -> "WHERE o.carrier_id=?";
            default -> "";
        };
        Object[] args = filter.isEmpty() ? new Object[0] : new Object[]{user.id()};
        return db.queryForList("""
            SELECT o.*, f.name AS farmer_name, b.name AS buyer_name, c.name AS carrier_name
            FROM orders o JOIN users f ON f.id=o.farmer_id JOIN users b ON b.id=o.buyer_id
            LEFT JOIN users c ON c.id=o.carrier_id
            """ + filter + " ORDER BY o.id DESC", args);
    }

    @GetMapping("/carriers")
    List<Map<String,Object>> carriers(HttpServletRequest r) {
        require(r,"FARMER");
        return db.queryForList("SELECT id,name FROM users WHERE role='LOGISTICS' ORDER BY name");
    }

    @PostMapping("/orders")
    @ResponseStatus(CREATED)
    @Transactional
    public void request(@Valid @RequestBody RequestInput body, HttpServletRequest r) {
        var user = require(r,"BUYER");
        var listing = listingForUpdate(body.listingId());
        if (!isOrderable(listing) || number(listing,"available_kg") < body.quantityKg())
            throw new ApiProblem(CONFLICT,"This active listing does not have enough available stock.");
        db.update("""
            INSERT INTO orders(listing_id,farmer_id,buyer_id,quantity_kg,price_per_kg,crop,district)
            VALUES (?,?,?,?,?,?,?)
            """,body.listingId(),listing.get("farmer_id"),user.id(),body.quantityKg(),listing.get("price_per_kg"),
            listing.get("crop"),listing.get("district"));
    }

    @PatchMapping("/orders/{id}")
    @ResponseStatus(NO_CONTENT)
    @Transactional
    public void change(@PathVariable long id, @Valid @RequestBody ActionInput body, HttpServletRequest r) {
        var user = require(r,"FARMER","BUYER","LOGISTICS");
        String member = switch (user.role()) {
            case "FARMER" -> "farmer_id";
            case "BUYER" -> "buyer_id";
            default -> "carrier_id";
        };
        String orderQuery = "SELECT * FROM orders WHERE id=? AND " + member + "=?";
        var initial = only(db.queryForList(orderQuery,id,user.id()),"Order not found.");
        long listingId = number(initial,"listing_id");
        // Every order writer takes the listing lock before the order lock.
        var listing = listingForUpdate(listingId);
        var order = only(db.queryForList(orderQuery + " FOR UPDATE",id,user.id()),"Order not found.");
        var transition = transition(user.role(),(String)order.get("status"),body.action());
        if (body.action().equals("ASSIGN") && (body.carrierId()==null || db.queryForList(
            "SELECT id FROM users WHERE id=? AND role='LOGISTICS'",body.carrierId()).isEmpty()))
            throw new ApiProblem(BAD_REQUEST,"Select an existing logistics provider.");

        if (transition.reserveSign()==1 && (!isOrderable(listing)
            || number(listing,"available_kg") < number(order,"quantity_kg")
            || !listing.get("crop").equals(order.get("crop")) || !listing.get("district").equals(order.get("district"))
            || !listing.get("price_per_kg").equals(order.get("price_per_kg"))))
            throw new ApiProblem(CONFLICT,"Stock or listing terms changed. Reject the request and ask the buyer to submit again.");

        if (transition.reserveSign()!=0)
            db.update("UPDATE listings SET available_kg=available_kg-?,version=version+1 WHERE id=?",
                number(order,"quantity_kg") * transition.reserveSign(),listingId);

        Long carrier = body.action().equals("ASSIGN") ? body.carrierId()
            : (order.get("carrier_id") == null ? null : number(order,"carrier_id"));
        db.update("UPDATE orders SET status=?,carrier_id=? WHERE id=?",transition.status(),carrier,id);
    }

    static Transition transition(String role, String status, String action) {
        return switch (role + ":" + status + ":" + action) {
            case "FARMER:REQUESTED:ACCEPT" -> new Transition("ACCEPTED",1);
            case "FARMER:REQUESTED:REJECT" -> new Transition("REJECTED",0);
            case "BUYER:REQUESTED:CANCEL" -> new Transition("CANCELLED",0);
            case "BUYER:ACCEPTED:CANCEL", "BUYER:ASSIGNED:CANCEL",
                 "FARMER:ACCEPTED:CANCEL", "FARMER:ASSIGNED:CANCEL" -> new Transition("CANCELLED",-1);
            case "FARMER:ACCEPTED:ASSIGN" -> new Transition("ASSIGNED",0);
            case "LOGISTICS:ASSIGNED:PICK_UP" -> new Transition("PICKED_UP",0);
            case "LOGISTICS:PICKED_UP:DELIVER" -> new Transition("DELIVERED",0);
            default -> throw new ApiProblem(CONFLICT,"That action is unavailable for this order status and role.");
        };
    }

    private Map<String,Object> listingForUpdate(long id) {
        return only(db.queryForList("SELECT *, CASE WHEN available_until>=CURRENT_DATE THEN 1 ELSE 0 END AS in_window FROM listings WHERE id=? FOR UPDATE",id),"Listing not found.");
    }

    private boolean isOrderable(Map<String,Object> listing) {
        return "ACTIVE".equals(listing.get("status")) && number(listing,"in_window")==1;
    }

    private Map<String,Object> only(List<Map<String,Object>> rows, String message) {
        if (rows.isEmpty()) throw new ApiProblem(NOT_FOUND,message);
        return rows.getFirst();
    }

    static long number(Map<String,Object> row, String field) { return ((Number)row.get(field)).longValue(); }
}
