package org.paralisetu;

import jakarta.servlet.http.HttpServletRequest;
import java.util.Map;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import static org.springframework.http.HttpStatus.*;

@RestController
@RequestMapping("/api/orders/{id}/pickup-room")
class PickupRooms {
    private final JdbcTemplate db;

    PickupRooms(JdbcTemplate db) { this.db = db; }

    @GetMapping
    Map<String,Object> read(@PathVariable long id, HttpServletRequest request) {
        return room(id, Accounts.require(request,"FARMER","LOGISTICS"));
    }

    @PostMapping("/arrive")
    @Transactional
    public Map<String,Object> arrive(@PathVariable long id, HttpServletRequest request) {
        var user = Accounts.require(request,"FARMER","LOGISTICS");
        var current = room(id,user);
        String field = user.role().equals("FARMER") ? "farmer_arrived_at" : "carrier_arrived_at";
        if (!"ASSIGNED".equals(current.get("status")))
            throw new ApiProblem(CONFLICT,"Pickup check-in is closed.");
        // The conditional write serializes against both cancellation and pickup.
        db.update("UPDATE orders SET " + field + "=COALESCE(" + field + ",CURRENT_TIMESTAMP) "
            + "WHERE id=? AND status='ASSIGNED'",id);
        return room(id,user);
    }

    private Map<String,Object> room(long id, Accounts.User user) {
        String member = user.role().equals("FARMER") ? "o.farmer_id" : "o.carrier_id";
        var rows = db.queryForList("""
            SELECT o.id,o.status,o.crop,o.district,o.quantity_kg,
                   f.name AS farmer_name,c.name AS carrier_name,
                   o.farmer_arrived_at,o.carrier_arrived_at
            FROM orders o JOIN users f ON f.id=o.farmer_id JOIN users c ON c.id=o.carrier_id
            WHERE o.id=? AND
            """ + member + "=?",id,user.id());
        if (rows.isEmpty()) throw new ApiProblem(NOT_FOUND,"Pickup room not found.");
        return rows.getFirst();
    }
}
