package com.proyecto.erpventas.domain.model.people;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.proyecto.erpventas.domain.model.auth.UsuarioRol;
import com.proyecto.erpventas.domain.model.auth.Role;

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

    /** Relación a la tabla intermedia UsuarioRoles */
    @OneToMany(mappedBy = "usuario", fetch = FetchType.LAZY)
    private List<UsuarioRol> usuarioRoles = new ArrayList<>();

    /**
     * Devuelve la lista de Roles activos para este usuario,
     * filtrando los UsuarioRol activos.
     */
    public List<Role> getRoles() {
        return this.usuarioRoles.stream()
                .filter(UsuarioRol::getActivo)
                .map(UsuarioRol::getRole)
                .filter(Role::getActivo)
                .collect(Collectors.toList());
    }
}