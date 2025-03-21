// aplicaciones/usecases/VerifyTwoFactorUseCase.java
package aplicaciones.usecases;

import aplicaciones.dto.TwoFactorVerificationDTO;
import dominio.modulos.Usuario;
import repository.UserRepository;
import com.warrenstrange.googleauth.GoogleAuthenticator;

public class VerifyTwoFactorUseCase {

  private final UserRepository userRepository;
  private final GoogleAuthenticator gAuth;

  public VerifyTwoFactorUseCase(UserRepository repo,
                                GoogleAuthenticator gAuth) {
    this.userRepository = repo;
    this.gAuth = gAuth;
  }

  public boolean verify2FA(TwoFactorVerificationDTO dto) {
    Usuario user = userRepository
      .findByNombreUsuario(dto.getNombreUsuario())
      .orElseThrow(() -> new RuntimeException("No existe"));

    if (!Boolean.TRUE.equals(user.getIs2FAEnabled())) {
      return true; // Si 2FA no está habilitado, pasa
    }

    int code = Integer.parseInt(dto.getToken2FA());
    return gAuth.authorize(user.getSecret2FA(), code);
  }
}
