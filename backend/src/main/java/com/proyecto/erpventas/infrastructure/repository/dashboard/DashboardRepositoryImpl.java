package com.proyecto.erpventas.infrastructure.repository.dashboard;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class DashboardRepositoryImpl implements DashboardRepository {

        @PersistenceContext
        private EntityManager entityManager;

        @Override
        public BigDecimal obtenerVentasHoy() {
                // Usamos la entidad 'Venta' (singular), y FUNCTION('DATE', ...) para truncar la
                // hora
                return entityManager.createQuery(
                                "SELECT COALESCE(SUM(v.total), 0) " +
                                                "FROM Venta v " +
                                                "WHERE FUNCTION('DATE', v.fechaVenta) = CURRENT_DATE",
                                BigDecimal.class).getSingleResult();
        }

        @Override
        public BigDecimal obtenerFacturacionMesActual() {
                // De nuevo raíz 'Venta', y funciones year() y month()
                return entityManager.createQuery(
                                "SELECT COALESCE(SUM(v.total), 0) " +
                                                "FROM Venta v " +
                                                "WHERE year(v.fechaVenta) = :anio " +
                                                "  AND month(v.fechaVenta) = :mes",
                                BigDecimal.class)
                                .setParameter("anio", LocalDate.now().getYear())
                                .setParameter("mes", LocalDate.now().getMonthValue())
                                .getSingleResult();
        }

        @Override
        public Map<String, Object> obtenerResumenCuentas() {
                Map<String, Object> resultado = new HashMap<>();

                // Total pendiente + vencido
                BigDecimal totalPendiente = entityManager.createQuery(
                                "SELECT COALESCE(SUM(c.montoPendiente),0) "
                                                + "FROM CuentaPorCobrar c "
                                                + "WHERE c.estado IN ('Pendiente','Vencido')",
                                BigDecimal.class).getSingleResult();

                // Cantidad de clientes deudores
                Long cantidadClientes = entityManager.createQuery(
                                "SELECT COUNT(DISTINCT c.cliente.id) "
                                                + "FROM CuentaPorCobrar c "
                                                + "WHERE c.estado IN ('Pendiente','Vencido')",
                                Long.class).getSingleResult();

                // Distribución por estado
                Map<String, Integer> estados = new HashMap<>();
                for (String est : List.of("Pendiente", "Vencido", "Pagado")) {
                        Long cnt = entityManager.createQuery(
                                        "SELECT COUNT(c) FROM CuentaPorCobrar c WHERE c.estado = :est",
                                        Long.class).setParameter("est", est)
                                        .getSingleResult();
                        estados.put(est, cnt.intValue());
                }

                resultado.put("totalPendiente", totalPendiente);
                resultado.put("cantidadClientesDeudores", cantidadClientes);
                resultado.put("estadoCuentas", estados);
                return resultado;
        }

        @Override
        public Integer obtenerCantidadStockBajo() {
                Long resultado = entityManager.createQuery(
                                "SELECT COUNT(p) FROM Producto p WHERE p.stock < 10",
                                Long.class).getSingleResult();
                return resultado.intValue();
        }

        @Override
        public Integer obtenerCantidadUsuarios2FA() {
                Long resultado = entityManager.createQuery(
                                "SELECT COUNT(u) FROM Usuario u WHERE u.twoFAEnabled = true",
                                Long.class)
                                .getSingleResult();
                return resultado.intValue();
        }
}