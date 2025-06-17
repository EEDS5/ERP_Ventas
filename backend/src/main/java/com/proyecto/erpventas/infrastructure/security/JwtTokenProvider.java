package com.proyecto.erpventas.infrastructure.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import org.springframework.stereotype.Component;

import com.proyecto.erpventas.application.dto.response.usuario.UsuarioTokenPayload;

import javax.crypto.SecretKey;
import java.util.Date;
import java.util.List;
import java.util.Collections;

@Component
public class JwtTokenProvider {

    private final long validityInMilliseconds;
    // Corregido a SecretKey para compatibilidad correcta con verifyWith()
    private final SecretKey secretKey = Jwts.SIG.HS256.key().build();

    public JwtTokenProvider() {
        this.validityInMilliseconds = 3600000; // 1 hora
    }

    public JwtTokenProvider(long validityInMilliseconds) {
        this.validityInMilliseconds = validityInMilliseconds;
    }

    public String generateToken(String nombreUsuario, List<String> roles) {
        Date now = new Date();
        Date expiry = new Date(now.getTime() + validityInMilliseconds);

        return Jwts.builder()
                .subject(nombreUsuario)
                .claim("roles", roles)
                .issuedAt(now)
                .expiration(expiry)
                .signWith(secretKey)
                .compact();
    }

    /**
     * Genera un JWT sin lista de roles (usa lista vacía).
     */
    public String generateToken(String nombreUsuario) {
        return generateToken(nombreUsuario, Collections.emptyList());
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

    public UsuarioTokenPayload getUsuarioDesdeToken(String token) {
        Claims claims = Jwts.parser()
                .verifyWith(secretKey)
                .build()
                .parseSignedClaims(token)
                .getPayload();

        String nombreUsuario = claims.getSubject();
        @SuppressWarnings("unchecked")
        List<String> roles = (List<String>) claims.get("roles");
        return new UsuarioTokenPayload(nombreUsuario, roles);
    }

}