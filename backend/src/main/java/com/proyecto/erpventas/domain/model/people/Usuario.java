package com.proyecto.erpventas.domain.model.people;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Entity
@Table(name = "Usuarios")
@Getter
@Setter
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "usuarioid")
    private Integer usuarioID;

    @Column(name = "nombreusuario", unique = true, nullable = false)
    private String nombreUsuario;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "email", unique = true, nullable = false)
    private String email;

    @Column(name = "is2faenabled")
    private Boolean twoFAEnabled = false;

    @Column(name = "secret2fa")
    private String secret2FA;

    @Column(name = "fecharegistro", nullable = false, updatable = false)
    @CreationTimestamp
    private LocalDateTime fechaRegistro;
    
    // Campo para el borrado lógico (soft-delete)
    @Column(name = "activo", nullable = false)
    private Boolean activo = true;
}
