package com.proyecto.erpventas.domain.service;

import com.proyecto.erpventas.application.dto.response.auth.TwoFactorSetupResponseDTO;
import com.proyecto.erpventas.application.service.QRCodeGeneratorService;
import com.proyecto.erpventas.domain.model.people.Usuario;
import com.proyecto.erpventas.infrastructure.repository.usuario.UserRepository;
import com.warrenstrange.googleauth.GoogleAuthenticator;
import com.warrenstrange.googleauth.GoogleAuthenticatorKey;
import org.springframework.stereotype.Service;

@Service
public class AuthDomainService {

    private final GoogleAuthenticator gAuth;
    private final UserRepository userRepository;
    private final EmailService emailService;
    private final QRCodeGeneratorService qrCodeGeneratorService;

    public AuthDomainService(
            GoogleAuthenticator gAuth,
            UserRepository userRepository,
            EmailService emailService,
            QRCodeGeneratorService qrCodeGeneratorService) {
        this.gAuth = gAuth;
        this.userRepository = userRepository;
        this.emailService = emailService;
        this.qrCodeGeneratorService = qrCodeGeneratorService;
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
                username, secret);

        // 4. Generar código QR en base64 localmente
        String qrUrl = qrCodeGeneratorService.generateBase64QRCode(otpAuthURL);

        // 5. Guardar el secret en la BD
        user.setSecret2FA(secret);
        userRepository.save(user);

        // 6. Enviar correo
        String subject = "Código de Autenticación - ERP_Ventas";
        String htmlContent = generarContenidoHtml(secret, qrUrl, otpAuthURL);
        emailService.sendStyledEmail(user.getEmail(), subject, htmlContent);

        // 7. Devolver la respuesta al controlador (con el secret y la URL del QR)
        return new TwoFactorSetupResponseDTO(secret, qrUrl);
    }

    private String generarContenidoHtml(String secret, String qrUrl, String otpAuthUrl) {
        return """
                <!DOCTYPE html>
                <html lang='es'>
                <head>
                  <meta charset='UTF-8'>
                  <meta name='viewport' content='width=device-width, initial-scale=1.0'>
                  <style>
                    body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0; }
                    .container { width: 100%%; max-width: 600px; margin: 0 auto; background-color: #ffffff; padding: 20px; }
                    .header { text-align: center; padding-bottom: 20px; }
                    .header h1 { color: #2E86C1; margin: 0; }
                    .content { font-size: 16px; color: #333333; line-height: 1.5; }
                    .content h2 { color: #2E86C1; }
                    .code { font-size: 24px; font-weight: bold; text-align: center; margin: 20px 0; }
                    .button { display: inline-block; padding: 10px 20px; background-color: #2E86C1; color: #ffffff; text-decoration: none; border-radius: 5px; margin-top: 20px; }
                    .qr-container { text-align: center; margin: 20px 0; }
                    .footer { font-size: 12px; color: #777777; text-align: center; margin-top: 20px; }
                  </style>
                </head>
                <body>
                  <div class='container'>
                    <div class='header'>
                      <h1>ERP_Ventas</h1>
                    </div>
                    <div class='content'>
                      <h2>Código de Autenticación</h2>
                      <p>Tu <strong>clave secreta</strong> para la autenticación en dos pasos (2FA) es:</p>
                      <p class='code'>%s</p>
                      <p>Puedes escanear el siguiente código QR con la app de Google Authenticator:</p>
                      <div class='qr-container'>
                        <img src='%s' alt='QR Code' style='max-width: 200px; height: auto;'/>
                      </div>
                      <p>O bien, haz clic en el botón de abajo desde tu móvil para configurar automáticamente tu cuenta en la aplicación:</p>
                <div style="text-align: center; margin-top: 20px;">
                  <a href='%s'
                     style="display: inline-block; padding: 12px 24px; background-color: #2E86C1; color: #ffffff;
                            text-decoration: none; border-radius: 5px; font-weight: bold; font-size: 16px;">
                    Activar en mi aplicación 2FA
                  </a>
                </div>
                    </div>
                    <div class='footer'>
                      <p>Si no solicitaste este código, por favor ignora este correo.</p>
                      <p>© 2025 ERP_Ventas. Todos los derechos reservados.</p>
                    </div>
                  </div>
                </body>
                </html>
                """.formatted(secret, qrUrl, otpAuthUrl);
    }
}