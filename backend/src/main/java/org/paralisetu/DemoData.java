package org.paralisetu;

import java.util.List;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@ConditionalOnProperty(name="demo.enabled",havingValue="true")
class DemoData implements ApplicationRunner {
    private final JdbcTemplate db;
    private final String password;

    DemoData(JdbcTemplate db, @Value("${demo.password}") String password) {
        this.db=db;
        this.password=password;
    }

    @Override
    @Transactional
    public void run(ApplicationArguments args) {
        if (db.queryForObject("SELECT COUNT(*) FROM users WHERE email='farmer@demo.paralisetu.org'",Integer.class)>0)
            return;
        String hash = new BCryptPasswordEncoder().encode(password);
        account("farmer","Gurpreet Singh","FARMER",hash);
        account("buyer","GreenField Biomass","BUYER",hash);
        account("logistics","Punjab Rural Transport","LOGISTICS",hash);
        account("admin","ParaliSetu Moderator","ADMIN",hash);
        long farmer = id("farmer");
        var today = java.time.LocalDate.now();
        for (Object[] crop : List.of(
            new Object[]{"Rice straw","Ludhiana","Dry, baled paddy straw ready for pickup.",2400,"2.40"},
            new Object[]{"Wheat straw","Patiala","Stored under cover. Tractor access available.",1500,"3.10"},
            new Object[]{"Rice straw","Sangrur","Loose straw collected after harvest.",850,"2.20"},
            new Object[]{"Maize stalks","Bathinda","Bundled stalks from the autumn harvest.",1200,"2.70"})) {
            db.update("""
                INSERT INTO listings(farmer_id,crop,district,description,available_kg,price_per_kg,harvest_date,available_from,available_until)
                VALUES (?,?,?,?,?,?,?,?,?)
                """,farmer,crop[0],crop[1],crop[2],crop[3],new java.math.BigDecimal((String)crop[4]), today.minusDays(14), today.minusDays(7), today.plusDays(365));
        }
        db.update("""
            INSERT INTO orders(listing_id,farmer_id,buyer_id,carrier_id,quantity_kg,price_per_kg,crop,district,status)
            SELECT id,farmer_id,?,?,350,price_per_kg,crop,district,'DELIVERED'
            FROM listings WHERE farmer_id=? AND crop='Rice straw' AND district='Ludhiana'
            """,id("buyer"),id("logistics"),farmer);
    }

    private void account(String alias, String name, String role, String hash) {
        db.update("INSERT INTO users(email,name,role,password_hash) VALUES (?,?,?,?)",
            alias+"@demo.paralisetu.org",name,role,hash);
    }

    private long id(String alias) {
        return db.queryForObject("SELECT id FROM users WHERE email=?",Long.class,alias+"@demo.paralisetu.org");
    }
}
