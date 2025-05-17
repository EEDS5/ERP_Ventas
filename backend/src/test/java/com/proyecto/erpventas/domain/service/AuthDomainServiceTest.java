package com.proyecto.erpventas.domain.service;

import com.proyecto.erpventas.application.dto.response.auth.TwoFactorSetupResponseDTO;
import com.proyecto.erpventas.application.service.QRCodeGeneratorService;
import com.proyecto.erpventas.domain.model.people.Usuario;
import com.proyecto.erpventas.infrastructure.repository.UserRepository;
import com.warrenstrange.googleauth.GoogleAuthenticator;
import com.warrenstrange.googleauth.GoogleAuthenticatorKey;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.Optional;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.contains;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

public class AuthDomainServiceTest {

    private GoogleAuthenticator gAuth;
    private UserRepository userRepository;
    private EmailService emailService;
    private AuthDomainService authDomainService;

    @BeforeEach
    void setUp() {
        gAuth = mock(GoogleAuthenticator.class);
        userRepository = mock(UserRepository.class);
        emailService = mock(EmailService.class);
        QRCodeGeneratorService qrCodeGeneratorService = new QRCodeGeneratorService(); // O también puedes mockearlo

        authDomainService = new AuthDomainService(
                gAuth, userRepository, emailService, qrCodeGeneratorService);
    }

    @Test
    void deberiaGenerarSetupDe2FACorrectamente() {
        // Arrange
        String username = "usuarioDemo";
        Usuario usuario = new Usuario();
        usuario.setNombreUsuario(username);
        usuario.setEmail("demo@erp.com");

        GoogleAuthenticatorKey key = new GoogleAuthenticatorKey.Builder("ABC123456").build();

        when(userRepository.findByNombreUsuario(username)).thenReturn(Optional.of(usuario));
        when(gAuth.createCredentials()).thenReturn(key);

        // Act
        TwoFactorSetupResponseDTO response = authDomainService.generate2FASetup(username);

        // Assert
        assertThat(response).isNotNull();
        assertThat(response.getSecret()).isEqualTo("ABC123456");
        assertThat(response.getQrUrl()).startsWith("data:image/png;base64,");

        verify(userRepository).save(usuario);
        verify(emailService).sendStyledEmail(eq("demo@erp.com"), contains("Código de Autenticación"), anyString());
    }

    @Test
    void deberiaLanzarExcepcionSiUsuarioNoExiste() {
        when(userRepository.findByNombreUsuario("usuarioX")).thenReturn(Optional.empty());

        assertThatThrownBy(() -> authDomainService.generate2FASetup("usuarioX"))
                .isInstanceOf(RuntimeException.class)
                .hasMessage("Usuario no encontrado");
    }
}