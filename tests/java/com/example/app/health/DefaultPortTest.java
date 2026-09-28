package com.example.app.health;

import static org.assertj.core.api.Assertions.assertThat;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;

// DEFINED_PORT uses the configured server port; none is configured, so Spring Boot's default applies.
@SpringBootTest(webEnvironment = WebEnvironment.DEFINED_PORT)
class DefaultPortTest {

    // AC-4
    @Test
    void servesHealthOnDefaultPort8080() throws Exception {
        HttpRequest request = HttpRequest.newBuilder(URI.create("http://localhost:8080/health"))
                .GET()
                .build();

        HttpResponse<String> response = HttpClient.newHttpClient()
                .send(request, HttpResponse.BodyHandlers.ofString());

        assertThat(response.statusCode()).isEqualTo(200);
    }
}
