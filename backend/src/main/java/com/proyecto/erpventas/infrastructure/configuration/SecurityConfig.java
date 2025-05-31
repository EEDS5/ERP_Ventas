package com.proyecto.erpventas.infrastructure.configuration;

import com.proyecto.erpventas.infrastructure.security.JwtAuthenticationFilter;
import com.proyecto.erpventas.infrastructure.security.JwtTokenProvider;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.List;

@Configuration
@Profile("!test")
public class SecurityConfig {

    private final JwtTokenProvider jwtTokenProvider;

    public SecurityConfig(JwtTokenProvider jwtTokenProvider) {
        this.jwtTokenProvider = jwtTokenProvider;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            // 1) Configuración de CORS:
            .cors(cors -> cors.configurationSource(corsConfigurationSource()))
            // 2) Desactivar CSRF (porque usamos JWT y no sesiones con formularios):
            .csrf(AbstractHttpConfigurer::disable)

            // 3) VACÍO ≡ NO INCLUIR NINGÚN FEATURE en “Permissions-Policy”
            //    Usamos permissionsPolicyHeader(...) en lugar de permissionsPolicy(...),
            //    para no emplear el método deprecated.
            .headers(headers -> headers
                // Deja el header "Permissions-Policy" presente pero sin valor.
                // El método permissionsPolicyHeader() no está deprecado.
                .permissionsPolicyHeader(policy -> policy.policy(""))
            )

            // 4) Definir rutas públicas y rutas protegidas:
            .authorizeHttpRequests(auth -> auth
                .requestMatchers(
                    "/api/auth/register",
                    "/api/auth/login",
                    "/api/auth/login-2fa",
                    "/api/auth/2fa-secret",
                    "/api/auth/verify-2fa",
                    "/docs/**",
                    "/swagger-ui/**",
                    "/v3/api-docs/**",
                    "/actuator/health",
                    "/actuator/info"
                ).permitAll()
                .anyRequest().authenticated()
            )

            // 5) Política de sesión: Stateless (token JWT sin sesión HTTP):
            .sessionManagement(sm -> sm.sessionCreationPolicy(SessionCreationPolicy.STATELESS))

            // 6) Filtro personalizado para validar JWT antes de UsernamePasswordAuthenticationFilter:
            .addFilterBefore(
                new JwtAuthenticationFilter(jwtTokenProvider),
                org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter.class
            );

        return http.build();
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        // Permitir llamadas desde tu frontend en http://localhost:4200 (desarrollo)
        // y desde http://172.190.147.232:4200 (producción en VM):
        configuration.setAllowedOrigins(List.of(
            "http://localhost:4200",
            "http://172.190.147.232:4200"
        ));
        // Métodos HTTP permitidos:
        configuration.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        // Todos los headers permitidos:
        configuration.setAllowedHeaders(List.of("*"));
        configuration.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}
// Este archivo configura la seguridad de la aplicación, incluyendo CORS, CSRF, políticas de sesión y autenticación JWT.