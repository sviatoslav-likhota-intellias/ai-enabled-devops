package com.example.app.health;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.boot.test.web.server.LocalServerPort;

@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
class HealthControllerTest {

    @LocalServerPort
    private int port;

    private final HttpClient client = HttpClient.newHttpClient();

    // AC-1
    @Test
    void returnsHttp200() throws Exception {
        HttpResponse<String> response = getHealth();

        assertThat(response.statusCode()).isEqualTo(200);
    }

    // AC-2
    @Test
    void returnsJsonStatusOk() throws Exception {
        HttpResponse<String> response = getHealth();

        assertThat(response.headers().firstValue("Content-Type")).hasValue("application/json");
        assertThat(response.body()).isEqualTo("{\"status\":\"OK\"}");
    }

    // AC-3: the request carries no Authorization header or cookies.
    @Test
    void isReachableWithoutCredentials() throws Exception {
        HttpResponse<String> response = getHealth();

        assertThat(response.request().headers().map()).doesNotContainKeys("Authorization", "Cookie");
        assertThat(response.statusCode()).isEqualTo(200);
    }

    private HttpResponse<String> getHealth() throws IOException, InterruptedException {
        HttpRequest request = HttpRequest.newBuilder(URI.create("http://localhost:" + port + "/health"))
                .GET()
                .build();
        return client.send(request, HttpResponse.BodyHandlers.ofString());
    }
}
