package com.proyecto.erpventas.domain.model.auth;

import com.proyecto.erpventas.domain.model.people.Usuario;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Entity
@Table(name = "UsuarioRoles")
@Getter
@Setter
public class UsuarioRol {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "usuarioroleid")
    private Integer usuarioRoleId;

    @ManyToOne
    @JoinColumn(name = "usuarioid", nullable = false)
    private Usuario usuario;

    @ManyToOne
    @JoinColumn(name = "roleid", nullable = false)
    private Role role;

    @Column(name = "fechaasignacion", updatable = false)
    @CreationTimestamp
    private LocalDateTime fechaAsignacion;

    @Column(name = "activo", nullable = false)
    private Boolean activo = true;
}
