package com.proyecto.erpventas.infrastructure.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class RemovePermissionsPolicyFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(
            @NonNull HttpServletRequest request,
            @NonNull HttpServletResponse response,
            @NonNull FilterChain filterChain
    ) throws ServletException, IOException {

        // Continúa con el resto del procesamiento (incluyendo Spring Security)
        filterChain.doFilter(request, response);

        // Luego de que Spring Security haya inyectado la cabecera "Permissions-Policy",
        // la eliminamos de la respuesta para que el navegador no la reciba jamás.
        response.setHeader("Permissions-Policy", null);
    }
}