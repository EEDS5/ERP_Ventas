// dominio/modulos/usuario.java (o Usuario.java)
package dominio.modulos;

import java.time.LocalDateTime;
import javax.persistence.*;

@Entity
@Table(name = "Usuarios")
public class Usuario {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long usuarioID;

  @Column(unique = true, nullable = false, length = 50)
  private String nombreUsuario;

  @Column(nullable = false, length = 255)
  private String password;

  @Column(unique = true, nullable = false, length = 100)
  private String email;

  @Column(nullable = false)
  private Boolean is2FAEnabled = false;

  @Column(length = 100)
  private String secret2FA;

  private LocalDateTime fechaRegistro = LocalDateTime.now();

  // Getters y setters
}
