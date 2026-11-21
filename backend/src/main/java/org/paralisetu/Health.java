package org.paralisetu;

import java.util.Map;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

@RestController
class Health {
    private final JdbcTemplate db;

    Health(JdbcTemplate db) { this.db=db; }

    @GetMapping("/api/health")
    Map<String,String> health() {
        db.queryForObject("SELECT 1",Integer.class);
        return Map.of("status","up");
    }
}
