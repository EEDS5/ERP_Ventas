package com.proyecto.erpventas.infrastructure.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Date;

@Component
public class JwtTokenProvider {

    private final long validityInMilliseconds = 3600000; // 1 hora

    // Corregido a SecretKey para compatibilidad correcta con verifyWith()
    private final SecretKey secretKey = Jwts.SIG.HS256.key().build();

    public String generateToken(String nombreUsuario) {
        Date now = new Date();
        Date expiry = new Date(now.getTime() + validityInMilliseconds);

        return Jwts.builder()
                .subject(nombreUsuario)
                .issuedAt(now)
                .expiration(expiry)
                .signWith(secretKey)
                .compact();
    }

    public String validateToken(String token) {
        try {
            Claims claims = Jwts.parser()
                    .verifyWith(secretKey)
                    .build()
                    .parseSignedClaims(token)
                    .getPayload();

            return claims.getSubject();
        } catch (Exception e) {
            throw new RuntimeException("Token inválido o caducado", e);
        }
    }
}