package org.paralisetu;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.http.ProblemDetail;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.config.annotation.*;

class ApiProblem extends ResponseStatusException {
    ApiProblem(HttpStatus status, String message) { super(status, message); }
}

@RestControllerAdvice
class ApiErrors {
    @ExceptionHandler(MethodArgumentNotValidException.class)
    ProblemDetail validation(MethodArgumentNotValidException error) {
        var problem = ProblemDetail.forStatusAndDetail(HttpStatus.BAD_REQUEST, "Check the highlighted input requirements.");
        problem.setProperty("fields", error.getBindingResult().getFieldErrors().stream()
            .collect(Collectors.toMap(e -> e.getField(), e -> e.getDefaultMessage(), (first, second) -> first)));
        return problem;
    }

    @ExceptionHandler(ApiProblem.class)
    ProblemDetail application(ApiProblem error) {
        return error.getBody();
    }
}

@Configuration
class BrowserRequests implements WebMvcConfigurer {
    @Override public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new HandlerInterceptor() {
            @Override public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
                response.setHeader("Cache-Control", "no-store");
                if (!java.util.Set.of("GET","HEAD","OPTIONS").contains(request.getMethod())
                    && !"1".equals(request.getHeader("X-Parali-Client"))) {
                    throw new ApiProblem(HttpStatus.FORBIDDEN, "The X-Parali-Client request header is required.");
                }
                return true;
            }
        }).addPathPatterns("/api/**");
    }
}
