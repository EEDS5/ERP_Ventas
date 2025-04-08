package com.proyecto.erpventas.application.usecases;

import com.proyecto.erpventas.application.dto.request.TwoFactorVerificationDTO;
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
        if (valid && !Boolean.TRUE.equals(user.getTwoFAEnabled())) {
            System.out.println("Actualizando el estado 2FA para el usuario " + user.getNombreUsuario());
            user.setTwoFAEnabled(true);
            userRepository.save(user);
            entityManager.flush();
            entityManager.clear();
            Usuario updated = entityManager.find(Usuario.class, user.getUsuarioID());
            System.out.println("Valor final en BD: " + updated.getTwoFAEnabled());
        }
        return valid;
    }
}