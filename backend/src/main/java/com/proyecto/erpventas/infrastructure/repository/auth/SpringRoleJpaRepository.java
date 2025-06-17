package com.proyecto.erpventas.infrastructure.repository.auth;

import com.proyecto.erpventas.domain.model.auth.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SpringRoleJpaRepository extends JpaRepository<Role, Long> {
}
