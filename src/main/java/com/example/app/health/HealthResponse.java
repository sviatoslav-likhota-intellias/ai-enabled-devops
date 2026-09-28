package com.example.app.health;

public record HealthResponse(String status) {

    static final HealthResponse OK = new HealthResponse("OK");
}
