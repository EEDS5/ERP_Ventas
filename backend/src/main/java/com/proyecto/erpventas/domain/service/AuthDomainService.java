package com.proyecto.erpventas.domain.service;

import com.proyecto.erpventas.application.dto.TwoFactorSetupResponseDTO;
import com.proyecto.erpventas.domain.model.Usuario;
import com.proyecto.erpventas.infrastructure.repository.UserRepository;
import com.warrenstrange.googleauth.GoogleAuthenticator;
import com.warrenstrange.googleauth.GoogleAuthenticatorKey;
import org.springframework.stereotype.Service;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@Service
public class AuthDomainService {

    private final GoogleAuthenticator gAuth;
    private final UserRepository userRepository;
    private final EmailService emailService;

    public AuthDomainService(GoogleAuthenticator gAuth, UserRepository userRepository, EmailService emailService) {
        this.gAuth = gAuth;
        this.userRepository = userRepository;
        this.emailService = emailService;
    }

    /**
     * Genera las credenciales para 2FA de un usuario, envía el QR por correo
     * y devuelve la información necesaria al frontend.
     */
    public TwoFactorSetupResponseDTO generate2FASetup(String username) {
        // 1. Obtener usuario
        Usuario user = userRepository.findByNombreUsuario(username)
            .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        // 2. Crear las credenciales TOTP (secret)
        GoogleAuthenticatorKey key = gAuth.createCredentials();
        String secret = key.getKey();

        // 3. Crear la URL otpauth con el secret y los datos de la cuenta
        String otpAuthURL = String.format(
            "otpauth://totp/%s@ERP_Ventas?secret=%s&issuer=ERP_Ventas",
            username, secret
        );

        // 4. Generar URL QR con la API de Google Charts
        String qrUrl;
        try {
            qrUrl = "https://chart.googleapis.com/chart?chs=200x200&cht=qr&chl="
                + URLEncoder.encode(otpAuthURL, StandardCharsets.UTF_8.toString());
        } catch (Exception e) {
            throw new RuntimeException("Error generando la URL del QR", e);
        }

        // 5. Guardar el secret en la BD
        user.setSecret2FA(secret);
        userRepository.save(user);

        // 6. Enviar correo
        String subject = "Código de Autenticación - ERP_Ventas";
        String htmlContent =
            "<!DOCTYPE html>" +
            "<html lang='es'>" +
            "<head>" +
            "  <meta charset='UTF-8'>" +
            "  <meta name='viewport' content='width=device-width, initial-scale=1.0'>" +
            "  <style>" +
            "    body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }" +
            "    .container { width: 100%; max-width: 600px; margin: 0 auto; background-color: #ffffff; padding: 20px; }" +
            "    .header { text-align: center; padding-bottom: 20px; }" +
            "    .header h1 { color: #2E86C1; margin: 0; }" +
            "    .content { font-size: 16px; color: #333333; line-height: 1.5; }" +
            "    .content h2 { color: #2E86C1; }" +
            "    .code { font-size: 24px; font-weight: bold; text-align: center; margin: 20px 0; }" +
            "    .button { display: inline-block; padding: 10px 20px; background-color: #2E86C1; color: #ffffff; text-decoration: none; border-radius: 5px; margin-top: 20px; }" +
            "    .qr-container { text-align: center; margin: 20px 0; }" +
            "    .footer { font-size: 12px; color: #777777; text-align: center; margin-top: 20px; }" +
            "  </style>" +
            "</head>" +
            "<body>" +
            "  <div class='container'>" +
            "    <div class='header'>" +
            "      <h1>ERP_Ventas</h1>" +
            "    </div>" +
            "    <div class='content'>" +
            "      <h2>Código de Autenticación</h2>" +
            "      <p>Tu <strong>clave secreta</strong> para la autenticación en dos pasos (2FA) es:</p>" +
            "      <p class='code'>" + secret + "</p>" +
            "      <p>Puedes escanear el siguiente código QR con la app de Google Authenticator:</p>" +
            "      <div class='qr-container'>" +
            "        <img src='" + qrUrl + "' alt='QR Code' style='max-width: 200px; height: auto;'/>" +
            "      </div>" +
            "      <p>O bien, haz clic en el botón de abajo desde tu móvil para configurar automáticamente tu cuenta en la aplicación:</p>" +
            "      <a href='" + otpAuthURL + "' class='button'>Configurar 2FA</a>" +
            "    </div>" +
            "    <div class='footer'>" +
            "      <p>Si no solicitaste este código, por favor ignora este correo.</p>" +
            "      <p>© 2025 ERP_Ventas. Todos los derechos reservados.</p>" +
            "    </div>" +
            "  </div>" +
            "</body>" +
            "</html>";

        emailService.sendStyledEmail(user.getEmail(), subject, htmlContent);

        // 7. Devolver la respuesta al controlador (con el secret y la URL del QR)
        return new TwoFactorSetupResponseDTO(secret, qrUrl);
    }
}
