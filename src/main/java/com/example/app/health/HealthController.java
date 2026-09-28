package com.example.app.health;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
class HealthController {

    @GetMapping(path = "/health", produces = MediaType.APPLICATION_JSON_VALUE)
    HealthResponse health() {
        return HealthResponse.OK;
    }
}
