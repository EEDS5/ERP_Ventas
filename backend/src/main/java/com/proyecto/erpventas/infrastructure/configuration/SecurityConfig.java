package com.proyecto.erpventas.infrastructure.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@Profile("!test")
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf(AbstractHttpConfigurer::disable)
            .authorizeHttpRequests(auth -> auth
                .anyRequest().permitAll() // 🔓 Temporal: permite todas las rutas sin autenticación
            )
            .sessionManagement(sm -> sm.sessionCreationPolicy(SessionCreationPolicy.STATELESS));

        /* .authorizeHttpRequests(auth -> auth
        .requestMatchers("/api/users/register", "/api/users/login").permitAll() // 👈 Solo estas rutas públicas
        .anyRequest().authenticated()  */

        // 📝 NOTA:
        // En este momento NO estamos usando httpBasic(), formLogin(), ni JWT.
        // Esto es solo para desarrollo mientras se implementa un sistema de autenticación real.
        return http.build();
    }
}