package com.proyecto.erpventas.infrastructure.security;

import org.junit.jupiter.api.Test;
import static org.assertj.core.api.Assertions.*;

public class JwtTokenProviderTest {

    @Test
    void deberiaGenerarYValidarTokenCorrectamente() {
        JwtTokenProvider provider = new JwtTokenProvider();
        String token = provider.generateToken("usuarioDemo");

        String resultado = provider.validateToken(token);
        assertThat(resultado).isEqualTo("usuarioDemo");
    }

    @Test
    void deberiaLanzarExcepcionSiTokenEsInvalido() {
        JwtTokenProvider provider = new JwtTokenProvider();
        String tokenInvalido = "token.mal.formado";

        assertThatThrownBy(() -> provider.validateToken(tokenInvalido))
            .isInstanceOf(RuntimeException.class)
            .hasMessageContaining("Token inválido o caducado");
    }

    @Test
    void deberiaLanzarExcepcionSiTokenEstaExpirado() throws InterruptedException {
        JwtTokenProvider provider = new JwtTokenProvider(10); // 10 ms de validez
        String token = provider.generateToken("usuarioDemo");

        Thread.sleep(20); // esperar a que expire

        assertThatThrownBy(() -> provider.validateToken(token))
            .isInstanceOf(RuntimeException.class)
            .hasMessageContaining("Token inválido o caducado");
    }
}