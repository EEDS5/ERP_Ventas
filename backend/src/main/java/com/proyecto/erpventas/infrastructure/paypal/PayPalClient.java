package com.proyecto.erpventas.infrastructure.paypal;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.proyecto.erpventas.infrastructure.configuration.PayPalConfig;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

@Component
public class PayPalClient {

    private final PayPalConfig config;
    private final HttpClient httpClient = HttpClient.newHttpClient();
    private final ObjectMapper mapper = new ObjectMapper();

    public PayPalClient(PayPalConfig config) {
        this.config = config;
    }

    public String obtainAccessToken() throws IOException, InterruptedException {
        String credentials = Base64.getEncoder().encodeToString(
                (config.getClientId() + ":" + config.getSecret()).getBytes(StandardCharsets.UTF_8));
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(config.getBaseUrl() + "/v1/oauth2/token"))
                .header("Authorization", "Basic " + credentials)
                .header("Content-Type", "application/x-www-form-urlencoded")
                .POST(HttpRequest.BodyPublishers.ofString("grant_type=client_credentials"))
                .build();
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        if (response.statusCode() >= 200 && response.statusCode() < 300) {
            JsonNode node = mapper.readTree(response.body());
            return node.get("access_token").asText();
        }
        throw new RuntimeException("No se pudo obtener token de PayPal");
    }

    public String createOrder(String accessToken, BigDecimal amount) throws IOException, InterruptedException {
        String body = """
                {
                  \"intent\": \"CAPTURE\",
                  \"purchase_units\": [
                    {\n                      \"amount\": {\n                        \"currency_code\": \"USD\",\n                        \"value\": \"%s\"\n                      }\n                    }
                  ]
                }
                """.formatted(amount);
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(config.getBaseUrl() + "/v2/checkout/orders"))
                .header("Authorization", "Bearer " + accessToken)
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(body))
                .build();
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        if (response.statusCode() >= 200 && response.statusCode() < 300) {
            JsonNode node = mapper.readTree(response.body());
            return node.get("id").asText();
        }
        throw new RuntimeException("No se pudo crear la orden de PayPal");
    }

    public CaptureResult captureOrder(String accessToken, String orderId) throws IOException, InterruptedException {
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(config.getBaseUrl() + "/v2/checkout/orders/" + orderId + "/capture"))
                .header("Authorization", "Bearer " + accessToken)
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.noBody())
                .build();
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        if (response.statusCode() >= 200 && response.statusCode() < 300) {
            JsonNode node = mapper.readTree(response.body());
            String status = node.get("status").asText();
            JsonNode capture = node.get("purchase_units").get(0).get("payments").get("captures").get(0);
            String txId = capture.get("id").asText();
            BigDecimal value = new BigDecimal(capture.get("amount").get("value").asText());
            return new CaptureResult(status, txId, value);
        }
        throw new RuntimeException("No se pudo capturar la orden de PayPal");
    }

    public record CaptureResult(String status, String transactionId, BigDecimal amount) {}
}
