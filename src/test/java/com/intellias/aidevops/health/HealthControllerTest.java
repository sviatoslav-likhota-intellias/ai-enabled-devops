package com.intellias.aidevops.health;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.header;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.webmvc.test.autoconfigure.WebMvcTest;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.test.json.JsonCompareMode;
import org.springframework.test.web.servlet.MockMvc;

@WebMvcTest(HealthController.class)
class HealthControllerTest {

    @Autowired
    private MockMvc mockMvc;

    // AC-1
    @Test
    void getHealthReturns200() throws Exception {
        mockMvc.perform(get("/health"))
                .andExpect(status().isOk());
    }

    // AC-2
    @Test
    void getHealthReturnsStatusOkBody() throws Exception {
        mockMvc.perform(get("/health"))
                .andExpect(content().json("{\"status\":\"OK\"}", JsonCompareMode.STRICT));
    }

    // AC-3
    @Test
    void getHealthReturnsJsonContentType() throws Exception {
        mockMvc.perform(get("/health"))
                .andExpect(content().contentType(MediaType.APPLICATION_JSON));
    }

    // AC-4
    @Test
    void getHealthWithoutCredentialsReturns200() throws Exception {
        mockMvc.perform(get("/health"))
                .andExpect(header().doesNotExist(HttpHeaders.WWW_AUTHENTICATE))
                .andExpect(status().isOk());
    }

    // AC-5
    @Test
    void postHealthReturns405() throws Exception {
        mockMvc.perform(post("/health"))
                .andExpect(status().isMethodNotAllowed());
    }
}
