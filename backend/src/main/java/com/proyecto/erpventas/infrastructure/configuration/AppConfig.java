package com.proyecto.erpventas.infrastructure.configuration;

import com.proyecto.erpventas.application.usecases.LoginUserUseCase;
import com.proyecto.erpventas.application.usecases.RegisterUserUseCase;
import com.proyecto.erpventas.application.usecases.VerifyTwoFactorUseCase;
import com.proyecto.erpventas.infrastructure.repository.usuario.UserRepository;
import com.warrenstrange.googleauth.GoogleAuthenticator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Configuration
public class AppConfig {

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public GoogleAuthenticator googleAuthenticator() {
        return new GoogleAuthenticator();
    }

    @Bean
    public RegisterUserUseCase registerUserUseCase(UserRepository userRepository, BCryptPasswordEncoder passwordEncoder) {
        return new RegisterUserUseCase(userRepository, passwordEncoder);
    }

    @Bean
    public LoginUserUseCase loginUserUseCase(UserRepository userRepository, BCryptPasswordEncoder passwordEncoder) {
        return new LoginUserUseCase(userRepository, passwordEncoder);
    }

    @Bean
    public VerifyTwoFactorUseCase verifyTwoFactorUseCase(UserRepository userRepository, GoogleAuthenticator googleAuthenticator) {
        return new VerifyTwoFactorUseCase(userRepository, googleAuthenticator);
    }
}