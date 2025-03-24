package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.TwoFactorVerificationDTO;
import com.proyecto.erpventas.domain.model.Usuario;
import com.proyecto.erpventas.infrastructure.repository.UserRepository;
import com.warrenstrange.googleauth.GoogleAuthenticator;
import org.springframework.transaction.annotation.Transactional;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

public class VerifyTwoFactorUseCase {

    private final UserRepository userRepository;
    private final GoogleAuthenticator gAuth;

    @PersistenceContext
    private EntityManager entityManager;

    public VerifyTwoFactorUseCase(UserRepository userRepository, GoogleAuthenticator gAuth) {
        this.userRepository = userRepository;
        this.gAuth = gAuth;
    }

    @Transactional
    public boolean verify2FA(TwoFactorVerificationDTO dto) {
        Usuario user = userRepository
            .findByNombreUsuario(dto.getNombreUsuario())
            .orElseThrow(() -> new RuntimeException("No existe"));

        int code = Integer.parseInt(dto.getToken2FA());
        boolean valid = gAuth.authorize(user.getSecret2FA(), code);
        System.out.println("Token validado correctamente.");
        // Si bien en el flujo de configuración se puede activar 2FA,
        // en el flujo de login quizá no queramos modificar el flag,
        // o lo actualizamos solo la primera vez.
        if (valid && !user.isTwoFAEnabled()) {
            System.out.println("Actualizando el estado 2FA para el usuario " + user.getNombreUsuario());
            user.setTwoFAEnabled(true);
            userRepository.save(user);
            entityManager.flush();
            entityManager.clear();
            System.out.println("Actualización de 2FA realizada.");
        }
        return valid;
    }
}