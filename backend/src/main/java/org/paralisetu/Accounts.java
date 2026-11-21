package org.paralisetu;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import java.util.Locale;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import static org.springframework.http.HttpStatus.*;

@RestController
@RequestMapping("/api")
class Accounts {
    record User(long id, String email, String name, String role) {}
    record Login(@NotBlank @Email @Size(max=160) String email,
                 @NotBlank @Size(max=72) String password) {}

    record Registration(@NotBlank @Size(max=100) String name,
                        @NotBlank @Email @Size(max=160) String email,
                        @NotBlank @Size(min=10,max=72) String password,
                        @NotBlank String role) {}

    private final JdbcTemplate db;
    private final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

    Accounts(JdbcTemplate db) { this.db = db; }

    @PostMapping("/auth/login")
    User login(@Valid @RequestBody Login body, HttpServletRequest request) {
        var users = db.query("SELECT * FROM users WHERE email=?", (row, i) ->
            new Object[] { new User(row.getLong("id"), row.getString("email"),
                row.getString("name"), row.getString("role")), row.getString("password_hash") },
            body.email().toLowerCase(Locale.ROOT));
        if (users.isEmpty() || body.password().getBytes(java.nio.charset.StandardCharsets.UTF_8).length > 72
            || !encoder.matches(body.password(), (String) users.getFirst()[1])) {
            throw new ApiProblem(UNAUTHORIZED, "Invalid email or password.");
        }
        return startSession(request,(User) users.getFirst()[0]);
    }

    @PostMapping("/auth/register")
    @ResponseStatus(CREATED)
    User register(@Valid @RequestBody Registration body, HttpServletRequest request) {
        if (!java.util.Set.of("FARMER","BUYER").contains(body.role()))
            throw new ApiProblem(BAD_REQUEST,"Self-registration is available for farmers and buyers.");
        if (body.password().getBytes(java.nio.charset.StandardCharsets.UTF_8).length>72)
            throw new ApiProblem(BAD_REQUEST,"Password must fit within 72 UTF-8 bytes.");
        String email = body.email().toLowerCase(Locale.ROOT);
        if (email.endsWith("@demo.paralisetu.org"))
            throw new ApiProblem(BAD_REQUEST,"Use a regular email address for registration.");
        try {
            db.update("INSERT INTO users(email,name,role,password_hash) VALUES (?,?,?,?)",
                email,body.name().strip(),body.role(),encoder.encode(body.password()));
        } catch (DuplicateKeyException error) {
            throw new ApiProblem(CONFLICT,"An account already exists for that email.");
        }
        long id = db.queryForObject("SELECT id FROM users WHERE email=?",Long.class,email);
        return startSession(request,new User(id,email,body.name().strip(),body.role()));
    }

    private User startSession(HttpServletRequest request, User user) {
        var old = request.getSession(false);
        if (old != null) old.invalidate();
        request.getSession(true).setAttribute("user", user);
        return user;
    }

    @GetMapping("/auth/me")
    User me(HttpServletRequest request) { return require(request); }

    @PostMapping("/auth/logout")
    @ResponseStatus(NO_CONTENT)
    void logout(HttpServletRequest request) {
        var session = request.getSession(false);
        if (session != null) session.invalidate();
    }

    static User require(HttpServletRequest request, String... roles) {
        HttpSession session = request.getSession(false);
        if (session == null || !(session.getAttribute("user") instanceof User user)) {
            throw new ApiProblem(UNAUTHORIZED, "Sign in to continue.");
        }
        if (roles.length > 0 && !java.util.List.of(roles).contains(user.role())) {
            throw new ApiProblem(FORBIDDEN, "This role cannot perform that action.");
        }
        return user;
    }
}
