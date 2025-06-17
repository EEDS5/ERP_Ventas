package com.proyecto.erpventas.infrastructure.configuration;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.proyecto.erpventas.application.dto.request.auth.LoginUserDTO;
import com.proyecto.erpventas.application.dto.request.auth.RegisterUserDTO;
import com.proyecto.erpventas.application.dto.request.auth.TwoFactorVerificationDTO;
import com.proyecto.erpventas.application.dto.response.auth.TwoFactorSetupResponseDTO;
import com.proyecto.erpventas.application.usecases.auth.LoginUserUseCase;
import com.proyecto.erpventas.application.usecases.auth.RegisterUserUseCase;
import com.proyecto.erpventas.application.usecases.auth.VerifyTwoFactorUseCase;
import com.proyecto.erpventas.domain.model.people.Usuario;
import com.proyecto.erpventas.domain.service.AuthDomainService;
import com.proyecto.erpventas.infrastructure.controller.Auth.AuthenticationController;
import com.proyecto.erpventas.infrastructure.repository.usuario.UserRepository;
import com.proyecto.erpventas.infrastructure.security.JwtTokenProvider;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.time.LocalDateTime;
import java.util.Optional;

import static org.hamcrest.Matchers.nullValue;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(controllers = AuthenticationController.class, excludeAutoConfiguration = org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class)
class AuthenticationControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockitoBean
    private RegisterUserUseCase registerUserUseCase;

    @MockitoBean
    private LoginUserUseCase loginUserUseCase;

    @MockitoBean
    private VerifyTwoFactorUseCase verifyTwoFactorUseCase;

    @MockitoBean
    private UserRepository userRepository;

    @MockitoBean
    private JwtTokenProvider jwtTokenProvider;

    @MockitoBean
    private AuthDomainService authDomainService;

    private Usuario usuario;

    @BeforeEach
    void setUpUsuario() {
        usuario = new Usuario();
        usuario.setUsuarioID(1);
        usuario.setNombreUsuario("testuser");
        usuario.setEmail("test@example.com");
        usuario.setTwoFAEnabled(false);
        usuario.setFechaRegistro(LocalDateTime.of(2025, 5, 27, 10, 0));
        usuario.setActivo(true);
    }

    @Test
    void register_Success_ReturnsJwtAndUser() throws Exception {
        RegisterUserDTO dto = new RegisterUserDTO();
        dto.setNombreUsuario("testuser");
        dto.setEmail("test@example.com");
        dto.setPassword("password");

        when(registerUserUseCase.register(any(RegisterUserDTO.class))).thenReturn(usuario);
        when(jwtTokenProvider.generateToken(eq("testuser"), any())).thenReturn("token123");

        mockMvc.perform(post("/api/auth/register")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(dto)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.token").value("token123"))
                .andExpect(jsonPath("$.user.usuarioID").value(1))
                .andExpect(jsonPath("$.user.nombreUsuario").value("testuser"))
                .andExpect(jsonPath("$.user.email").value("test@example.com"))
                .andExpect(jsonPath("$.user.twoFAEnabled").value(false))
                .andExpect(jsonPath("$.user.fechaRegistro").exists())
                .andExpect(jsonPath("$.user.activo").value(true));

        verify(registerUserUseCase, times(1)).register(any());
        verify(jwtTokenProvider, times(1)).generateToken(eq("testuser"), any());
    }

    @Test
    void login_Without2FA_ReturnsJwtAndUser() throws Exception {
        LoginUserDTO dto = new LoginUserDTO();
        dto.setNombreUsuario("testuser");
        dto.setPassword("password");

        usuario.setTwoFAEnabled(false);
        when(loginUserUseCase.login(any(LoginUserDTO.class))).thenReturn(usuario);
        when(jwtTokenProvider.generateToken(eq("testuser"), any())).thenReturn("token456");

        mockMvc.perform(post("/api/auth/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(dto)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.token").value("token456"))
                .andExpect(jsonPath("$.user.usuarioID").value(1));

        verify(loginUserUseCase, times(1)).login(any());
        verify(jwtTokenProvider, times(1)).generateToken(eq("testuser"), any());
    }

    @Test
    void login_With2FA_Returns2FARequired() throws Exception {
        LoginUserDTO dto = new LoginUserDTO();
        dto.setNombreUsuario("testuser");
        dto.setPassword("password");

        usuario.setTwoFAEnabled(true);
        when(loginUserUseCase.login(any(LoginUserDTO.class))).thenReturn(usuario);

        mockMvc.perform(post("/api/auth/login")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(dto)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.token").value("2FA_REQUIRED"))
                .andExpect(jsonPath("$.user").value(nullValue()));

        verify(loginUserUseCase, times(1)).login(any());
        verify(jwtTokenProvider, never()).generateToken(any());
    }

    @Test
    void login2FA_ValidCode_ReturnsJwtAndUser() throws Exception {
        TwoFactorVerificationDTO dto = new TwoFactorVerificationDTO();
        dto.setNombreUsuario("testuser");
        dto.setToken2FA("123456");

        when(verifyTwoFactorUseCase.verify2FA(any(TwoFactorVerificationDTO.class))).thenReturn(true);
        when(userRepository.findByNombreUsuario("testuser")).thenReturn(Optional.of(usuario));
        when(jwtTokenProvider.generateToken(eq("testuser"), any())).thenReturn("token789");

        mockMvc.perform(post("/api/auth/login-2fa")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(dto)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.token").value("token789"))
                .andExpect(jsonPath("$.user.usuarioID").value(1));

        verify(verifyTwoFactorUseCase, times(1)).verify2FA(any());
        verify(jwtTokenProvider, times(1)).generateToken(eq("testuser"), any());
    }

    @Test
    void login2FA_InvalidCode_ThrowsException() throws Exception {
        TwoFactorVerificationDTO dto = new TwoFactorVerificationDTO();
        dto.setNombreUsuario("testuser");
        dto.setToken2FA("000000");

        when(verifyTwoFactorUseCase.verify2FA(any(TwoFactorVerificationDTO.class))).thenReturn(false);

        mockMvc.perform(post("/api/auth/login-2fa")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(dto)))
                .andExpect(status().isBadRequest());

        verify(verifyTwoFactorUseCase, times(1)).verify2FA(any());
    }

    @Test
    void verify2FA_ReturnsOkOrInvalid() throws Exception {
        TwoFactorVerificationDTO dto = new TwoFactorVerificationDTO();
        dto.setNombreUsuario("testuser");
        dto.setToken2FA("123456");

        when(verifyTwoFactorUseCase.verify2FA(any())).thenReturn(true);
        mockMvc.perform(post("/api/auth/verify-2fa")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(dto)))
                .andExpect(status().isOk())
                .andExpect(content().string("2FA_OK"));

        when(verifyTwoFactorUseCase.verify2FA(any())).thenReturn(false);
        mockMvc.perform(post("/api/auth/verify-2fa")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(dto)))
                .andExpect(status().isOk())
                .andExpect(content().string("2FA_INVALID"));
    }

    @Test
    void generate2FASecret_Success_ReturnsSecretAndQrUrl() throws Exception {
        String username = "testuser";
        usuario.setTwoFAEnabled(false);
        when(userRepository.findByNombreUsuario(username)).thenReturn(Optional.of(usuario));
        TwoFactorSetupResponseDTO setup = new TwoFactorSetupResponseDTO("secret123", "qrUrl123");
        when(authDomainService.generate2FASetup(username)).thenReturn(setup);

        mockMvc.perform(post("/api/auth/2fa-secret")
                .param("username", username))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.secret").value("secret123"))
                .andExpect(jsonPath("$.qrUrl").value("qrUrl123"));

        verify(authDomainService, times(1)).generate2FASetup(username);
    }

    @Test
    void generate2FASecret_UserAlreadyEnabled_ReturnsBadRequest() throws Exception {
        String username = "testuser";
        usuario.setTwoFAEnabled(true);
        when(userRepository.findByNombreUsuario(username)).thenReturn(Optional.of(usuario));

        mockMvc.perform(post("/api/auth/2fa-secret")
                .param("username", username))
                .andExpect(status().isBadRequest());
    }

    @Test
    void testUpdate2FA_Success_ReturnsConfirmation() throws Exception {
        String username = "testuser";
        usuario.setTwoFAEnabled(false);
        when(userRepository.findByNombreUsuario(username)).thenReturn(Optional.of(usuario));
        when(userRepository.save(any(Usuario.class))).thenReturn(usuario);

        mockMvc.perform(post("/api/auth/test-update-2fa")
                .param("nombreUsuario", username))
                .andExpect(status().isOk())
                .andExpect(content().string("2FA actualizado correctamente!"));

        ArgumentCaptor<Usuario> captor = ArgumentCaptor.forClass(Usuario.class);
        verify(userRepository).save(captor.capture());
        assertTrue(captor.getValue().getTwoFAEnabled());
    }

    @Test
    void testUpdate2FA_UserNotFound_ThrowsException() throws Exception {
        String username = "unknown";
        when(userRepository.findByNombreUsuario(username)).thenReturn(Optional.empty());

        mockMvc.perform(post("/api/auth/test-update-2fa")
                .param("nombreUsuario", username))
                .andExpect(status().isBadRequest());
    }
}