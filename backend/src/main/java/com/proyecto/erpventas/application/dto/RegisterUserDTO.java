// aplicaciones/dto/RegisterUserDTO.java
package aplicaciones.dto;

public class RegisterUserDTO {
  private String nombreUsuario;
  private String email;
  private String password;

  // Getters y setters
}

// aplicaciones/dto/LoginUserDTO.java
package aplicaciones.dto;

public class LoginUserDTO {
  private String nombreUsuario;
  private String password;

  // Getters y setters
}

// aplicaciones/dto/TwoFactorVerificationDTO.java
package aplicaciones.dto;

public class TwoFactorVerificationDTO {
  private String nombreUsuario;
  private String token2FA;

  // Getters y setters
}
