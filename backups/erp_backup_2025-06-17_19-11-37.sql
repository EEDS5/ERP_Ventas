--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.4 (Debian 17.4-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: asignarrolausuario(integer, integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.asignarrolausuario(_usuarioid integer, _roleid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO UsuarioRoles (UsuarioID, RoleID, Activo)
    VALUES (_UsuarioID, _RoleID, TRUE)
    ON CONFLICT (UsuarioID, RoleID) DO
      UPDATE SET Activo = TRUE, FechaAsignacion = NOW();
END;
$$;


ALTER FUNCTION public.asignarrolausuario(_usuarioid integer, _roleid integer) OWNER TO erp_user;

--
-- Name: borrarcategoriaproducto(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.borrarcategoriaproducto(_categoriaid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE CategoriasProducto SET Activo = FALSE WHERE CategoriaID = _CategoriaID;
END;
$$;


ALTER FUNCTION public.borrarcategoriaproducto(_categoriaid integer) OWNER TO erp_user;

--
-- Name: borrarcliente(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.borrarcliente(_clienteid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Clientes SET Activo = FALSE WHERE ClienteID = _ClienteID;
END;
$$;


ALTER FUNCTION public.borrarcliente(_clienteid integer) OWNER TO erp_user;

--
-- Name: borrarcuentaporcobrar(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.borrarcuentaporcobrar(_cuentaid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE CuentasPorCobrar SET Activo = FALSE WHERE CuentaID = _CuentaID;
END;
$$;


ALTER FUNCTION public.borrarcuentaporcobrar(_cuentaid integer) OWNER TO erp_user;

--
-- Name: borrardetalleventa(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.borrardetalleventa(_detalleid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE DetalleVentas SET Activo = FALSE WHERE DetalleID = _DetalleID;
END;
$$;


ALTER FUNCTION public.borrardetalleventa(_detalleid integer) OWNER TO erp_user;

--
-- Name: borrarfactura(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.borrarfactura(_facturaid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Facturas SET Activo = FALSE WHERE FacturaID = _FacturaID;
END;
$$;


ALTER FUNCTION public.borrarfactura(_facturaid integer) OWNER TO erp_user;

--
-- Name: borrarmetodopago(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.borrarmetodopago(_metodopagoid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE MetodosPago SET Activo = FALSE WHERE MetodoPagoID = _MetodoPagoID;
END;
$$;


ALTER FUNCTION public.borrarmetodopago(_metodopagoid integer) OWNER TO erp_user;

--
-- Name: borrarpago(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.borrarpago(_pagoid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Pagos SET Activo = FALSE WHERE PagoID = _PagoID;
END;
$$;


ALTER FUNCTION public.borrarpago(_pagoid integer) OWNER TO erp_user;

--
-- Name: borrarpasarelapago(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.borrarpasarelapago(_pasarelaid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE PasarelasPago SET Activo = FALSE WHERE PasarelaID = _PasarelaID;
END;
$$;


ALTER FUNCTION public.borrarpasarelapago(_pasarelaid integer) OWNER TO erp_user;

--
-- Name: borrarproducto(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.borrarproducto(_productoid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Productos SET Activo = FALSE WHERE ProductoID = _ProductoID;
END;
$$;


ALTER FUNCTION public.borrarproducto(_productoid integer) OWNER TO erp_user;

--
-- Name: borrarrol(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.borrarrol(_roleid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Roles SET Activo = FALSE WHERE RoleID = _RoleID;
END;
$$;


ALTER FUNCTION public.borrarrol(_roleid integer) OWNER TO erp_user;

--
-- Name: borrartransaccionpasarela(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.borrartransaccionpasarela(_transaccionid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE TransaccionesPasarela SET Activo = FALSE WHERE TransaccionID = _TransaccionID;
END;
$$;


ALTER FUNCTION public.borrartransaccionpasarela(_transaccionid integer) OWNER TO erp_user;

--
-- Name: borrarusuario(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.borrarusuario(_usuarioid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Usuarios SET Activo = FALSE WHERE UsuarioID = _UsuarioID;
END;
$$;


ALTER FUNCTION public.borrarusuario(_usuarioid integer) OWNER TO erp_user;

--
-- Name: borrarventa(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.borrarventa(_ventaid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Ventas SET Activo = FALSE WHERE VentaID = _VentaID;
END;
$$;


ALTER FUNCTION public.borrarventa(_ventaid integer) OWNER TO erp_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categoriasproducto; Type: TABLE; Schema: public; Owner: erp_user
--

CREATE TABLE public.categoriasproducto (
    categoriaid integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion character varying(255),
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.categoriasproducto OWNER TO erp_user;

--
-- Name: obtenercategoriasproductoactivas(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.obtenercategoriasproductoactivas() RETURNS SETOF public.categoriasproducto
    LANGUAGE sql
    AS $$
    SELECT * FROM CategoriasProducto WHERE Activo = TRUE;
$$;


ALTER FUNCTION public.obtenercategoriasproductoactivas() OWNER TO erp_user;

--
-- Name: clientes; Type: TABLE; Schema: public; Owner: erp_user
--

CREATE TABLE public.clientes (
    clienteid integer NOT NULL,
    nombre character varying(100) NOT NULL,
    correo character varying(100) NOT NULL,
    telefono character varying(20),
    direccion character varying(255),
    fecharegistro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    creadoporusuarioid integer NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    CONSTRAINT clientes_correo_check CHECK (((correo)::text ~ '^[^@]+@[^@]+\.[^@]+$'::text))
);


ALTER TABLE public.clientes OWNER TO erp_user;

--
-- Name: obtenerclientesactivos(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.obtenerclientesactivos() RETURNS SETOF public.clientes
    LANGUAGE sql
    AS $$
    SELECT * FROM Clientes WHERE Activo = TRUE;
$$;


ALTER FUNCTION public.obtenerclientesactivos() OWNER TO erp_user;

--
-- Name: cuentasporcobrar; Type: TABLE; Schema: public; Owner: erp_user
--

CREATE TABLE public.cuentasporcobrar (
    cuentaid integer NOT NULL,
    clienteid integer NOT NULL,
    ventaid integer NOT NULL,
    montopendiente numeric(10,2) NOT NULL,
    fechavencimiento timestamp without time zone NOT NULL,
    estado character varying(50) NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    CONSTRAINT cuentasporcobrar_estado_check CHECK (((estado)::text = ANY ((ARRAY['Pendiente'::character varying, 'Pagado'::character varying, 'Vencido'::character varying])::text[]))),
    CONSTRAINT cuentasporcobrar_montopendiente_check CHECK ((montopendiente >= (0)::numeric))
);


ALTER TABLE public.cuentasporcobrar OWNER TO erp_user;

--
-- Name: obtenercuentasporcobraractivas(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.obtenercuentasporcobraractivas() RETURNS SETOF public.cuentasporcobrar
    LANGUAGE sql
    AS $$
    SELECT * FROM CuentasPorCobrar WHERE Activo = TRUE;
$$;


ALTER FUNCTION public.obtenercuentasporcobraractivas() OWNER TO erp_user;

--
-- Name: detalleventas; Type: TABLE; Schema: public; Owner: erp_user
--

CREATE TABLE public.detalleventas (
    detalleid integer NOT NULL,
    ventaid integer NOT NULL,
    productoid integer NOT NULL,
    cantidad integer NOT NULL,
    preciounitario numeric(10,2) NOT NULL,
    subtotal numeric(10,2) GENERATED ALWAYS AS (((cantidad)::numeric * preciounitario)) STORED,
    activo boolean DEFAULT true NOT NULL,
    CONSTRAINT detalleventas_cantidad_check CHECK ((cantidad > 0)),
    CONSTRAINT detalleventas_preciounitario_check CHECK ((preciounitario >= (0)::numeric))
);


ALTER TABLE public.detalleventas OWNER TO erp_user;

--
-- Name: obtenerdetalleventasactivos(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.obtenerdetalleventasactivos() RETURNS SETOF public.detalleventas
    LANGUAGE sql
    AS $$
    SELECT * FROM DetalleVentas WHERE Activo = TRUE;
$$;


ALTER FUNCTION public.obtenerdetalleventasactivos() OWNER TO erp_user;

--
-- Name: facturas; Type: TABLE; Schema: public; Owner: erp_user
--

CREATE TABLE public.facturas (
    facturaid integer NOT NULL,
    ventaid integer NOT NULL,
    numerofactura character varying(50) NOT NULL,
    fechaemision timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    xmlfactura xml,
    creadoporusuarioid integer NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.facturas OWNER TO erp_user;

--
-- Name: obtenerfacturasactivas(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.obtenerfacturasactivas() RETURNS SETOF public.facturas
    LANGUAGE sql
    AS $$
    SELECT * FROM Facturas WHERE Activo = TRUE;
$$;


ALTER FUNCTION public.obtenerfacturasactivas() OWNER TO erp_user;

--
-- Name: metodospago; Type: TABLE; Schema: public; Owner: erp_user
--

CREATE TABLE public.metodospago (
    metodopagoid integer NOT NULL,
    nombre character varying(50) NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.metodospago OWNER TO erp_user;

--
-- Name: obtenermetodospagoactivos(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.obtenermetodospagoactivos() RETURNS SETOF public.metodospago
    LANGUAGE sql
    AS $$
    SELECT * FROM MetodosPago WHERE Activo = TRUE;
$$;


ALTER FUNCTION public.obtenermetodospagoactivos() OWNER TO erp_user;

--
-- Name: pagos; Type: TABLE; Schema: public; Owner: erp_user
--

CREATE TABLE public.pagos (
    pagoid integer NOT NULL,
    cuentaid integer NOT NULL,
    fechapago timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    monto numeric(10,2) NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    CONSTRAINT pagos_monto_check CHECK ((monto >= (0)::numeric))
);


ALTER TABLE public.pagos OWNER TO erp_user;

--
-- Name: obtenerpagosactivos(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.obtenerpagosactivos() RETURNS SETOF public.pagos
    LANGUAGE sql
    AS $$
    SELECT * FROM Pagos WHERE Activo = TRUE;
$$;


ALTER FUNCTION public.obtenerpagosactivos() OWNER TO erp_user;

--
-- Name: pasarelaspago; Type: TABLE; Schema: public; Owner: erp_user
--

CREATE TABLE public.pasarelaspago (
    pasarelaid integer NOT NULL,
    nombre character varying(50) NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.pasarelaspago OWNER TO erp_user;

--
-- Name: obtenerpasarelaspagoactivas(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.obtenerpasarelaspagoactivas() RETURNS SETOF public.pasarelaspago
    LANGUAGE sql
    AS $$
    SELECT * FROM PasarelasPago WHERE Activo = TRUE;
$$;


ALTER FUNCTION public.obtenerpasarelaspagoactivas() OWNER TO erp_user;

--
-- Name: productos; Type: TABLE; Schema: public; Owner: erp_user
--

CREATE TABLE public.productos (
    productoid integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion character varying(255),
    precio numeric(10,2) NOT NULL,
    stock integer NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    categoriaid integer NOT NULL,
    CONSTRAINT productos_precio_check CHECK ((precio >= (0)::numeric)),
    CONSTRAINT productos_stock_check CHECK ((stock >= 0))
);


ALTER TABLE public.productos OWNER TO erp_user;

--
-- Name: obtenerproductosactivos(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.obtenerproductosactivos() RETURNS SETOF public.productos
    LANGUAGE sql
    AS $$
    SELECT * FROM Productos WHERE Activo = TRUE;
$$;


ALTER FUNCTION public.obtenerproductosactivos() OWNER TO erp_user;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: erp_user
--

CREATE TABLE public.roles (
    roleid integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion character varying(255),
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.roles OWNER TO erp_user;

--
-- Name: obtenerrolesactivos(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.obtenerrolesactivos() RETURNS SETOF public.roles
    LANGUAGE sql
    AS $$
    SELECT * FROM Roles WHERE Activo = TRUE;
$$;


ALTER FUNCTION public.obtenerrolesactivos() OWNER TO erp_user;

--
-- Name: obtenerrolesporusuario(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.obtenerrolesporusuario(_usuarioid integer) RETURNS TABLE(roleid integer, nombre character varying, descripcion character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT r.RoleID, r.Nombre, r.Descripcion
    FROM Roles r
    JOIN UsuarioRoles ur ON r.RoleID = ur.RoleID
    WHERE ur.UsuarioID = _UsuarioID
      AND ur.Activo = TRUE
      AND r.Activo = TRUE;
END;
$$;


ALTER FUNCTION public.obtenerrolesporusuario(_usuarioid integer) OWNER TO erp_user;

--
-- Name: transaccionespasarela; Type: TABLE; Schema: public; Owner: erp_user
--

CREATE TABLE public.transaccionespasarela (
    transaccionid integer NOT NULL,
    ventaid integer NOT NULL,
    pasarelaid integer NOT NULL,
    estado character varying(50) NOT NULL,
    fechatransaccion timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    monto numeric(10,2) NOT NULL,
    referenciatransaccion character varying(100) NOT NULL,
    iniciadaporusuarioid integer NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    CONSTRAINT transaccionespasarela_estado_check CHECK (((estado)::text = ANY ((ARRAY['Pendiente'::character varying, 'Aprobado'::character varying, 'Rechazado'::character varying])::text[]))),
    CONSTRAINT transaccionespasarela_monto_check CHECK ((monto >= (0)::numeric))
);


ALTER TABLE public.transaccionespasarela OWNER TO erp_user;

--
-- Name: obtenertransaccionespasarelaactivas(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.obtenertransaccionespasarelaactivas() RETURNS SETOF public.transaccionespasarela
    LANGUAGE sql
    AS $$
    SELECT * FROM TransaccionesPasarela WHERE Activo = TRUE;
$$;


ALTER FUNCTION public.obtenertransaccionespasarelaactivas() OWNER TO erp_user;

--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: erp_user
--

CREATE TABLE public.usuarios (
    usuarioid integer NOT NULL,
    nombreusuario character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(100) NOT NULL,
    is2faenabled boolean DEFAULT false,
    secret2fa character varying(100),
    fecharegistro timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    activo boolean DEFAULT true NOT NULL,
    CONSTRAINT usuarios_email_check CHECK (((email)::text ~ '^[^@]+@[^@]+\.[^@]+$'::text))
);


ALTER TABLE public.usuarios OWNER TO erp_user;

--
-- Name: obtenerusuariosactivos(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.obtenerusuariosactivos() RETURNS SETOF public.usuarios
    LANGUAGE sql
    AS $$
    SELECT * FROM Usuarios WHERE Activo = TRUE;
$$;


ALTER FUNCTION public.obtenerusuariosactivos() OWNER TO erp_user;

--
-- Name: ventas; Type: TABLE; Schema: public; Owner: erp_user
--

CREATE TABLE public.ventas (
    ventaid integer NOT NULL,
    clienteid integer NOT NULL,
    fechaventa timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    total numeric(10,2) NOT NULL,
    metodopagoid integer NOT NULL,
    creadoporusuarioid integer NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    CONSTRAINT ventas_total_check CHECK ((total >= (0)::numeric))
);


ALTER TABLE public.ventas OWNER TO erp_user;

--
-- Name: obtenerventasactivas(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.obtenerventasactivas() RETURNS SETOF public.ventas
    LANGUAGE sql
    AS $$
    SELECT * FROM Ventas WHERE Activo = TRUE;
$$;


ALTER FUNCTION public.obtenerventasactivas() OWNER TO erp_user;

--
-- Name: reactivarcategoriaproducto(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.reactivarcategoriaproducto(_categoriaid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE CategoriasProducto SET Activo = TRUE WHERE CategoriaID = _CategoriaID;
END;
$$;


ALTER FUNCTION public.reactivarcategoriaproducto(_categoriaid integer) OWNER TO erp_user;

--
-- Name: reactivarcliente(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.reactivarcliente(_clienteid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Clientes SET Activo = TRUE WHERE ClienteID = _ClienteID;
END;
$$;


ALTER FUNCTION public.reactivarcliente(_clienteid integer) OWNER TO erp_user;

--
-- Name: reactivarcuentaporcobrar(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.reactivarcuentaporcobrar(_cuentaid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE CuentasPorCobrar SET Activo = TRUE WHERE CuentaID = _CuentaID;
END;
$$;


ALTER FUNCTION public.reactivarcuentaporcobrar(_cuentaid integer) OWNER TO erp_user;

--
-- Name: reactivardetalleventa(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.reactivardetalleventa(_detalleid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE DetalleVentas SET Activo = TRUE WHERE DetalleID = _DetalleID;
END;
$$;


ALTER FUNCTION public.reactivardetalleventa(_detalleid integer) OWNER TO erp_user;

--
-- Name: reactivarfactura(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.reactivarfactura(_facturaid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Facturas SET Activo = TRUE WHERE FacturaID = _FacturaID;
END;
$$;


ALTER FUNCTION public.reactivarfactura(_facturaid integer) OWNER TO erp_user;

--
-- Name: reactivarmetodopago(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.reactivarmetodopago(_metodopagoid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE MetodosPago SET Activo = TRUE WHERE MetodoPagoID = _MetodoPagoID;
END;
$$;


ALTER FUNCTION public.reactivarmetodopago(_metodopagoid integer) OWNER TO erp_user;

--
-- Name: reactivarpago(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.reactivarpago(_pagoid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Pagos SET Activo = TRUE WHERE PagoID = _PagoID;
END;
$$;


ALTER FUNCTION public.reactivarpago(_pagoid integer) OWNER TO erp_user;

--
-- Name: reactivarpasarelapago(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.reactivarpasarelapago(_pasarelaid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE PasarelasPago SET Activo = TRUE WHERE PasarelaID = _PasarelaID;
END;
$$;


ALTER FUNCTION public.reactivarpasarelapago(_pasarelaid integer) OWNER TO erp_user;

--
-- Name: reactivarproducto(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.reactivarproducto(_productoid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Productos SET Activo = TRUE WHERE ProductoID = _ProductoID;
END;
$$;


ALTER FUNCTION public.reactivarproducto(_productoid integer) OWNER TO erp_user;

--
-- Name: reactivarrol(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.reactivarrol(_roleid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Roles SET Activo = TRUE WHERE RoleID = _RoleID;
END;
$$;


ALTER FUNCTION public.reactivarrol(_roleid integer) OWNER TO erp_user;

--
-- Name: reactivartransaccionpasarela(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.reactivartransaccionpasarela(_transaccionid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE TransaccionesPasarela SET Activo = TRUE WHERE TransaccionID = _TransaccionID;
END;
$$;


ALTER FUNCTION public.reactivartransaccionpasarela(_transaccionid integer) OWNER TO erp_user;

--
-- Name: reactivarusuario(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.reactivarusuario(_usuarioid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Usuarios SET Activo = TRUE WHERE UsuarioID = _UsuarioID;
END;
$$;


ALTER FUNCTION public.reactivarusuario(_usuarioid integer) OWNER TO erp_user;

--
-- Name: reactivarventa(integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.reactivarventa(_ventaid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Ventas SET Activo = TRUE WHERE VentaID = _VentaID;
END;
$$;


ALTER FUNCTION public.reactivarventa(_ventaid integer) OWNER TO erp_user;

--
-- Name: removerrolausuario(integer, integer); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.removerrolausuario(_usuarioid integer, _roleid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE UsuarioRoles
    SET Activo = FALSE
    WHERE UsuarioID = _UsuarioID
      AND RoleID = _RoleID;
END;
$$;


ALTER FUNCTION public.removerrolausuario(_usuarioid integer, _roleid integer) OWNER TO erp_user;

--
-- Name: sp_prevent_delete_categoriasproducto(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.sp_prevent_delete_categoriasproducto() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE CategoriasProducto SET Activo = FALSE WHERE CategoriaID = OLD.CategoriaID;
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.sp_prevent_delete_categoriasproducto() OWNER TO erp_user;

--
-- Name: sp_prevent_delete_clientes(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.sp_prevent_delete_clientes() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Clientes SET Activo = FALSE WHERE ClienteID = OLD.ClienteID;
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.sp_prevent_delete_clientes() OWNER TO erp_user;

--
-- Name: sp_prevent_delete_cuentasporcobrar(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.sp_prevent_delete_cuentasporcobrar() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE CuentasPorCobrar SET Activo = FALSE WHERE CuentaID = OLD.CuentaID;
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.sp_prevent_delete_cuentasporcobrar() OWNER TO erp_user;

--
-- Name: sp_prevent_delete_detalleventas(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.sp_prevent_delete_detalleventas() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE DetalleVentas SET Activo = FALSE WHERE DetalleID = OLD.DetalleID;
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.sp_prevent_delete_detalleventas() OWNER TO erp_user;

--
-- Name: sp_prevent_delete_facturas(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.sp_prevent_delete_facturas() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Facturas SET Activo = FALSE WHERE FacturaID = OLD.FacturaID;
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.sp_prevent_delete_facturas() OWNER TO erp_user;

--
-- Name: sp_prevent_delete_metodospago(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.sp_prevent_delete_metodospago() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE MetodosPago SET Activo = FALSE WHERE MetodoPagoID = OLD.MetodoPagoID;
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.sp_prevent_delete_metodospago() OWNER TO erp_user;

--
-- Name: sp_prevent_delete_pagos(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.sp_prevent_delete_pagos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Pagos SET Activo = FALSE WHERE PagoID = OLD.PagoID;
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.sp_prevent_delete_pagos() OWNER TO erp_user;

--
-- Name: sp_prevent_delete_pasarelaspago(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.sp_prevent_delete_pasarelaspago() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE PasarelasPago SET Activo = FALSE WHERE PasarelaID = OLD.PasarelaID;
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.sp_prevent_delete_pasarelaspago() OWNER TO erp_user;

--
-- Name: sp_prevent_delete_productos(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.sp_prevent_delete_productos() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Productos SET Activo = FALSE WHERE ProductoID = OLD.ProductoID;
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.sp_prevent_delete_productos() OWNER TO erp_user;

--
-- Name: sp_prevent_delete_roles(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.sp_prevent_delete_roles() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Roles SET Activo = FALSE WHERE RoleID = OLD.RoleID;
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.sp_prevent_delete_roles() OWNER TO erp_user;

--
-- Name: sp_prevent_delete_transaccionespasarela(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.sp_prevent_delete_transaccionespasarela() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE TransaccionesPasarela SET Activo = FALSE WHERE TransaccionID = OLD.TransaccionID;
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.sp_prevent_delete_transaccionespasarela() OWNER TO erp_user;

--
-- Name: sp_prevent_delete_usuarioroles(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.sp_prevent_delete_usuarioroles() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE UsuarioRoles SET Activo = FALSE WHERE UsuarioRoleID = OLD.UsuarioRoleID;
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.sp_prevent_delete_usuarioroles() OWNER TO erp_user;

--
-- Name: sp_prevent_delete_usuarios(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.sp_prevent_delete_usuarios() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Usuarios SET Activo = FALSE WHERE UsuarioID = OLD.UsuarioID;
    RETURN NULL; -- Prevenimos la eliminación física
END;
$$;


ALTER FUNCTION public.sp_prevent_delete_usuarios() OWNER TO erp_user;

--
-- Name: sp_prevent_delete_ventas(); Type: FUNCTION; Schema: public; Owner: erp_user
--

CREATE FUNCTION public.sp_prevent_delete_ventas() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE Ventas SET Activo = FALSE WHERE VentaID = OLD.VentaID;
    RETURN NULL;
END;
$$;


ALTER FUNCTION public.sp_prevent_delete_ventas() OWNER TO erp_user;

--
-- Name: categoriasproducto_categoriaid_seq; Type: SEQUENCE; Schema: public; Owner: erp_user
--

CREATE SEQUENCE public.categoriasproducto_categoriaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categoriasproducto_categoriaid_seq OWNER TO erp_user;

--
-- Name: categoriasproducto_categoriaid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: erp_user
--

ALTER SEQUENCE public.categoriasproducto_categoriaid_seq OWNED BY public.categoriasproducto.categoriaid;


--
-- Name: clientes_clienteid_seq; Type: SEQUENCE; Schema: public; Owner: erp_user
--

CREATE SEQUENCE public.clientes_clienteid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clientes_clienteid_seq OWNER TO erp_user;

--
-- Name: clientes_clienteid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: erp_user
--

ALTER SEQUENCE public.clientes_clienteid_seq OWNED BY public.clientes.clienteid;


--
-- Name: cuentasporcobrar_cuentaid_seq; Type: SEQUENCE; Schema: public; Owner: erp_user
--

CREATE SEQUENCE public.cuentasporcobrar_cuentaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cuentasporcobrar_cuentaid_seq OWNER TO erp_user;

--
-- Name: cuentasporcobrar_cuentaid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: erp_user
--

ALTER SEQUENCE public.cuentasporcobrar_cuentaid_seq OWNED BY public.cuentasporcobrar.cuentaid;


--
-- Name: detalleventas_detalleid_seq; Type: SEQUENCE; Schema: public; Owner: erp_user
--

CREATE SEQUENCE public.detalleventas_detalleid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalleventas_detalleid_seq OWNER TO erp_user;

--
-- Name: detalleventas_detalleid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: erp_user
--

ALTER SEQUENCE public.detalleventas_detalleid_seq OWNED BY public.detalleventas.detalleid;


--
-- Name: facturas_facturaid_seq; Type: SEQUENCE; Schema: public; Owner: erp_user
--

CREATE SEQUENCE public.facturas_facturaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.facturas_facturaid_seq OWNER TO erp_user;

--
-- Name: facturas_facturaid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: erp_user
--

ALTER SEQUENCE public.facturas_facturaid_seq OWNED BY public.facturas.facturaid;


--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: erp_user
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO erp_user;

--
-- Name: metodospago_metodopagoid_seq; Type: SEQUENCE; Schema: public; Owner: erp_user
--

CREATE SEQUENCE public.metodospago_metodopagoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.metodospago_metodopagoid_seq OWNER TO erp_user;

--
-- Name: metodospago_metodopagoid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: erp_user
--

ALTER SEQUENCE public.metodospago_metodopagoid_seq OWNED BY public.metodospago.metodopagoid;


--
-- Name: pagos_pagoid_seq; Type: SEQUENCE; Schema: public; Owner: erp_user
--

CREATE SEQUENCE public.pagos_pagoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pagos_pagoid_seq OWNER TO erp_user;

--
-- Name: pagos_pagoid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: erp_user
--

ALTER SEQUENCE public.pagos_pagoid_seq OWNED BY public.pagos.pagoid;


--
-- Name: pasarelaspago_pasarelaid_seq; Type: SEQUENCE; Schema: public; Owner: erp_user
--

CREATE SEQUENCE public.pasarelaspago_pasarelaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pasarelaspago_pasarelaid_seq OWNER TO erp_user;

--
-- Name: pasarelaspago_pasarelaid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: erp_user
--

ALTER SEQUENCE public.pasarelaspago_pasarelaid_seq OWNED BY public.pasarelaspago.pasarelaid;


--
-- Name: productos_productoid_seq; Type: SEQUENCE; Schema: public; Owner: erp_user
--

CREATE SEQUENCE public.productos_productoid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productos_productoid_seq OWNER TO erp_user;

--
-- Name: productos_productoid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: erp_user
--

ALTER SEQUENCE public.productos_productoid_seq OWNED BY public.productos.productoid;


--
-- Name: reportefacturacionmensual; Type: VIEW; Schema: public; Owner: erp_user
--

CREATE VIEW public.reportefacturacionmensual AS
 SELECT to_char(f.fechaemision, 'YYYY-MM'::text) AS mes,
    sum(v.total) AS totalfacturado
   FROM (public.facturas f
     JOIN public.ventas v ON ((f.ventaid = v.ventaid)))
  WHERE ((f.activo = true) AND (v.activo = true))
  GROUP BY (to_char(f.fechaemision, 'YYYY-MM'::text));


ALTER VIEW public.reportefacturacionmensual OWNER TO erp_user;

--
-- Name: reportefacturacionmensualporcategoria; Type: VIEW; Schema: public; Owner: erp_user
--

CREATE VIEW public.reportefacturacionmensualporcategoria AS
 SELECT to_char(f.fechaemision, 'YYYY-MM'::text) AS mes,
    cp.nombre AS categoria,
    sum(dv.subtotal) AS totalfacturado
   FROM ((((public.facturas f
     JOIN public.ventas v ON ((f.ventaid = v.ventaid)))
     JOIN public.detalleventas dv ON ((v.ventaid = dv.ventaid)))
     JOIN public.productos p ON ((dv.productoid = p.productoid)))
     JOIN public.categoriasproducto cp ON ((p.categoriaid = cp.categoriaid)))
  WHERE ((f.activo = true) AND (v.activo = true) AND (dv.activo = true) AND (p.activo = true) AND (cp.activo = true))
  GROUP BY (to_char(f.fechaemision, 'YYYY-MM'::text)), cp.nombre
  ORDER BY (to_char(f.fechaemision, 'YYYY-MM'::text)), cp.nombre;


ALTER VIEW public.reportefacturacionmensualporcategoria OWNER TO erp_user;

--
-- Name: reportehistorialventas; Type: VIEW; Schema: public; Owner: erp_user
--

CREATE VIEW public.reportehistorialventas AS
 SELECT c.clienteid,
    c.nombre AS cliente,
    v.ventaid,
    v.fechaventa,
    v.total
   FROM (public.clientes c
     JOIN public.ventas v ON ((c.clienteid = v.clienteid)))
  WHERE ((c.activo = true) AND (v.activo = true));


ALTER VIEW public.reportehistorialventas OWNER TO erp_user;

--
-- Name: roles_roleid_seq; Type: SEQUENCE; Schema: public; Owner: erp_user
--

CREATE SEQUENCE public.roles_roleid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_roleid_seq OWNER TO erp_user;

--
-- Name: roles_roleid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: erp_user
--

ALTER SEQUENCE public.roles_roleid_seq OWNED BY public.roles.roleid;


--
-- Name: transaccionespasarela_transaccionid_seq; Type: SEQUENCE; Schema: public; Owner: erp_user
--

CREATE SEQUENCE public.transaccionespasarela_transaccionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transaccionespasarela_transaccionid_seq OWNER TO erp_user;

--
-- Name: transaccionespasarela_transaccionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: erp_user
--

ALTER SEQUENCE public.transaccionespasarela_transaccionid_seq OWNED BY public.transaccionespasarela.transaccionid;


--
-- Name: usuarioroles; Type: TABLE; Schema: public; Owner: erp_user
--

CREATE TABLE public.usuarioroles (
    usuarioroleid integer NOT NULL,
    usuarioid integer NOT NULL,
    roleid integer NOT NULL,
    fechaasignacion timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public.usuarioroles OWNER TO erp_user;

--
-- Name: usuarioroles_usuarioroleid_seq; Type: SEQUENCE; Schema: public; Owner: erp_user
--

CREATE SEQUENCE public.usuarioroles_usuarioroleid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarioroles_usuarioroleid_seq OWNER TO erp_user;

--
-- Name: usuarioroles_usuarioroleid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: erp_user
--

ALTER SEQUENCE public.usuarioroles_usuarioroleid_seq OWNED BY public.usuarioroles.usuarioroleid;


--
-- Name: usuarios_usuarioid_seq; Type: SEQUENCE; Schema: public; Owner: erp_user
--

CREATE SEQUENCE public.usuarios_usuarioid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_usuarioid_seq OWNER TO erp_user;

--
-- Name: usuarios_usuarioid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: erp_user
--

ALTER SEQUENCE public.usuarios_usuarioid_seq OWNED BY public.usuarios.usuarioid;


--
-- Name: ventas_ventaid_seq; Type: SEQUENCE; Schema: public; Owner: erp_user
--

CREATE SEQUENCE public.ventas_ventaid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ventas_ventaid_seq OWNER TO erp_user;

--
-- Name: ventas_ventaid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: erp_user
--

ALTER SEQUENCE public.ventas_ventaid_seq OWNED BY public.ventas.ventaid;


--
-- Name: viewusuarioroles; Type: VIEW; Schema: public; Owner: erp_user
--

CREATE VIEW public.viewusuarioroles AS
 SELECT u.usuarioid,
    u.nombreusuario,
    array_agg(r.nombre ORDER BY ur.fechaasignacion) AS roles
   FROM ((public.usuarios u
     LEFT JOIN public.usuarioroles ur ON (((u.usuarioid = ur.usuarioid) AND (ur.activo = true))))
     LEFT JOIN public.roles r ON (((ur.roleid = r.roleid) AND (r.activo = true))))
  GROUP BY u.usuarioid, u.nombreusuario;


ALTER VIEW public.viewusuarioroles OWNER TO erp_user;

--
-- Name: categoriasproducto categoriaid; Type: DEFAULT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.categoriasproducto ALTER COLUMN categoriaid SET DEFAULT nextval('public.categoriasproducto_categoriaid_seq'::regclass);


--
-- Name: clientes clienteid; Type: DEFAULT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.clientes ALTER COLUMN clienteid SET DEFAULT nextval('public.clientes_clienteid_seq'::regclass);


--
-- Name: cuentasporcobrar cuentaid; Type: DEFAULT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.cuentasporcobrar ALTER COLUMN cuentaid SET DEFAULT nextval('public.cuentasporcobrar_cuentaid_seq'::regclass);


--
-- Name: detalleventas detalleid; Type: DEFAULT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.detalleventas ALTER COLUMN detalleid SET DEFAULT nextval('public.detalleventas_detalleid_seq'::regclass);


--
-- Name: facturas facturaid; Type: DEFAULT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.facturas ALTER COLUMN facturaid SET DEFAULT nextval('public.facturas_facturaid_seq'::regclass);


--
-- Name: metodospago metodopagoid; Type: DEFAULT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.metodospago ALTER COLUMN metodopagoid SET DEFAULT nextval('public.metodospago_metodopagoid_seq'::regclass);


--
-- Name: pagos pagoid; Type: DEFAULT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.pagos ALTER COLUMN pagoid SET DEFAULT nextval('public.pagos_pagoid_seq'::regclass);


--
-- Name: pasarelaspago pasarelaid; Type: DEFAULT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.pasarelaspago ALTER COLUMN pasarelaid SET DEFAULT nextval('public.pasarelaspago_pasarelaid_seq'::regclass);


--
-- Name: productos productoid; Type: DEFAULT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.productos ALTER COLUMN productoid SET DEFAULT nextval('public.productos_productoid_seq'::regclass);


--
-- Name: roles roleid; Type: DEFAULT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.roles ALTER COLUMN roleid SET DEFAULT nextval('public.roles_roleid_seq'::regclass);


--
-- Name: transaccionespasarela transaccionid; Type: DEFAULT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.transaccionespasarela ALTER COLUMN transaccionid SET DEFAULT nextval('public.transaccionespasarela_transaccionid_seq'::regclass);


--
-- Name: usuarioroles usuarioroleid; Type: DEFAULT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.usuarioroles ALTER COLUMN usuarioroleid SET DEFAULT nextval('public.usuarioroles_usuarioroleid_seq'::regclass);


--
-- Name: usuarios usuarioid; Type: DEFAULT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN usuarioid SET DEFAULT nextval('public.usuarios_usuarioid_seq'::regclass);


--
-- Name: ventas ventaid; Type: DEFAULT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.ventas ALTER COLUMN ventaid SET DEFAULT nextval('public.ventas_ventaid_seq'::regclass);


--
-- Data for Name: categoriasproducto; Type: TABLE DATA; Schema: public; Owner: erp_user
--

COPY public.categoriasproducto (categoriaid, nombre, descripcion, activo) FROM stdin;
1	Sin Clasificar	Categoría general para productos sin asignar	t
2	Electrónica	Dispositivos electrónicos, computadoras, periféricos	t
3	Ropa	Prendas de vestir y accesorios de moda	t
4	Alimentos	Productos comestibles y bebidas envasadas	t
5	Muebles	Artículos para hogar u oficina como mesas, sillas, estanterías	t
6	Limpieza	Productos de higiene, limpieza doméstica e industrial	t
7	Papelería	Útiles escolares, de oficina y artículos de escritura	t
8	Ferretería	Herramientas, materiales de construcción y artículos varios	t
9	Deportes	Equipamiento y ropa deportiva para diversas disciplinas	t
10	Juguetería	Juguetes, juegos didácticos y recreativos para niños	t
12	Fotografía y Video	Equipos y accesorios para captura de imagen y video	t
13	Diseño y Creatividad	Herramientas para creación gráfica, diseño y arte digital	t
14	Streaming y Producción	Equipos y kits para transmisión en vivo y producción multimedia	t
15	Almacenamiento y Respaldo	Dispositivos de almacenamiento portátil y protección de datos	t
16	Componentes de PC	Partes internas y hardware especializado para computadoras	t
17	Redes y Conectividad	Equipos para redes cableadas e inalámbricas	t
18	Movilidad y Wearables	Tecnología portátil como smartwatches y accesorios móviles	t
19	Seguridad y Vigilancia	Equipos para monitoreo, cámaras y control de seguridad	t
20	Energía y Carga	Dispositivos de alimentación eléctrica y respaldo	t
21	Mantenimiento y Herramientas	Kits y herramientas especializadas para soporte técnico	t
22	Impresión y Digitalización	Dispositivos multifunción para escaneo, copiado e impresión	t
23	Audio Profesional	Dispositivos de alta fidelidad para monitoreo, estudio o producción musical	t
24	Accesorios de Transporte	Bolsos, mochilas y maletines diseñados para dispositivos electrónicos	t
25	Tecnología Emergente	Prototipos y dispositivos poco convencionales que aún no son de uso masivo	t
26	Domótica y Automatización	Incluye soluciones tecnológicas orientadas a la automatización de entornos residenciales, comerciales o corporativos.	t
27	Realidad Virtual	Tecnología orientada a la creación de experiencias inmersivas mediante dispositivos como visores VR, gafas AR, sensores de movimiento y plataformas interactivas. Utilizada en entretenimiento, capacitación, simulación y entornos educativos avanzados.	t
11	Accesorios de Computadora	Periféricos y accesorios para equipos de cómputo	t
\.


--
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: erp_user
--

COPY public.clientes (clienteid, nombre, correo, telefono, direccion, fecharegistro, creadoporusuarioid, activo) FROM stdin;
1	Cliente_1	cliente1@example.com	70000001	Direccion_1	2025-06-12 17:56:52.304924	2	t
2	Cliente_2	cliente2@example.com	70000002	Direccion_2	2025-06-12 17:56:52.304924	3	t
3	Cliente_3	cliente3@example.com	70000003	Direccion_3	2025-06-12 17:56:52.304924	4	t
4	Cliente_4	cliente4@example.com	70000004	Direccion_4	2025-06-12 17:56:52.304924	5	t
5	Cliente_5	cliente5@example.com	70000005	Direccion_5	2025-06-12 17:56:52.304924	6	t
6	Cliente_6	cliente6@example.com	70000006	Direccion_6	2025-06-12 17:56:52.304924	7	t
7	Cliente_7	cliente7@example.com	70000007	Direccion_7	2025-06-12 17:56:52.304924	8	t
8	Cliente_8	cliente8@example.com	70000008	Direccion_8	2025-06-12 17:56:52.304924	9	t
9	Cliente_9	cliente9@example.com	70000009	Direccion_9	2025-06-12 17:56:52.304924	10	t
10	Cliente_10	cliente10@example.com	70000010	Direccion_10	2025-06-12 17:56:52.304924	1	t
11	Cliente_11	cliente11@example.com	70000011	Direccion_11	2025-06-12 17:56:52.304924	2	t
12	Cliente_12	cliente12@example.com	70000012	Direccion_12	2025-06-12 17:56:52.304924	3	t
13	Cliente_13	cliente13@example.com	70000013	Direccion_13	2025-06-12 17:56:52.304924	4	t
14	Cliente_14	cliente14@example.com	70000014	Direccion_14	2025-06-12 17:56:52.304924	5	t
15	Cliente_15	cliente15@example.com	70000015	Direccion_15	2025-06-12 17:56:52.304924	6	t
16	Cliente_16	cliente16@example.com	70000016	Direccion_16	2025-06-12 17:56:52.304924	7	t
17	Cliente_17	cliente17@example.com	70000017	Direccion_17	2025-06-12 17:56:52.304924	8	t
18	Cliente_18	cliente18@example.com	70000018	Direccion_18	2025-06-12 17:56:52.304924	9	t
19	Cliente_19	cliente19@example.com	70000019	Direccion_19	2025-06-12 17:56:52.304924	10	t
20	Cliente_20	cliente20@example.com	70000020	Direccion_20	2025-06-12 17:56:52.304924	1	t
21	Cliente_21	cliente21@example.com	70000021	Direccion_21	2025-06-12 17:56:52.304924	2	t
22	Cliente_22	cliente22@example.com	70000022	Direccion_22	2025-06-12 17:56:52.304924	3	t
23	Cliente_23	cliente23@example.com	70000023	Direccion_23	2025-06-12 17:56:52.304924	4	t
24	Cliente_24	cliente24@example.com	70000024	Direccion_24	2025-06-12 17:56:52.304924	5	t
25	Cliente_25	cliente25@example.com	70000025	Direccion_25	2025-06-12 17:56:52.304924	6	t
26	Cliente_26	cliente26@example.com	70000026	Direccion_26	2025-06-12 17:56:52.304924	7	t
27	Cliente_27	cliente27@example.com	70000027	Direccion_27	2025-06-12 17:56:52.304924	8	t
28	Cliente_28	cliente28@example.com	70000028	Direccion_28	2025-06-12 17:56:52.304924	9	t
29	Cliente_29	cliente29@example.com	70000029	Direccion_29	2025-06-12 17:56:52.304924	10	t
30	Cliente_30	cliente30@example.com	70000030	Direccion_30	2025-06-12 17:56:52.304924	1	t
31	Cliente_31	cliente31@example.com	70000031	Direccion_31	2025-06-12 17:56:52.304924	2	t
32	Cliente_32	cliente32@example.com	70000032	Direccion_32	2025-06-12 17:56:52.304924	3	t
33	Cliente_33	cliente33@example.com	70000033	Direccion_33	2025-06-12 17:56:52.304924	4	t
34	Cliente_34	cliente34@example.com	70000034	Direccion_34	2025-06-12 17:56:52.304924	5	t
35	Cliente_35	cliente35@example.com	70000035	Direccion_35	2025-06-12 17:56:52.304924	6	t
36	Cliente_36	cliente36@example.com	70000036	Direccion_36	2025-06-12 17:56:52.304924	7	t
37	Cliente_37	cliente37@example.com	70000037	Direccion_37	2025-06-12 17:56:52.304924	8	t
38	Cliente_38	cliente38@example.com	70000038	Direccion_38	2025-06-12 17:56:52.304924	9	t
39	Cliente_39	cliente39@example.com	70000039	Direccion_39	2025-06-12 17:56:52.304924	10	t
40	Cliente_40	cliente40@example.com	70000040	Direccion_40	2025-06-12 17:56:52.304924	1	t
41	Cliente_41	cliente41@example.com	70000041	Direccion_41	2025-06-12 17:56:52.304924	2	t
42	Cliente_42	cliente42@example.com	70000042	Direccion_42	2025-06-12 17:56:52.304924	3	t
43	Cliente_43	cliente43@example.com	70000043	Direccion_43	2025-06-12 17:56:52.304924	4	t
44	Cliente_44	cliente44@example.com	70000044	Direccion_44	2025-06-12 17:56:52.304924	5	t
45	Cliente_45	cliente45@example.com	70000045	Direccion_45	2025-06-12 17:56:52.304924	6	t
46	Cliente_46	cliente46@example.com	70000046	Direccion_46	2025-06-12 17:56:52.304924	7	t
47	Cliente_47	cliente47@example.com	70000047	Direccion_47	2025-06-12 17:56:52.304924	8	t
48	Cliente_48	cliente48@example.com	70000048	Direccion_48	2025-06-12 17:56:52.304924	9	t
49	Cliente_49	cliente49@example.com	70000049	Direccion_49	2025-06-12 17:56:52.304924	10	t
50	Cliente_50	cliente50@example.com	70000050	Direccion_50	2025-06-12 17:56:52.304924	1	t
51	Cliente_51	cliente51@example.com	70000051	Direccion_51	2025-06-12 17:56:52.304924	2	t
52	Cliente_52	cliente52@example.com	70000052	Direccion_52	2025-06-12 17:56:52.304924	3	t
53	Cliente_53	cliente53@example.com	70000053	Direccion_53	2025-06-12 17:56:52.304924	4	t
54	Cliente_54	cliente54@example.com	70000054	Direccion_54	2025-06-12 17:56:52.304924	5	t
55	Cliente_55	cliente55@example.com	70000055	Direccion_55	2025-06-12 17:56:52.304924	6	t
56	Cliente_56	cliente56@example.com	70000056	Direccion_56	2025-06-12 17:56:52.304924	7	t
57	Cliente_57	cliente57@example.com	70000057	Direccion_57	2025-06-12 17:56:52.304924	8	t
58	Cliente_58	cliente58@example.com	70000058	Direccion_58	2025-06-12 17:56:52.304924	9	t
59	Cliente_59	cliente59@example.com	70000059	Direccion_59	2025-06-12 17:56:52.304924	10	t
60	Cliente_60	cliente60@example.com	70000060	Direccion_60	2025-06-12 17:56:52.304924	1	t
61	Cliente_61	cliente61@example.com	70000061	Direccion_61	2025-06-12 17:56:52.304924	2	t
62	Cliente_62	cliente62@example.com	70000062	Direccion_62	2025-06-12 17:56:52.304924	3	t
63	Cliente_63	cliente63@example.com	70000063	Direccion_63	2025-06-12 17:56:52.304924	4	t
64	Cliente_64	cliente64@example.com	70000064	Direccion_64	2025-06-12 17:56:52.304924	5	t
65	Cliente_65	cliente65@example.com	70000065	Direccion_65	2025-06-12 17:56:52.304924	6	t
66	Cliente_66	cliente66@example.com	70000066	Direccion_66	2025-06-12 17:56:52.304924	7	t
67	Cliente_67	cliente67@example.com	70000067	Direccion_67	2025-06-12 17:56:52.304924	8	t
68	Cliente_68	cliente68@example.com	70000068	Direccion_68	2025-06-12 17:56:52.304924	9	t
69	Cliente_69	cliente69@example.com	70000069	Direccion_69	2025-06-12 17:56:52.304924	10	t
70	Cliente_70	cliente70@example.com	70000070	Direccion_70	2025-06-12 17:56:52.304924	1	t
71	Cliente_71	cliente71@example.com	70000071	Direccion_71	2025-06-12 17:56:52.304924	2	t
72	Cliente_72	cliente72@example.com	70000072	Direccion_72	2025-06-12 17:56:52.304924	3	t
73	Cliente_73	cliente73@example.com	70000073	Direccion_73	2025-06-12 17:56:52.304924	4	t
74	Cliente_74	cliente74@example.com	70000074	Direccion_74	2025-06-12 17:56:52.304924	5	t
75	Cliente_75	cliente75@example.com	70000075	Direccion_75	2025-06-12 17:56:52.304924	6	t
76	Cliente_76	cliente76@example.com	70000076	Direccion_76	2025-06-12 17:56:52.304924	7	t
77	Cliente_77	cliente77@example.com	70000077	Direccion_77	2025-06-12 17:56:52.304924	8	t
78	Cliente_78	cliente78@example.com	70000078	Direccion_78	2025-06-12 17:56:52.304924	9	t
79	Cliente_79	cliente79@example.com	70000079	Direccion_79	2025-06-12 17:56:52.304924	10	t
80	Cliente_80	cliente80@example.com	70000080	Direccion_80	2025-06-12 17:56:52.304924	1	t
81	Cliente_81	cliente81@example.com	70000081	Direccion_81	2025-06-12 17:56:52.304924	2	t
82	Cliente_82	cliente82@example.com	70000082	Direccion_82	2025-06-12 17:56:52.304924	3	t
83	Cliente_83	cliente83@example.com	70000083	Direccion_83	2025-06-12 17:56:52.304924	4	t
84	Cliente_84	cliente84@example.com	70000084	Direccion_84	2025-06-12 17:56:52.304924	5	t
85	Cliente_85	cliente85@example.com	70000085	Direccion_85	2025-06-12 17:56:52.304924	6	t
86	Cliente_86	cliente86@example.com	70000086	Direccion_86	2025-06-12 17:56:52.304924	7	t
87	Cliente_87	cliente87@example.com	70000087	Direccion_87	2025-06-12 17:56:52.304924	8	t
88	Cliente_88	cliente88@example.com	70000088	Direccion_88	2025-06-12 17:56:52.304924	9	t
89	Cliente_89	cliente89@example.com	70000089	Direccion_89	2025-06-12 17:56:52.304924	10	t
90	Cliente_90	cliente90@example.com	70000090	Direccion_90	2025-06-12 17:56:52.304924	1	t
91	Cliente_91	cliente91@example.com	70000091	Direccion_91	2025-06-12 17:56:52.304924	2	t
92	Cliente_92	cliente92@example.com	70000092	Direccion_92	2025-06-12 17:56:52.304924	3	t
93	Cliente_93	cliente93@example.com	70000093	Direccion_93	2025-06-12 17:56:52.304924	4	t
94	Cliente_94	cliente94@example.com	70000094	Direccion_94	2025-06-12 17:56:52.304924	5	t
95	Cliente_95	cliente95@example.com	70000095	Direccion_95	2025-06-12 17:56:52.304924	6	t
96	Cliente_96	cliente96@example.com	70000096	Direccion_96	2025-06-12 17:56:52.304924	7	t
97	Cliente_97	cliente97@example.com	70000097	Direccion_97	2025-06-12 17:56:52.304924	8	t
98	Cliente_98	cliente98@example.com	70000098	Direccion_98	2025-06-12 17:56:52.304924	9	t
99	Cliente_99	cliente99@example.com	70000099	Direccion_99	2025-06-12 17:56:52.304924	10	t
100	Cliente_100	cliente100@example.com	70000100	Direccion_100	2025-06-12 17:56:52.304924	1	t
101	Cliente_101	cliente101@example.com	70000101	Direccion_101	2025-06-12 17:56:52.304924	2	t
102	Cliente_102	cliente102@example.com	70000102	Direccion_102	2025-06-12 17:56:52.304924	3	t
103	Cliente_103	cliente103@example.com	70000103	Direccion_103	2025-06-12 17:56:52.304924	4	t
104	Cliente_104	cliente104@example.com	70000104	Direccion_104	2025-06-12 17:56:52.304924	5	t
105	Cliente_105	cliente105@example.com	70000105	Direccion_105	2025-06-12 17:56:52.304924	6	t
106	Cliente_106	cliente106@example.com	70000106	Direccion_106	2025-06-12 17:56:52.304924	7	t
107	Cliente_107	cliente107@example.com	70000107	Direccion_107	2025-06-12 17:56:52.304924	8	t
108	Cliente_108	cliente108@example.com	70000108	Direccion_108	2025-06-12 17:56:52.304924	9	t
109	Cliente_109	cliente109@example.com	70000109	Direccion_109	2025-06-12 17:56:52.304924	10	t
110	Cliente_110	cliente110@example.com	70000110	Direccion_110	2025-06-12 17:56:52.304924	1	t
111	Cliente_111	cliente111@example.com	70000111	Direccion_111	2025-06-12 17:56:52.304924	2	t
112	Cliente_112	cliente112@example.com	70000112	Direccion_112	2025-06-12 17:56:52.304924	3	t
113	Cliente_113	cliente113@example.com	70000113	Direccion_113	2025-06-12 17:56:52.304924	4	t
114	Cliente_114	cliente114@example.com	70000114	Direccion_114	2025-06-12 17:56:52.304924	5	t
115	Cliente_115	cliente115@example.com	70000115	Direccion_115	2025-06-12 17:56:52.304924	6	t
116	Cliente_116	cliente116@example.com	70000116	Direccion_116	2025-06-12 17:56:52.304924	7	t
117	Cliente_117	cliente117@example.com	70000117	Direccion_117	2025-06-12 17:56:52.304924	8	t
118	Cliente_118	cliente118@example.com	70000118	Direccion_118	2025-06-12 17:56:52.304924	9	t
119	Cliente_119	cliente119@example.com	70000119	Direccion_119	2025-06-12 17:56:52.304924	10	t
120	Cliente_120	cliente120@example.com	70000120	Direccion_120	2025-06-12 17:56:52.304924	1	t
121	Cliente_121	cliente121@example.com	70000121	Direccion_121	2025-06-12 17:56:52.304924	2	t
122	Cliente_122	cliente122@example.com	70000122	Direccion_122	2025-06-12 17:56:52.304924	3	t
123	Cliente_123	cliente123@example.com	70000123	Direccion_123	2025-06-12 17:56:52.304924	4	t
124	Cliente_124	cliente124@example.com	70000124	Direccion_124	2025-06-12 17:56:52.304924	5	t
125	Cliente_125	cliente125@example.com	70000125	Direccion_125	2025-06-12 17:56:52.304924	6	t
126	Cliente_126	cliente126@example.com	70000126	Direccion_126	2025-06-12 17:56:52.304924	7	t
127	Cliente_127	cliente127@example.com	70000127	Direccion_127	2025-06-12 17:56:52.304924	8	t
128	Cliente_128	cliente128@example.com	70000128	Direccion_128	2025-06-12 17:56:52.304924	9	t
129	Cliente_129	cliente129@example.com	70000129	Direccion_129	2025-06-12 17:56:52.304924	10	t
130	Cliente_130	cliente130@example.com	70000130	Direccion_130	2025-06-12 17:56:52.304924	1	t
131	Cliente_131	cliente131@example.com	70000131	Direccion_131	2025-06-12 17:56:52.304924	2	t
132	Cliente_132	cliente132@example.com	70000132	Direccion_132	2025-06-12 17:56:52.304924	3	t
133	Cliente_133	cliente133@example.com	70000133	Direccion_133	2025-06-12 17:56:52.304924	4	t
134	Cliente_134	cliente134@example.com	70000134	Direccion_134	2025-06-12 17:56:52.304924	5	t
135	Cliente_135	cliente135@example.com	70000135	Direccion_135	2025-06-12 17:56:52.304924	6	t
136	Cliente_136	cliente136@example.com	70000136	Direccion_136	2025-06-12 17:56:52.304924	7	t
137	Cliente_137	cliente137@example.com	70000137	Direccion_137	2025-06-12 17:56:52.304924	8	t
138	Cliente_138	cliente138@example.com	70000138	Direccion_138	2025-06-12 17:56:52.304924	9	t
139	Cliente_139	cliente139@example.com	70000139	Direccion_139	2025-06-12 17:56:52.304924	10	t
140	Cliente_140	cliente140@example.com	70000140	Direccion_140	2025-06-12 17:56:52.304924	1	t
141	Cliente_141	cliente141@example.com	70000141	Direccion_141	2025-06-12 17:56:52.304924	2	t
142	Cliente_142	cliente142@example.com	70000142	Direccion_142	2025-06-12 17:56:52.304924	3	t
143	Cliente_143	cliente143@example.com	70000143	Direccion_143	2025-06-12 17:56:52.304924	4	t
144	Cliente_144	cliente144@example.com	70000144	Direccion_144	2025-06-12 17:56:52.304924	5	t
145	Cliente_145	cliente145@example.com	70000145	Direccion_145	2025-06-12 17:56:52.304924	6	t
146	Cliente_146	cliente146@example.com	70000146	Direccion_146	2025-06-12 17:56:52.304924	7	t
147	Cliente_147	cliente147@example.com	70000147	Direccion_147	2025-06-12 17:56:52.304924	8	t
148	Cliente_148	cliente148@example.com	70000148	Direccion_148	2025-06-12 17:56:52.304924	9	t
149	Cliente_149	cliente149@example.com	70000149	Direccion_149	2025-06-12 17:56:52.304924	10	t
150	Cliente_150	cliente150@example.com	70000150	Direccion_150	2025-06-12 17:56:52.304924	1	t
151	Cliente_151	cliente151@example.com	70000151	Direccion_151	2025-06-12 17:56:52.304924	2	t
152	Cliente_152	cliente152@example.com	70000152	Direccion_152	2025-06-12 17:56:52.304924	3	t
153	Cliente_153	cliente153@example.com	70000153	Direccion_153	2025-06-12 17:56:52.304924	4	t
154	Cliente_154	cliente154@example.com	70000154	Direccion_154	2025-06-12 17:56:52.304924	5	t
155	Cliente_155	cliente155@example.com	70000155	Direccion_155	2025-06-12 17:56:52.304924	6	t
156	Cliente_156	cliente156@example.com	70000156	Direccion_156	2025-06-12 17:56:52.304924	7	t
157	Cliente_157	cliente157@example.com	70000157	Direccion_157	2025-06-12 17:56:52.304924	8	t
158	Cliente_158	cliente158@example.com	70000158	Direccion_158	2025-06-12 17:56:52.304924	9	t
159	Cliente_159	cliente159@example.com	70000159	Direccion_159	2025-06-12 17:56:52.304924	10	t
160	Cliente_160	cliente160@example.com	70000160	Direccion_160	2025-06-12 17:56:52.304924	1	t
161	Cliente_161	cliente161@example.com	70000161	Direccion_161	2025-06-12 17:56:52.304924	2	t
162	Cliente_162	cliente162@example.com	70000162	Direccion_162	2025-06-12 17:56:52.304924	3	t
163	Cliente_163	cliente163@example.com	70000163	Direccion_163	2025-06-12 17:56:52.304924	4	t
164	Cliente_164	cliente164@example.com	70000164	Direccion_164	2025-06-12 17:56:52.304924	5	t
165	Cliente_165	cliente165@example.com	70000165	Direccion_165	2025-06-12 17:56:52.304924	6	t
166	Cliente_166	cliente166@example.com	70000166	Direccion_166	2025-06-12 17:56:52.304924	7	t
167	Cliente_167	cliente167@example.com	70000167	Direccion_167	2025-06-12 17:56:52.304924	8	t
168	Cliente_168	cliente168@example.com	70000168	Direccion_168	2025-06-12 17:56:52.304924	9	t
169	Cliente_169	cliente169@example.com	70000169	Direccion_169	2025-06-12 17:56:52.304924	10	t
170	Cliente_170	cliente170@example.com	70000170	Direccion_170	2025-06-12 17:56:52.304924	1	t
171	Cliente_171	cliente171@example.com	70000171	Direccion_171	2025-06-12 17:56:52.304924	2	t
172	Cliente_172	cliente172@example.com	70000172	Direccion_172	2025-06-12 17:56:52.304924	3	t
173	Cliente_173	cliente173@example.com	70000173	Direccion_173	2025-06-12 17:56:52.304924	4	t
174	Cliente_174	cliente174@example.com	70000174	Direccion_174	2025-06-12 17:56:52.304924	5	t
175	Cliente_175	cliente175@example.com	70000175	Direccion_175	2025-06-12 17:56:52.304924	6	t
176	Cliente_176	cliente176@example.com	70000176	Direccion_176	2025-06-12 17:56:52.304924	7	t
177	Cliente_177	cliente177@example.com	70000177	Direccion_177	2025-06-12 17:56:52.304924	8	t
178	Cliente_178	cliente178@example.com	70000178	Direccion_178	2025-06-12 17:56:52.304924	9	t
179	Cliente_179	cliente179@example.com	70000179	Direccion_179	2025-06-12 17:56:52.304924	10	t
180	Cliente_180	cliente180@example.com	70000180	Direccion_180	2025-06-12 17:56:52.304924	1	t
181	Cliente_181	cliente181@example.com	70000181	Direccion_181	2025-06-12 17:56:52.304924	2	t
182	Cliente_182	cliente182@example.com	70000182	Direccion_182	2025-06-12 17:56:52.304924	3	t
183	Cliente_183	cliente183@example.com	70000183	Direccion_183	2025-06-12 17:56:52.304924	4	t
184	Cliente_184	cliente184@example.com	70000184	Direccion_184	2025-06-12 17:56:52.304924	5	t
185	Cliente_185	cliente185@example.com	70000185	Direccion_185	2025-06-12 17:56:52.304924	6	t
186	Cliente_186	cliente186@example.com	70000186	Direccion_186	2025-06-12 17:56:52.304924	7	t
187	Cliente_187	cliente187@example.com	70000187	Direccion_187	2025-06-12 17:56:52.304924	8	t
188	Cliente_188	cliente188@example.com	70000188	Direccion_188	2025-06-12 17:56:52.304924	9	t
189	Cliente_189	cliente189@example.com	70000189	Direccion_189	2025-06-12 17:56:52.304924	10	t
190	Cliente_190	cliente190@example.com	70000190	Direccion_190	2025-06-12 17:56:52.304924	1	t
191	Cliente_191	cliente191@example.com	70000191	Direccion_191	2025-06-12 17:56:52.304924	2	t
192	Cliente_192	cliente192@example.com	70000192	Direccion_192	2025-06-12 17:56:52.304924	3	t
193	Cliente_193	cliente193@example.com	70000193	Direccion_193	2025-06-12 17:56:52.304924	4	t
194	Cliente_194	cliente194@example.com	70000194	Direccion_194	2025-06-12 17:56:52.304924	5	t
195	Cliente_195	cliente195@example.com	70000195	Direccion_195	2025-06-12 17:56:52.304924	6	t
196	Cliente_196	cliente196@example.com	70000196	Direccion_196	2025-06-12 17:56:52.304924	7	t
197	Cliente_197	cliente197@example.com	70000197	Direccion_197	2025-06-12 17:56:52.304924	8	t
198	Cliente_198	cliente198@example.com	70000198	Direccion_198	2025-06-12 17:56:52.304924	9	t
199	Cliente_199	cliente199@example.com	70000199	Direccion_199	2025-06-12 17:56:52.304924	10	t
200	Cliente_200	cliente200@example.com	70000200	Direccion_200	2025-06-12 17:56:52.304924	1	t
\.


--
-- Data for Name: cuentasporcobrar; Type: TABLE DATA; Schema: public; Owner: erp_user
--

COPY public.cuentasporcobrar (cuentaid, clienteid, ventaid, montopendiente, fechavencimiento, estado, activo) FROM stdin;
1	49	1	4933.56	2024-11-20 01:24:38.069028	Pendiente	t
2	169	2	2087.91	2025-06-05 11:54:02.280093	Vencido	t
3	1	3	0.00	2025-01-06 13:44:03.782775	Pagado	t
4	148	4	3672.18	2024-09-07 06:25:26.890937	Pendiente	t
5	56	5	112.24	2025-07-10 07:40:23.418473	Vencido	t
6	152	6	0.00	2024-08-25 04:41:22.485605	Pagado	t
7	48	7	4912.50	2024-09-05 17:49:12.249349	Pendiente	t
8	13	8	377.92	2024-09-25 09:25:24.218211	Vencido	t
9	85	9	0.00	2025-03-11 09:23:04.341216	Pagado	t
10	172	10	648.43	2025-01-19 15:27:06.190483	Pendiente	t
11	160	11	1481.34	2025-05-27 00:13:56.153278	Vencido	t
12	184	12	0.00	2024-10-29 03:49:16.823596	Pagado	t
13	115	13	2067.39	2024-10-18 09:37:34.431233	Pendiente	t
14	79	14	354.30	2024-08-20 06:28:56.033664	Vencido	t
15	130	15	0.00	2025-03-13 02:31:46.157647	Pagado	t
16	106	16	1023.00	2025-05-06 23:22:18.964497	Pendiente	t
17	194	17	978.18	2024-10-15 17:31:13.81861	Vencido	t
18	189	18	0.00	2025-06-21 08:21:00.892579	Pagado	t
19	52	19	4311.57	2025-01-04 14:45:50.265109	Pendiente	t
20	196	20	892.58	2025-03-05 03:10:18.555808	Vencido	t
21	80	21	0.00	2024-09-12 08:29:30.680831	Pagado	t
22	152	22	2504.14	2025-05-10 21:07:48.712224	Pendiente	t
23	141	23	180.67	2025-02-08 16:56:58.41632	Vencido	t
24	140	24	0.00	2024-12-06 12:12:58.835839	Pagado	t
25	63	25	2805.46	2025-07-07 10:01:02.681266	Pendiente	t
26	139	26	1114.86	2025-02-12 16:55:09.853847	Vencido	t
27	48	27	0.00	2024-10-06 06:56:33.751016	Pagado	t
28	109	28	3083.38	2024-12-27 16:02:44.786223	Pendiente	t
29	75	29	2446.51	2025-03-06 01:10:02.568059	Vencido	t
30	188	30	0.00	2025-06-02 02:55:55.204029	Pagado	t
31	35	31	750.48	2024-09-24 02:26:06.901653	Pendiente	t
32	76	32	71.08	2024-12-21 06:00:40.161255	Vencido	t
33	64	33	0.00	2024-11-03 12:40:58.369488	Pagado	t
34	108	34	2632.14	2024-09-17 23:22:44.402727	Pendiente	t
35	171	35	2209.23	2024-12-15 03:04:05.850434	Vencido	t
36	37	36	0.00	2025-01-24 19:58:13.35038	Pagado	t
37	190	37	5049.05	2024-08-08 01:16:30.435653	Pendiente	t
38	189	38	1599.14	2025-04-30 05:46:18.061187	Vencido	t
39	36	39	0.00	2025-04-02 11:32:59.375384	Pagado	t
40	164	40	657.34	2024-12-11 16:55:19.040428	Pendiente	t
41	12	41	347.62	2025-05-04 15:50:23.497701	Vencido	t
42	49	42	0.00	2024-10-04 11:25:29.310213	Pagado	t
43	200	43	2426.30	2025-05-20 15:53:39.430603	Pendiente	t
44	143	44	829.44	2025-02-22 21:15:33.3895	Vencido	t
45	156	45	0.00	2025-07-04 19:17:04.944672	Pagado	t
46	173	46	1486.64	2024-09-18 21:30:45.198263	Pendiente	t
47	33	47	1029.16	2025-03-08 14:25:10.048721	Vencido	t
48	43	48	0.00	2024-09-29 06:51:40.654376	Pagado	t
49	50	49	1437.19	2025-04-18 00:54:16.199965	Pendiente	t
50	9	50	1757.14	2024-09-23 05:04:08.349083	Vencido	t
51	90	51	0.00	2024-11-16 09:48:50.616652	Pagado	t
52	24	52	4439.60	2025-05-26 15:26:00.412434	Pendiente	t
53	184	53	607.64	2025-07-03 02:55:43.9948	Vencido	t
54	22	54	0.00	2025-04-05 09:18:29.273104	Pagado	t
55	159	55	2075.53	2024-07-19 05:03:02.447538	Pendiente	t
56	191	56	1017.05	2024-09-29 09:20:31.533823	Vencido	t
57	156	57	0.00	2024-12-14 06:36:38.156192	Pagado	t
58	52	58	2949.56	2024-08-15 20:50:25.734275	Pendiente	t
59	103	59	1268.97	2024-09-20 07:49:20.48509	Vencido	t
60	101	60	0.00	2025-05-10 12:54:55.677497	Pagado	t
61	99	61	4342.93	2025-06-22 11:25:03.720012	Pendiente	t
62	138	62	550.24	2025-06-13 11:04:57.845466	Vencido	t
63	122	63	0.00	2024-10-01 02:15:56.1114	Pagado	t
64	68	64	1697.52	2025-06-06 19:27:10.479602	Pendiente	t
65	112	65	997.49	2025-02-24 14:41:35.191917	Vencido	t
66	73	66	0.00	2025-01-18 12:49:58.475156	Pagado	t
67	166	67	2703.29	2024-12-19 02:55:36.753641	Pendiente	t
68	8	68	2416.07	2025-03-22 18:15:23.811676	Vencido	t
69	151	69	0.00	2024-09-15 04:38:58.18644	Pagado	t
70	43	70	3749.60	2025-05-11 23:21:41.166757	Pendiente	t
71	14	71	2134.76	2024-12-30 11:17:49.719509	Vencido	t
72	113	72	0.00	2025-03-19 19:07:52.269492	Pagado	t
73	39	73	4475.63	2025-02-26 16:49:03.498345	Pendiente	t
74	54	74	129.21	2025-04-26 10:44:01.185891	Vencido	t
75	174	75	0.00	2025-04-26 20:21:13.511128	Pagado	t
76	49	76	1614.23	2024-12-26 20:18:04.068113	Pendiente	t
77	65	77	2288.00	2025-05-20 20:45:37.48267	Vencido	t
78	180	78	0.00	2024-12-13 21:30:31.454707	Pagado	t
79	145	79	4642.96	2024-09-13 09:02:12.980273	Pendiente	t
80	88	80	242.44	2024-09-01 06:06:11.061152	Vencido	t
81	86	81	0.00	2024-11-29 09:11:24.222474	Pagado	t
82	120	82	3867.15	2024-12-19 23:00:16.822292	Pendiente	t
83	43	83	2011.00	2025-01-06 06:43:34.035926	Vencido	t
84	160	84	0.00	2025-05-14 10:08:04.057696	Pagado	t
85	166	85	506.74	2025-02-15 17:40:11.751796	Pendiente	t
86	14	86	1108.45	2025-06-19 04:42:08.654658	Vencido	t
87	84	87	0.00	2024-11-09 04:32:32.308309	Pagado	t
88	134	88	2803.27	2024-12-30 14:38:07.750399	Pendiente	t
89	55	89	1113.65	2024-08-09 12:24:52.308748	Vencido	t
90	144	90	0.00	2025-03-04 01:28:55.435968	Pagado	t
91	163	91	2304.07	2024-12-15 23:40:03.990536	Pendiente	t
92	139	92	70.29	2025-01-26 02:57:41.915086	Vencido	t
93	5	93	0.00	2025-05-31 01:07:37.829804	Pagado	t
94	88	94	1282.21	2024-11-05 11:41:03.685724	Pendiente	t
95	36	95	1773.05	2025-07-09 13:35:59.255167	Vencido	t
96	6	96	0.00	2025-03-08 14:51:49.458025	Pagado	t
97	191	97	931.15	2024-07-21 16:01:51.928668	Pendiente	t
98	66	98	1816.00	2024-11-17 17:34:32.708914	Vencido	t
99	101	99	0.00	2025-07-06 09:46:24.881154	Pagado	t
100	132	100	717.13	2025-02-07 16:42:59.394224	Pendiente	t
101	163	101	599.83	2025-07-07 05:58:56.915714	Vencido	t
102	84	102	0.00	2024-12-01 20:12:51.709855	Pagado	t
103	184	103	976.62	2024-11-02 11:18:57.801846	Pendiente	t
104	76	104	1154.97	2024-08-08 08:39:25.562199	Vencido	t
105	73	105	0.00	2025-06-03 08:13:40.636177	Pagado	t
106	75	106	2937.22	2024-07-26 03:53:54.294991	Pendiente	t
107	34	107	2084.69	2025-06-20 19:23:30.673326	Vencido	t
108	167	108	0.00	2024-11-16 22:17:49.986058	Pagado	t
109	64	109	1194.52	2024-08-21 11:36:50.544079	Pendiente	t
110	61	110	904.44	2025-01-20 15:31:50.928486	Vencido	t
111	137	111	0.00	2025-03-28 03:17:57.385619	Pagado	t
112	45	112	2628.37	2025-06-27 12:25:31.252621	Pendiente	t
113	175	113	1549.78	2024-10-06 17:30:10.341387	Vencido	t
114	47	114	0.00	2024-09-16 13:10:58.915161	Pagado	t
115	123	115	4815.51	2025-04-27 17:37:16.359342	Pendiente	t
116	99	116	1609.68	2025-04-22 01:33:08.811424	Vencido	t
117	52	117	0.00	2024-10-20 21:13:44.178926	Pagado	t
118	52	118	744.21	2024-12-07 09:28:39.534308	Pendiente	t
119	38	119	2040.88	2024-09-17 19:47:24.954631	Vencido	t
120	38	120	0.00	2025-03-23 09:48:16.047071	Pagado	t
121	67	121	3642.22	2024-11-08 20:51:38.185013	Pendiente	t
122	197	122	858.40	2025-01-03 09:12:14.50805	Vencido	t
123	152	123	0.00	2024-08-08 17:22:48.653762	Pagado	t
124	36	124	1264.07	2025-04-10 04:28:49.315107	Pendiente	t
125	47	125	1285.95	2025-03-14 04:50:47.117042	Vencido	t
126	173	126	0.00	2024-12-25 05:38:08.742028	Pagado	t
127	27	127	1074.44	2024-07-24 09:18:54.808434	Pendiente	t
128	150	128	158.41	2025-05-08 10:48:42.127627	Vencido	t
129	198	129	0.00	2024-08-08 14:36:17.028378	Pagado	t
130	21	130	3287.60	2024-08-19 10:31:25.649127	Pendiente	t
131	153	131	2477.85	2024-10-14 20:41:29.211508	Vencido	t
132	59	132	0.00	2025-03-02 19:34:27.566603	Pagado	t
133	103	133	2333.14	2025-01-18 13:25:43.525985	Pendiente	t
134	111	134	449.36	2024-11-09 02:13:45.166173	Vencido	t
135	36	135	0.00	2024-07-23 02:44:35.126114	Pagado	t
136	12	136	4158.13	2025-02-11 01:01:20.469237	Pendiente	t
137	96	137	1200.38	2025-04-09 11:17:24.953732	Vencido	t
138	31	138	0.00	2025-01-13 01:01:27.212123	Pagado	t
139	159	139	901.40	2025-05-09 02:03:58.45374	Pendiente	t
140	80	140	2365.47	2024-12-07 03:50:05.006368	Vencido	t
141	102	141	0.00	2025-02-12 10:20:25.080094	Pagado	t
142	3	142	4223.53	2024-12-10 04:48:43.042172	Pendiente	t
143	45	143	643.42	2025-04-25 04:24:16.552493	Vencido	t
144	92	144	0.00	2024-07-26 13:09:32.109905	Pagado	t
145	21	145	3248.42	2024-12-19 22:22:10.292134	Pendiente	t
146	129	146	1874.69	2025-07-07 18:44:43.248257	Vencido	t
147	100	147	0.00	2024-08-28 05:22:12.312986	Pagado	t
148	73	148	643.34	2024-09-14 16:42:51.420877	Pendiente	t
149	122	149	521.76	2024-09-27 03:52:28.628484	Vencido	t
150	113	150	0.00	2025-03-10 21:40:16.639511	Pagado	t
151	76	151	1733.23	2024-08-30 12:03:41.884275	Pendiente	t
152	161	152	167.54	2024-08-03 06:02:52.404961	Vencido	t
153	8	153	0.00	2024-09-20 21:56:35.023792	Pagado	t
154	26	154	4515.33	2024-09-05 13:28:24.037395	Pendiente	t
155	109	155	2009.20	2025-03-28 17:50:04.123343	Vencido	t
156	138	156	0.00	2024-12-04 15:57:08.420987	Pagado	t
157	104	157	3632.84	2024-11-14 22:01:21.167082	Pendiente	t
158	115	158	1038.00	2025-06-04 08:06:22.560916	Vencido	t
159	185	159	0.00	2024-11-02 04:42:52.884499	Pagado	t
160	91	160	839.53	2025-07-01 22:52:26.853225	Pendiente	t
161	166	161	534.85	2024-07-21 06:48:36.625867	Vencido	t
162	155	162	0.00	2025-03-20 06:40:57.725218	Pagado	t
163	169	163	2283.01	2025-05-11 15:20:01.272668	Pendiente	t
164	72	164	2117.20	2024-10-18 23:43:16.194872	Vencido	t
165	110	165	0.00	2025-01-20 03:34:23.632134	Pagado	t
166	190	166	1140.85	2025-06-27 08:59:45.329243	Pendiente	t
167	15	167	2144.65	2025-04-14 15:51:03.110279	Vencido	t
168	143	168	0.00	2025-04-01 00:44:08.770402	Pagado	t
169	150	169	2608.16	2024-11-15 23:22:57.139919	Pendiente	t
170	80	170	562.20	2024-11-05 05:12:03.364991	Vencido	t
171	151	171	0.00	2024-08-28 20:04:10.454221	Pagado	t
172	42	172	1096.75	2025-06-25 22:27:09.075399	Pendiente	t
173	161	173	462.43	2025-06-05 19:01:02.461161	Vencido	t
174	65	174	0.00	2024-08-06 11:44:22.609224	Pagado	t
175	170	175	3645.31	2024-09-21 14:54:04.332603	Pendiente	t
176	93	176	2297.37	2025-06-23 12:34:52.712164	Vencido	t
177	129	177	0.00	2025-02-03 02:57:43.864003	Pagado	t
178	72	178	2753.85	2024-09-01 20:56:03.817983	Pendiente	t
179	104	179	212.26	2025-01-26 09:27:33.141259	Vencido	t
180	82	180	0.00	2025-04-12 14:44:43.115328	Pagado	t
181	196	181	1719.88	2025-02-17 22:27:11.135593	Pendiente	t
182	170	182	1470.92	2025-05-20 09:40:24.835541	Vencido	t
183	96	183	0.00	2025-07-01 08:10:05.884777	Pagado	t
184	147	184	636.53	2024-12-06 04:41:18.026316	Pendiente	t
185	13	185	651.95	2024-12-18 11:04:58.574533	Vencido	t
186	55	186	0.00	2025-06-25 22:29:54.80587	Pagado	t
187	57	187	604.07	2024-10-11 09:00:28.033859	Pendiente	t
188	50	188	2193.37	2025-05-02 09:24:26.653493	Vencido	t
189	189	189	0.00	2025-07-12 16:14:52.393582	Pagado	t
190	199	190	3886.43	2024-11-27 13:57:08.556443	Pendiente	t
191	87	191	2504.83	2025-03-02 19:04:17.742236	Vencido	t
192	95	192	0.00	2025-07-03 18:59:42.696486	Pagado	t
193	106	193	2060.21	2025-07-09 19:46:09.649024	Pendiente	t
194	186	194	1374.18	2024-08-08 23:21:08.641878	Vencido	t
195	178	195	0.00	2025-05-31 06:58:35.607183	Pagado	t
196	82	196	2559.23	2025-01-26 22:42:12.311564	Pendiente	t
197	21	197	503.35	2024-08-06 13:37:26.292084	Vencido	t
198	174	198	0.00	2024-10-18 06:54:42.661777	Pagado	t
199	110	199	2023.17	2024-07-24 05:07:29.941689	Pendiente	t
200	64	200	2024.22	2024-09-07 00:45:36.406473	Vencido	t
201	57	201	0.00	2025-06-02 02:27:05.380306	Pagado	t
202	17	202	3316.12	2025-02-12 22:55:37.99433	Pendiente	t
203	144	203	2017.03	2025-01-13 11:24:17.827269	Vencido	t
204	151	204	0.00	2024-10-24 16:59:21.47458	Pagado	t
205	117	205	2271.04	2025-02-02 23:46:39.558289	Pendiente	t
206	137	206	2061.40	2024-09-15 15:06:26.742452	Vencido	t
207	193	207	0.00	2024-10-15 15:04:39.574911	Pagado	t
208	187	208	3940.21	2024-07-19 04:40:23.096177	Pendiente	t
209	137	209	269.91	2025-01-17 05:21:45.53193	Vencido	t
210	34	210	0.00	2025-01-24 22:46:18.802099	Pagado	t
211	163	211	2674.27	2024-11-28 03:34:53.292809	Pendiente	t
212	128	212	1222.45	2025-01-06 21:44:18.520615	Vencido	t
213	144	213	0.00	2024-08-11 02:58:00.166674	Pagado	t
214	167	214	901.36	2024-09-07 00:19:23.478214	Pendiente	t
215	154	215	106.23	2025-04-23 23:59:26.089749	Vencido	t
216	177	216	0.00	2025-02-04 11:28:37.65197	Pagado	t
217	82	217	3431.51	2025-04-30 00:26:42.002721	Pendiente	t
218	51	218	2171.05	2024-10-16 05:27:20.903079	Vencido	t
219	39	219	0.00	2024-12-09 20:39:08.492549	Pagado	t
220	98	220	4621.71	2025-01-07 05:13:47.697811	Pendiente	t
221	37	221	1337.49	2024-09-04 12:41:34.907822	Vencido	t
222	124	222	0.00	2025-01-13 00:19:18.736552	Pagado	t
223	105	223	2653.33	2025-06-21 15:11:55.34519	Pendiente	t
224	146	224	645.14	2025-01-18 00:47:31.688788	Vencido	t
225	19	225	0.00	2024-09-20 10:16:05.07805	Pagado	t
226	160	226	1296.33	2025-03-06 19:11:46.306149	Pendiente	t
227	8	227	958.45	2024-10-15 18:05:02.795048	Vencido	t
228	39	228	0.00	2024-12-17 20:16:51.515267	Pagado	t
229	29	229	936.60	2024-11-18 08:23:03.056405	Pendiente	t
230	119	230	1723.99	2025-05-03 08:36:48.820269	Vencido	t
231	123	231	0.00	2024-09-01 07:13:22.119695	Pagado	t
232	58	232	1295.05	2025-04-13 13:39:02.776455	Pendiente	t
233	6	233	59.66	2025-06-30 08:51:48.029413	Vencido	t
234	88	234	0.00	2024-09-04 12:53:56.666096	Pagado	t
235	120	235	4849.80	2024-12-01 20:03:24.193463	Pendiente	t
236	169	236	2258.35	2024-08-03 05:08:15.279798	Vencido	t
237	194	237	0.00	2025-01-22 09:46:36.6023	Pagado	t
238	148	238	4520.70	2025-04-05 11:50:01.505697	Pendiente	t
239	193	239	952.36	2024-08-16 18:51:41.710221	Vencido	t
240	148	240	0.00	2025-05-17 02:36:43.359354	Pagado	t
241	71	241	1145.28	2024-10-23 09:13:56.5905	Pendiente	t
242	198	242	2372.43	2025-03-09 14:24:44.399331	Vencido	t
243	89	243	0.00	2025-04-20 17:58:33.096818	Pagado	t
244	171	244	1640.72	2024-08-26 20:33:50.478679	Pendiente	t
245	89	245	1384.41	2024-10-16 22:28:36.574908	Vencido	t
246	189	246	0.00	2025-06-10 18:23:12.315656	Pagado	t
247	62	247	3301.56	2024-08-04 20:14:38.349282	Pendiente	t
248	44	248	1118.93	2025-02-17 17:55:22.903342	Vencido	t
249	31	249	0.00	2025-06-06 19:00:57.767271	Pagado	t
250	31	250	314.74	2025-03-28 10:30:12.35493	Pendiente	t
251	164	251	1863.83	2025-05-16 10:25:18.781479	Vencido	t
252	59	252	0.00	2025-01-04 01:07:50.390422	Pagado	t
253	159	253	4728.26	2025-06-08 02:42:12.122837	Pendiente	t
254	184	254	634.46	2024-09-13 11:37:21.202322	Vencido	t
255	7	255	0.00	2025-06-04 05:13:10.493817	Pagado	t
256	126	256	2051.63	2025-01-31 06:59:26.136857	Pendiente	t
257	145	257	609.71	2024-11-13 09:30:38.326024	Vencido	t
258	55	258	0.00	2024-11-06 16:54:10.993358	Pagado	t
259	172	259	1241.57	2025-04-08 21:56:11.512755	Pendiente	t
260	178	260	896.78	2025-02-09 00:06:52.999171	Vencido	t
261	18	261	0.00	2025-02-11 20:10:00.317767	Pagado	t
262	42	262	4525.31	2025-03-21 00:27:28.022376	Pendiente	t
263	165	263	2312.40	2025-04-15 01:44:54.551534	Vencido	t
264	12	264	0.00	2025-03-13 19:49:23.42701	Pagado	t
265	17	265	2302.61	2024-10-18 05:44:40.818518	Pendiente	t
266	145	266	1528.54	2025-01-16 11:43:49.956443	Vencido	t
267	11	267	0.00	2025-01-29 02:10:42.952456	Pagado	t
268	130	268	1113.17	2025-03-12 10:06:10.496953	Pendiente	t
269	99	269	1111.87	2025-06-15 04:56:29.514645	Vencido	t
270	75	270	0.00	2025-04-10 19:10:04.476437	Pagado	t
271	33	271	622.22	2024-08-09 10:46:59.78503	Pendiente	t
272	109	272	366.57	2025-06-12 17:24:29.188613	Vencido	t
273	158	273	0.00	2024-12-26 01:13:17.795406	Pagado	t
274	77	274	2920.86	2024-09-14 22:01:26.267453	Pendiente	t
275	138	275	1354.49	2025-03-28 09:44:23.469252	Vencido	t
276	3	276	0.00	2025-03-08 21:55:20.84371	Pagado	t
277	86	277	605.83	2025-03-29 14:20:07.465663	Pendiente	t
278	12	278	328.30	2025-01-20 15:26:10.294068	Vencido	t
279	113	279	0.00	2025-02-10 07:29:17.05373	Pagado	t
280	83	280	4691.86	2024-08-19 16:59:09.671926	Pendiente	t
281	188	281	76.05	2025-02-03 10:26:48.872544	Vencido	t
282	96	282	0.00	2025-04-13 01:31:27.530514	Pagado	t
283	175	283	477.74	2024-11-24 00:56:31.580408	Pendiente	t
284	21	284	1632.63	2024-09-17 16:12:31.662164	Vencido	t
285	146	285	0.00	2024-08-31 21:10:30.295159	Pagado	t
286	141	286	4808.99	2025-06-21 16:44:01.81562	Pendiente	t
287	110	287	2070.15	2024-08-06 00:20:47.450865	Vencido	t
288	196	288	0.00	2024-09-01 22:02:56.982838	Pagado	t
289	73	289	4555.98	2024-08-07 01:24:19.875325	Pendiente	t
290	126	290	1611.19	2025-01-11 08:49:28.261706	Vencido	t
291	134	291	0.00	2024-12-30 03:48:46.812144	Pagado	t
292	66	292	3358.18	2024-12-13 09:49:04.726954	Pendiente	t
293	28	293	2418.53	2024-08-23 10:18:38.930085	Vencido	t
294	13	294	0.00	2024-12-14 03:43:16.736719	Pagado	t
295	177	295	1503.14	2024-09-30 14:58:26.157828	Pendiente	t
296	160	296	1794.22	2024-12-11 09:56:42.082897	Vencido	t
297	144	297	0.00	2024-09-02 16:53:43.328025	Pagado	t
298	177	298	1204.14	2025-01-26 05:43:53.190824	Pendiente	t
299	92	299	968.94	2025-03-03 04:49:50.963233	Vencido	t
300	65	300	0.00	2024-10-26 13:27:06.578663	Pagado	t
301	186	301	4465.12	2024-12-03 15:52:31.405077	Pendiente	t
302	63	302	508.91	2024-11-17 07:41:25.545334	Vencido	t
303	63	303	0.00	2025-06-10 05:26:18.884905	Pagado	t
304	14	304	3997.52	2025-02-12 08:10:17.992268	Pendiente	t
305	28	305	998.14	2025-02-22 16:42:15.238683	Vencido	t
306	35	306	0.00	2025-03-21 22:32:10.054534	Pagado	t
307	55	307	4434.03	2025-06-13 07:41:34.730901	Pendiente	t
308	105	308	1120.09	2024-11-17 00:46:41.037727	Vencido	t
309	15	309	0.00	2024-09-17 11:43:50.359468	Pagado	t
310	140	310	4055.92	2024-09-24 01:02:42.87603	Pendiente	t
311	97	311	213.04	2024-12-22 22:16:46.203345	Vencido	t
312	22	312	0.00	2025-02-05 19:57:46.89449	Pagado	t
313	100	313	2991.31	2025-01-27 14:45:14.41455	Pendiente	t
314	174	314	2029.35	2024-10-19 15:43:29.632694	Vencido	t
315	165	315	0.00	2025-01-13 00:55:41.202223	Pagado	t
316	26	316	4234.68	2024-10-09 18:36:46.147356	Pendiente	t
317	6	317	1798.07	2024-08-15 20:27:23.966388	Vencido	t
318	15	318	0.00	2025-03-01 14:13:48.645505	Pagado	t
319	175	319	1626.72	2025-04-16 14:28:46.440953	Pendiente	t
320	151	320	807.07	2024-11-01 17:06:43.393289	Vencido	t
321	164	321	0.00	2025-06-21 20:35:17.722371	Pagado	t
322	171	322	1477.46	2025-05-18 12:28:23.046761	Pendiente	t
323	99	323	2100.83	2025-05-11 21:35:26.107591	Vencido	t
324	142	324	0.00	2025-02-20 11:21:07.667168	Pagado	t
325	21	325	3477.76	2024-11-22 11:51:02.565824	Pendiente	t
326	160	326	2225.64	2025-03-24 18:40:22.976042	Vencido	t
327	158	327	0.00	2024-11-17 02:04:08.666164	Pagado	t
328	177	328	4281.45	2024-08-06 11:28:52.03979	Pendiente	t
329	146	329	2288.14	2024-07-28 10:49:04.63924	Vencido	t
330	48	330	0.00	2024-07-16 18:17:39.887064	Pagado	t
331	76	331	2518.39	2025-04-17 17:35:02.472688	Pendiente	t
332	76	332	1103.95	2024-08-13 23:14:45.394591	Vencido	t
333	71	333	0.00	2025-06-06 18:21:17.9597	Pagado	t
334	114	334	1434.15	2025-07-06 21:22:49.1857	Pendiente	t
335	157	335	1722.45	2025-03-21 07:59:06.880985	Vencido	t
336	65	336	0.00	2025-06-22 07:48:41.465381	Pagado	t
337	47	337	4069.80	2024-11-21 03:50:00.884953	Pendiente	t
338	102	338	2356.36	2025-05-11 20:51:25.410246	Vencido	t
339	170	339	0.00	2024-11-16 08:20:14.459883	Pagado	t
340	165	340	1592.26	2024-08-27 10:41:01.850345	Pendiente	t
341	171	341	2241.44	2025-05-01 20:14:58.265653	Vencido	t
342	122	342	0.00	2025-05-11 21:06:22.495846	Pagado	t
343	169	343	3210.96	2025-04-22 14:15:57.158203	Pendiente	t
344	32	344	826.27	2024-08-07 16:45:53.8324	Vencido	t
345	73	345	0.00	2024-08-16 01:58:57.49504	Pagado	t
346	9	346	2346.83	2025-01-07 23:22:48.735615	Pendiente	t
347	81	347	86.42	2024-12-29 18:39:23.277732	Vencido	t
348	5	348	0.00	2024-08-27 04:20:43.015296	Pagado	t
349	168	349	3404.68	2025-02-04 08:27:50.183847	Pendiente	t
350	110	350	2320.31	2024-09-22 02:09:30.976879	Vencido	t
351	77	351	0.00	2025-06-20 09:58:50.629136	Pagado	t
352	58	352	946.87	2024-09-02 07:13:55.686974	Pendiente	t
353	69	353	1924.14	2025-04-30 01:25:21.105092	Vencido	t
354	112	354	0.00	2024-12-31 23:55:06.16551	Pagado	t
355	79	355	1397.48	2024-12-02 04:14:33.365246	Pendiente	t
356	36	356	487.62	2024-11-25 05:25:33.840627	Vencido	t
357	67	357	0.00	2025-04-14 01:30:03.531267	Pagado	t
358	43	358	2149.62	2024-12-22 10:31:45.360889	Pendiente	t
359	63	359	1905.13	2024-09-17 00:10:42.004516	Vencido	t
360	131	360	0.00	2024-10-21 03:30:41.005469	Pagado	t
361	182	361	3494.32	2024-07-14 04:21:27.590976	Pendiente	t
362	160	362	1546.01	2025-02-23 17:56:51.196333	Vencido	t
363	143	363	0.00	2024-12-21 00:41:27.423931	Pagado	t
364	194	364	3075.96	2024-11-28 19:54:05.505961	Pendiente	t
365	70	365	569.81	2024-09-11 15:01:44.334384	Vencido	t
366	113	366	0.00	2025-04-29 15:01:37.992485	Pagado	t
367	4	367	3077.61	2025-05-08 17:03:10.710455	Pendiente	t
368	3	368	1523.94	2024-09-02 06:08:06.221688	Vencido	t
369	33	369	0.00	2025-03-18 02:24:01.521278	Pagado	t
370	117	370	3082.45	2024-12-15 21:05:03.537456	Pendiente	t
371	178	371	1330.31	2025-04-04 15:11:41.679933	Vencido	t
372	199	372	0.00	2025-05-30 01:47:19.564812	Pagado	t
373	96	373	862.72	2024-08-27 23:39:21.436157	Pendiente	t
374	4	374	1681.96	2025-07-07 05:21:15.658701	Vencido	t
375	121	375	0.00	2024-10-23 16:57:40.457254	Pagado	t
376	98	376	1424.27	2025-03-11 12:43:19.142094	Pendiente	t
377	59	377	1682.15	2025-06-22 11:37:28.804801	Vencido	t
378	89	378	0.00	2025-02-10 10:39:30.499069	Pagado	t
379	31	379	1062.94	2025-05-31 20:59:39.277236	Pendiente	t
380	71	380	1365.76	2024-10-08 17:01:13.472663	Vencido	t
381	45	381	0.00	2025-05-15 13:18:25.671268	Pagado	t
382	183	382	4101.18	2024-11-07 21:20:17.478711	Pendiente	t
383	148	383	1811.92	2025-02-08 00:13:42.302845	Vencido	t
384	178	384	0.00	2025-01-22 12:25:42.229758	Pagado	t
385	18	385	222.97	2025-06-04 15:45:10.794467	Pendiente	t
386	90	386	401.93	2025-01-31 14:41:08.865974	Vencido	t
387	24	387	0.00	2024-11-24 21:56:53.178081	Pagado	t
388	64	388	2561.71	2024-12-20 04:59:06.060783	Pendiente	t
389	162	389	1846.94	2025-03-23 11:01:22.44974	Vencido	t
390	61	390	0.00	2025-01-09 06:30:09.069002	Pagado	t
391	26	391	2021.09	2025-06-15 04:49:15.513067	Pendiente	t
392	46	392	1014.36	2025-07-04 18:43:00.892966	Vencido	t
393	77	393	0.00	2025-07-03 03:30:10.069902	Pagado	t
394	200	394	819.39	2025-05-18 22:48:07.67426	Pendiente	t
395	194	395	1124.46	2024-11-27 21:06:10.788855	Vencido	t
396	176	396	0.00	2024-10-13 05:35:49.066823	Pagado	t
397	119	397	2163.07	2025-04-27 07:43:15.037904	Pendiente	t
398	181	398	1712.74	2024-08-27 07:45:28.457788	Vencido	t
399	114	399	0.00	2024-08-11 04:15:38.919317	Pagado	t
400	133	400	3938.74	2024-12-04 01:11:22.960719	Pendiente	t
401	111	401	859.54	2024-08-04 21:47:11.61699	Vencido	t
402	113	402	0.00	2024-10-16 12:54:00.471344	Pagado	t
403	173	403	2362.48	2025-02-24 14:37:13.743749	Pendiente	t
404	156	404	1998.03	2024-10-10 00:48:07.275218	Vencido	t
405	163	405	0.00	2025-02-12 16:10:07.094017	Pagado	t
406	158	406	1262.11	2025-01-03 20:24:38.175715	Pendiente	t
407	92	407	814.18	2025-01-25 17:13:29.53636	Vencido	t
408	190	408	0.00	2025-02-21 06:44:06.781574	Pagado	t
409	41	409	4035.65	2025-05-14 12:56:17.839316	Pendiente	t
410	46	410	1592.97	2025-01-08 11:55:44.231523	Vencido	t
411	47	411	0.00	2025-01-05 05:35:24.757919	Pagado	t
412	118	412	4567.02	2024-10-28 09:23:24.369469	Pendiente	t
413	130	413	1552.11	2024-12-04 11:57:39.872113	Vencido	t
414	109	414	0.00	2024-10-09 21:00:20.747576	Pagado	t
415	116	415	166.17	2025-01-04 01:58:38.634878	Pendiente	t
416	21	416	1565.91	2025-03-07 10:26:10.399138	Vencido	t
417	43	417	0.00	2024-10-20 07:42:06.465365	Pagado	t
418	120	418	4901.83	2024-11-08 03:08:14.084892	Pendiente	t
419	154	419	2476.54	2025-01-02 21:30:19.833446	Vencido	t
420	144	420	0.00	2024-11-17 17:42:33.055173	Pagado	t
421	164	421	3512.09	2024-09-02 22:01:59.445788	Pendiente	t
422	43	422	1108.16	2025-06-28 13:11:05.060605	Vencido	t
423	22	423	0.00	2024-08-10 07:21:46.537923	Pagado	t
424	59	424	1511.70	2025-03-21 08:46:21.646991	Pendiente	t
425	62	425	1432.36	2025-03-02 01:53:46.971347	Vencido	t
426	150	426	0.00	2025-04-14 15:32:11.705786	Pagado	t
427	148	427	4957.61	2025-02-05 08:40:39.612624	Pendiente	t
428	111	428	1149.27	2024-08-08 08:15:45.659471	Vencido	t
429	49	429	0.00	2024-10-22 18:14:37.507033	Pagado	t
430	80	430	4542.91	2024-10-13 00:00:16.950284	Pendiente	t
431	77	431	458.83	2025-02-03 14:48:21.903902	Vencido	t
432	124	432	0.00	2025-01-05 00:51:16.320039	Pagado	t
433	156	433	762.47	2025-05-16 15:41:23.10086	Pendiente	t
434	59	434	982.22	2024-07-27 01:48:36.575047	Vencido	t
435	68	435	0.00	2025-05-03 07:03:46.779366	Pagado	t
436	140	436	168.58	2024-11-14 05:26:09.728798	Pendiente	t
437	96	437	808.86	2025-05-24 12:11:35.590435	Vencido	t
438	25	438	0.00	2024-07-23 15:42:31.360195	Pagado	t
439	107	439	4242.10	2025-06-08 12:24:48.666901	Pendiente	t
440	70	440	1054.14	2025-01-28 20:19:35.826663	Vencido	t
441	35	441	0.00	2024-12-27 03:59:26.795702	Pagado	t
442	189	442	3623.42	2024-07-13 02:47:27.070535	Pendiente	t
443	160	443	2015.36	2025-04-19 21:30:51.774943	Vencido	t
444	182	444	0.00	2025-06-16 09:23:15.473387	Pagado	t
445	20	445	3831.85	2025-05-14 23:02:33.349654	Pendiente	t
446	121	446	1778.28	2024-10-23 10:58:12.974964	Vencido	t
447	76	447	0.00	2025-03-17 03:18:18.783227	Pagado	t
448	179	448	402.57	2025-07-05 06:37:24.415272	Pendiente	t
449	185	449	667.82	2024-10-05 22:22:57.598698	Vencido	t
450	70	450	0.00	2025-04-10 04:44:15.494469	Pagado	t
451	11	451	5039.43	2024-12-31 19:45:40.123173	Pendiente	t
452	161	452	1877.90	2024-10-29 13:49:58.991668	Vencido	t
453	108	453	0.00	2024-10-10 08:35:50.540735	Pagado	t
454	188	454	3695.84	2025-03-24 14:40:05.462208	Pendiente	t
455	98	455	2159.12	2025-01-06 19:30:21.597241	Vencido	t
456	8	456	0.00	2024-11-06 09:46:57.642949	Pagado	t
457	142	457	2970.22	2025-03-05 12:25:56.13271	Pendiente	t
458	108	458	1559.40	2024-08-25 18:22:18.28396	Vencido	t
459	128	459	0.00	2025-01-26 09:19:08.777883	Pagado	t
460	21	460	1867.98	2024-09-13 05:35:47.819194	Pendiente	t
461	160	461	1841.77	2025-05-20 05:37:39.808657	Vencido	t
462	101	462	0.00	2024-10-02 02:47:30.492729	Pagado	t
463	187	463	4633.31	2024-12-20 16:58:07.15825	Pendiente	t
464	199	464	748.53	2025-04-01 02:56:19.576924	Vencido	t
465	56	465	0.00	2025-02-18 21:33:57.722358	Pagado	t
466	149	466	770.86	2024-12-14 23:51:21.950763	Pendiente	t
467	139	467	277.24	2024-08-26 01:26:18.476607	Vencido	t
468	143	468	0.00	2024-10-13 04:46:18.742159	Pagado	t
469	160	469	3041.69	2024-11-29 04:48:14.044486	Pendiente	t
470	178	470	654.27	2025-02-05 18:54:01.707041	Vencido	t
471	7	471	0.00	2024-08-13 07:39:48.882539	Pagado	t
472	18	472	3262.77	2025-02-05 15:45:58.001711	Pendiente	t
473	10	473	414.99	2025-06-12 20:59:53.161336	Vencido	t
474	169	474	0.00	2025-01-27 23:52:44.511521	Pagado	t
475	15	475	1164.63	2025-04-21 12:56:15.284416	Pendiente	t
476	167	476	2208.09	2024-11-18 11:19:56.800343	Vencido	t
477	70	477	0.00	2024-09-05 10:09:57.92629	Pagado	t
478	22	478	1382.45	2024-12-29 05:38:37.918097	Pendiente	t
479	189	479	423.75	2025-01-03 10:07:50.229252	Vencido	t
480	73	480	0.00	2025-05-14 02:51:47.769014	Pagado	t
481	171	481	2226.90	2025-05-07 08:34:25.835245	Pendiente	t
482	4	482	1939.24	2024-12-28 15:14:36.02839	Vencido	t
483	114	483	0.00	2024-07-26 10:51:49.797845	Pagado	t
484	200	484	3056.46	2025-01-30 02:20:26.64526	Pendiente	t
485	74	485	1636.85	2024-09-09 09:29:59.813243	Vencido	t
486	170	486	0.00	2025-07-09 04:38:38.304246	Pagado	t
487	194	487	63.42	2024-12-09 16:59:54.690964	Pendiente	t
488	128	488	1837.03	2024-10-13 07:26:00.360024	Vencido	t
489	139	489	0.00	2024-10-27 23:11:44.67223	Pagado	t
490	95	490	4540.65	2024-12-03 11:08:46.683016	Pendiente	t
491	129	491	2270.44	2025-05-18 04:15:04.380744	Vencido	t
492	82	492	0.00	2025-03-14 05:16:29.977869	Pagado	t
493	195	493	3289.71	2025-06-23 21:23:32.283074	Pendiente	t
494	89	494	169.41	2024-07-31 17:10:34.491805	Vencido	t
495	14	495	0.00	2024-08-28 01:23:10.253051	Pagado	t
496	24	496	3969.53	2024-08-27 21:27:18.286868	Pendiente	t
497	115	497	1909.33	2024-12-08 13:20:31.502211	Vencido	t
498	144	498	0.00	2024-08-20 20:49:06.580043	Pagado	t
499	189	499	1724.37	2025-02-26 13:08:17.682113	Pendiente	t
500	29	500	1851.03	2025-01-14 15:50:35.591933	Vencido	t
501	94	501	0.00	2025-05-16 10:07:29.889492	Pagado	t
502	54	502	4837.44	2024-08-02 00:09:19.378701	Pendiente	t
503	167	503	1698.67	2024-10-31 06:36:44.38881	Vencido	t
504	200	504	0.00	2025-02-08 16:25:08.698888	Pagado	t
505	93	505	947.34	2025-01-14 21:12:35.058677	Pendiente	t
506	122	506	2519.57	2025-06-06 19:20:19.227598	Vencido	t
507	69	507	0.00	2025-01-26 15:43:32.123155	Pagado	t
508	63	508	1970.60	2025-04-02 02:17:38.529995	Pendiente	t
509	126	509	895.36	2024-08-27 10:42:10.625621	Vencido	t
510	47	510	0.00	2024-12-13 22:36:42.531075	Pagado	t
511	139	511	2730.03	2025-03-20 11:06:37.184834	Pendiente	t
512	33	512	1874.91	2025-05-07 11:11:25.371081	Vencido	t
513	117	513	0.00	2024-11-18 22:46:31.628925	Pagado	t
514	39	514	2417.72	2025-03-23 22:34:45.576354	Pendiente	t
515	87	515	2242.40	2024-09-23 21:56:32.707864	Vencido	t
516	10	516	0.00	2024-08-18 01:45:27.923021	Pagado	t
517	77	517	827.21	2025-04-13 09:37:51.834054	Pendiente	t
518	161	518	2098.01	2025-04-18 22:20:27.185845	Vencido	t
519	46	519	0.00	2025-03-06 15:26:43.959187	Pagado	t
520	60	520	4537.57	2024-10-26 10:55:49.161172	Pendiente	t
521	197	521	1182.47	2025-02-07 00:21:52.833971	Vencido	t
522	156	522	0.00	2025-01-20 09:41:55.695006	Pagado	t
523	102	523	4435.64	2024-08-01 07:03:46.515686	Pendiente	t
524	140	524	1228.05	2024-08-23 00:32:57.834306	Vencido	t
525	41	525	0.00	2025-03-22 09:32:33.75986	Pagado	t
526	146	526	3487.70	2024-12-20 00:00:28.5054	Pendiente	t
527	85	527	229.13	2025-06-21 20:34:44.812775	Vencido	t
528	4	528	0.00	2024-08-05 18:40:50.229362	Pagado	t
529	62	529	3877.96	2024-07-29 07:22:19.504167	Pendiente	t
530	42	530	328.11	2024-11-10 20:54:36.401408	Vencido	t
531	190	531	0.00	2025-04-24 17:47:52.761853	Pagado	t
532	38	532	2252.63	2025-02-14 14:54:32.576618	Pendiente	t
533	105	533	817.40	2024-07-24 18:22:46.573253	Vencido	t
534	1	534	0.00	2025-05-15 12:46:00.007647	Pagado	t
535	60	535	3854.45	2024-08-13 17:51:10.997291	Pendiente	t
536	136	536	286.10	2025-02-20 07:25:46.192746	Vencido	t
537	72	537	0.00	2025-06-14 01:21:42.012592	Pagado	t
538	28	538	4409.84	2025-04-24 22:35:09.417855	Pendiente	t
539	31	539	2214.55	2024-11-08 04:34:34.792045	Vencido	t
540	32	540	0.00	2024-09-29 17:13:03.809121	Pagado	t
541	174	541	4035.91	2024-11-14 17:02:22.966778	Pendiente	t
542	81	542	762.86	2024-09-21 16:31:24.660763	Vencido	t
543	99	543	0.00	2024-12-23 06:14:24.415552	Pagado	t
544	81	544	549.27	2025-01-13 02:56:02.969336	Pendiente	t
545	76	545	1387.62	2024-12-13 00:00:18.237262	Vencido	t
546	167	546	0.00	2024-12-08 16:28:20.494662	Pagado	t
547	182	547	1560.55	2024-11-02 04:05:46.768001	Pendiente	t
548	29	548	1303.54	2024-11-27 23:12:57.391325	Vencido	t
549	99	549	0.00	2025-03-29 12:11:57.873677	Pagado	t
550	140	550	100.49	2025-03-11 13:32:46.511732	Pendiente	t
551	41	551	1470.76	2024-11-05 02:44:54.221681	Vencido	t
552	169	552	0.00	2025-07-01 22:29:38.551416	Pagado	t
553	10	553	498.47	2025-05-16 01:15:58.984036	Pendiente	t
554	74	554	2346.96	2025-07-11 14:31:48.29327	Vencido	t
555	192	555	0.00	2024-12-24 19:20:49.699118	Pagado	t
556	84	556	2185.99	2025-02-05 12:49:28.020685	Pendiente	t
557	131	557	2110.51	2025-06-03 13:12:54.294466	Vencido	t
558	15	558	0.00	2024-12-14 03:53:43.150329	Pagado	t
559	192	559	600.34	2024-09-30 18:53:03.769342	Pendiente	t
560	57	560	795.96	2024-07-15 08:27:41.199109	Vencido	t
561	162	561	0.00	2025-06-30 16:34:12.783292	Pagado	t
562	93	562	1984.73	2025-04-07 09:50:51.906752	Pendiente	t
563	181	563	1479.77	2024-11-09 01:14:09.506612	Vencido	t
564	109	564	0.00	2024-10-11 02:47:25.794446	Pagado	t
565	17	565	458.58	2024-08-06 02:30:10.134787	Pendiente	t
566	9	566	1347.89	2024-08-26 04:24:00.140889	Vencido	t
567	6	567	0.00	2024-12-01 23:03:13.159037	Pagado	t
568	21	568	1019.85	2024-09-17 15:25:11.963855	Pendiente	t
569	42	569	698.99	2025-06-28 17:16:26.944897	Vencido	t
570	168	570	0.00	2024-09-24 09:59:27.177435	Pagado	t
571	119	571	974.91	2025-04-07 09:59:32.996636	Pendiente	t
572	103	572	2220.13	2025-01-10 09:53:46.095513	Vencido	t
573	55	573	0.00	2025-02-08 11:27:45.682774	Pagado	t
574	139	574	4352.27	2025-01-01 23:05:12.182035	Pendiente	t
575	44	575	384.43	2025-03-05 12:44:40.688613	Vencido	t
576	92	576	0.00	2024-09-19 21:48:01.133582	Pagado	t
577	195	577	2950.41	2025-02-23 20:05:33.21563	Pendiente	t
578	85	578	1483.30	2024-12-19 06:05:38.692007	Vencido	t
579	28	579	0.00	2025-04-25 03:32:33.975925	Pagado	t
580	199	580	4559.94	2025-03-26 13:15:53.512989	Pendiente	t
581	112	581	1206.36	2025-03-02 13:25:28.754245	Vencido	t
582	167	582	0.00	2025-06-30 15:57:06.679725	Pagado	t
583	197	583	4374.28	2024-08-07 18:27:58.274045	Pendiente	t
584	51	584	1493.85	2025-01-02 21:42:42.728073	Vencido	t
585	141	585	0.00	2024-09-22 11:21:29.755666	Pagado	t
586	76	586	106.10	2025-04-26 20:55:59.703279	Pendiente	t
587	88	587	2368.03	2025-05-13 04:29:27.675426	Vencido	t
588	150	588	0.00	2025-04-06 21:52:59.719729	Pagado	t
589	139	589	2190.43	2024-10-26 14:34:12.220326	Pendiente	t
590	42	590	2359.20	2024-09-13 13:02:48.135016	Vencido	t
591	184	591	0.00	2024-12-23 04:39:28.239129	Pagado	t
592	171	592	1602.46	2025-03-28 12:34:51.710067	Pendiente	t
593	178	593	834.34	2024-10-17 14:58:55.118626	Vencido	t
594	147	594	0.00	2024-07-22 03:07:26.853197	Pagado	t
595	87	595	4116.99	2024-08-11 17:49:23.881537	Pendiente	t
596	61	596	447.58	2025-02-05 11:02:58.018933	Vencido	t
597	99	597	0.00	2024-10-01 21:22:38.195006	Pagado	t
598	150	598	525.36	2024-08-14 03:07:53.765865	Pendiente	t
599	195	599	881.33	2025-04-09 14:12:46.065599	Vencido	t
600	108	600	0.00	2025-04-28 21:07:03.662513	Pagado	t
601	26	601	52.65	2025-03-27 04:17:38.522959	Pendiente	t
602	111	602	758.40	2024-07-17 18:08:01.213716	Vencido	t
603	28	603	0.00	2025-01-30 07:50:28.187526	Pagado	t
604	144	604	2454.12	2024-12-07 20:44:39.914646	Pendiente	t
605	113	605	2106.95	2025-02-20 09:28:20.292808	Vencido	t
606	3	606	0.00	2024-07-17 08:54:47.658245	Pagado	t
607	129	607	3086.25	2024-08-07 04:58:58.72225	Pendiente	t
608	163	608	2287.36	2025-01-10 13:31:25.649164	Vencido	t
609	148	609	0.00	2024-12-13 04:08:27.571045	Pagado	t
610	121	610	3957.27	2025-03-19 18:18:11.484787	Pendiente	t
611	113	611	1009.78	2025-02-09 08:56:48.685019	Vencido	t
612	81	612	0.00	2025-06-07 11:13:27.555028	Pagado	t
613	154	613	4846.42	2024-07-30 16:33:54.925746	Pendiente	t
614	123	614	166.40	2025-02-28 12:48:57.549487	Vencido	t
615	72	615	0.00	2024-11-21 04:48:44.523155	Pagado	t
616	136	616	3307.95	2024-12-08 17:27:00.270486	Pendiente	t
617	195	617	956.92	2024-12-31 12:57:58.151959	Vencido	t
618	181	618	0.00	2025-02-21 19:21:36.277656	Pagado	t
619	58	619	410.24	2025-05-04 16:05:29.295319	Pendiente	t
620	185	620	253.93	2024-12-26 09:15:10.361566	Vencido	t
621	195	621	0.00	2025-06-23 12:47:03.998601	Pagado	t
622	153	622	3322.95	2025-06-26 22:42:59.050896	Pendiente	t
623	61	623	312.25	2024-08-06 16:57:55.178516	Vencido	t
624	106	624	0.00	2025-06-29 10:19:18.138349	Pagado	t
625	74	625	4438.67	2025-03-02 02:43:15.542052	Pendiente	t
626	190	626	67.77	2025-04-20 12:34:59.629764	Vencido	t
627	143	627	0.00	2024-08-22 22:12:13.500637	Pagado	t
628	187	628	3267.77	2024-10-28 08:58:48.057858	Pendiente	t
629	60	629	1397.39	2025-01-19 12:56:02.502908	Vencido	t
630	164	630	0.00	2024-11-01 15:33:18.58379	Pagado	t
631	81	631	534.58	2024-07-21 09:42:45.749853	Pendiente	t
632	135	632	573.49	2025-02-06 02:50:51.050083	Vencido	t
633	31	633	0.00	2025-01-16 22:26:10.709754	Pagado	t
634	98	634	615.51	2024-10-27 02:21:48.869064	Pendiente	t
635	136	635	473.10	2025-01-16 22:41:50.48512	Vencido	t
636	179	636	0.00	2025-03-20 22:13:50.087829	Pagado	t
637	188	637	1387.46	2024-11-17 13:21:01.743298	Pendiente	t
638	36	638	442.03	2025-03-31 01:07:08.954593	Vencido	t
639	48	639	0.00	2024-10-22 09:57:13.777768	Pagado	t
640	83	640	637.74	2025-06-05 13:46:21.368042	Pendiente	t
641	189	641	1125.42	2024-07-23 16:10:40.97823	Vencido	t
642	63	642	0.00	2025-01-09 02:17:23.285993	Pagado	t
643	87	643	3232.15	2025-02-25 09:13:39.241469	Pendiente	t
644	7	644	485.94	2024-08-31 12:01:24.279936	Vencido	t
645	84	645	0.00	2024-09-16 17:14:32.907696	Pagado	t
646	109	646	1124.53	2024-11-03 07:02:25.944674	Pendiente	t
647	16	647	1013.95	2025-07-06 22:55:37.149245	Vencido	t
648	163	648	0.00	2025-01-12 18:27:19.145245	Pagado	t
649	175	649	4055.88	2025-03-01 09:08:47.081785	Pendiente	t
650	27	650	1317.77	2024-10-29 20:54:17.383158	Vencido	t
651	34	651	0.00	2025-02-04 06:18:22.245596	Pagado	t
652	130	652	3414.18	2025-02-07 03:14:46.469475	Pendiente	t
653	88	653	648.97	2024-09-23 20:49:03.576056	Vencido	t
654	143	654	0.00	2024-08-11 09:22:52.722592	Pagado	t
655	142	655	906.53	2024-10-02 18:40:24.658545	Pendiente	t
656	141	656	454.31	2024-10-17 03:24:02.421424	Vencido	t
657	27	657	0.00	2024-12-28 02:49:50.583703	Pagado	t
658	2	658	3241.33	2024-10-27 11:26:24.386166	Pendiente	t
659	51	659	1236.82	2024-12-28 05:04:22.860628	Vencido	t
660	78	660	0.00	2025-05-16 19:52:23.754699	Pagado	t
661	159	661	3155.94	2024-09-30 02:45:10.403143	Pendiente	t
662	119	662	486.80	2025-04-08 01:09:30.223826	Vencido	t
663	199	663	0.00	2025-04-23 23:57:17.226302	Pagado	t
664	148	664	2593.34	2024-09-29 01:10:34.180341	Pendiente	t
665	24	665	1897.49	2025-03-31 04:48:21.159341	Vencido	t
666	17	666	0.00	2025-05-28 15:18:07.597908	Pagado	t
667	48	667	658.24	2025-07-01 12:43:00.462415	Pendiente	t
668	94	668	2216.51	2024-12-27 22:00:16.510878	Vencido	t
669	6	669	0.00	2025-05-20 14:25:43.605053	Pagado	t
670	79	670	2361.09	2025-06-21 03:03:40.001219	Pendiente	t
671	129	671	93.46	2025-06-12 08:19:10.995025	Vencido	t
672	178	672	0.00	2025-06-01 19:03:44.161285	Pagado	t
673	10	673	1903.56	2024-12-05 07:50:24.64322	Pendiente	t
674	164	674	2511.15	2024-10-10 01:32:50.510007	Vencido	t
675	134	675	0.00	2024-10-05 16:38:33.587967	Pagado	t
676	77	676	632.41	2024-12-10 06:13:48.232411	Pendiente	t
677	43	677	1119.13	2024-10-27 08:20:35.382602	Vencido	t
678	93	678	0.00	2024-07-13 19:19:02.348498	Pagado	t
679	77	679	3693.57	2025-01-11 02:28:47.050435	Pendiente	t
680	37	680	1703.87	2025-03-21 08:09:02.175717	Vencido	t
681	73	681	0.00	2025-06-01 16:30:44.262211	Pagado	t
682	37	682	76.00	2025-07-03 05:17:32.869613	Pendiente	t
683	176	683	1297.19	2024-10-30 05:00:49.039948	Vencido	t
684	120	684	0.00	2024-10-27 14:46:27.528543	Pagado	t
685	115	685	2445.18	2025-02-10 21:43:35.165477	Pendiente	t
686	77	686	2094.37	2025-06-21 05:00:20.914175	Vencido	t
687	55	687	0.00	2025-02-01 05:54:23.722126	Pagado	t
688	115	688	2318.86	2024-11-21 02:13:25.779817	Pendiente	t
689	150	689	845.26	2024-11-19 07:59:53.204974	Vencido	t
690	121	690	0.00	2025-03-05 00:39:59.902258	Pagado	t
691	110	691	3947.16	2025-01-12 04:03:37.695589	Pendiente	t
692	87	692	2291.34	2025-04-09 01:36:26.725792	Vencido	t
693	102	693	0.00	2025-02-21 21:49:14.28235	Pagado	t
694	80	694	932.02	2024-12-20 04:12:22.355112	Pendiente	t
695	178	695	1544.92	2025-03-12 11:45:00.562109	Vencido	t
696	26	696	0.00	2024-12-29 01:40:32.911417	Pagado	t
697	70	697	4284.21	2024-11-04 00:45:46.291186	Pendiente	t
698	67	698	2520.40	2025-04-24 07:36:22.699265	Vencido	t
699	135	699	0.00	2024-12-27 05:25:32.832257	Pagado	t
700	3	700	4950.47	2025-03-08 07:39:46.436154	Pendiente	t
701	100	701	1202.53	2024-09-03 20:24:34.702874	Vencido	t
702	75	702	0.00	2024-08-16 23:59:17.090835	Pagado	t
703	4	703	3979.87	2024-08-21 06:47:53.622434	Pendiente	t
704	78	704	426.37	2025-02-07 15:08:50.565079	Vencido	t
705	70	705	0.00	2025-06-01 01:32:20.386954	Pagado	t
706	143	706	4910.90	2024-10-17 15:51:33.389502	Pendiente	t
707	27	707	417.22	2025-06-25 00:07:56.857101	Vencido	t
708	56	708	0.00	2025-01-24 11:55:44.681358	Pagado	t
709	30	709	1836.71	2024-09-07 16:23:36.54947	Pendiente	t
710	190	710	1139.04	2024-11-12 11:19:19.970748	Vencido	t
711	157	711	0.00	2024-08-25 11:45:23.663265	Pagado	t
712	71	712	2866.71	2025-07-09 12:46:30.714375	Pendiente	t
713	83	713	1463.18	2025-02-09 06:33:27.227271	Vencido	t
714	34	714	0.00	2024-11-19 10:41:50.052503	Pagado	t
715	11	715	1043.45	2024-11-04 08:22:11.219084	Pendiente	t
716	147	716	2322.28	2024-12-07 12:04:23.340577	Vencido	t
717	152	717	0.00	2025-03-19 12:01:37.855047	Pagado	t
718	79	718	1298.82	2025-02-10 17:36:53.875266	Pendiente	t
719	160	719	947.73	2025-04-01 00:48:53.468075	Vencido	t
720	47	720	0.00	2025-02-13 08:29:44.1226	Pagado	t
721	3	721	694.85	2024-08-05 00:03:37.207734	Pendiente	t
722	77	722	2132.79	2025-04-03 16:42:16.39389	Vencido	t
723	143	723	0.00	2024-11-15 02:29:11.141728	Pagado	t
724	35	724	2931.32	2024-11-17 10:16:14.716032	Pendiente	t
725	77	725	165.44	2025-01-11 12:06:59.33408	Vencido	t
726	187	726	0.00	2024-10-25 18:06:38.93978	Pagado	t
727	177	727	863.70	2025-01-24 14:52:31.500414	Pendiente	t
728	46	728	1123.69	2024-08-27 20:44:14.614763	Vencido	t
729	94	729	0.00	2024-10-04 01:18:22.551132	Pagado	t
730	138	730	3094.77	2025-02-04 22:11:51.348024	Pendiente	t
731	198	731	2441.73	2025-03-28 01:09:55.442321	Vencido	t
732	85	732	0.00	2024-08-10 18:41:27.323773	Pagado	t
733	98	733	354.81	2024-08-19 07:47:11.189722	Pendiente	t
734	37	734	2240.55	2025-06-13 00:10:21.118246	Vencido	t
735	198	735	0.00	2025-07-07 17:00:54.015095	Pagado	t
736	78	736	1922.55	2025-06-15 15:47:37.147061	Pendiente	t
737	156	737	1652.20	2025-02-13 08:49:04.259857	Vencido	t
738	125	738	0.00	2025-04-24 01:24:46.44164	Pagado	t
739	73	739	1376.85	2024-12-23 22:59:07.075107	Pendiente	t
740	56	740	472.51	2024-09-19 19:10:25.202352	Vencido	t
741	2	741	0.00	2024-08-18 18:05:29.336048	Pagado	t
742	21	742	2917.55	2024-08-21 02:21:20.746697	Pendiente	t
743	160	743	663.38	2025-06-30 12:19:36.485003	Vencido	t
744	32	744	0.00	2024-11-20 04:35:31.315619	Pagado	t
745	131	745	2953.54	2025-03-07 04:02:27.444844	Pendiente	t
746	52	746	2416.68	2025-05-01 05:44:12.599892	Vencido	t
747	62	747	0.00	2025-07-11 14:29:30.088685	Pagado	t
748	123	748	1218.92	2025-04-27 19:13:09.520041	Pendiente	t
749	38	749	1036.38	2024-07-23 08:54:49.805061	Vencido	t
750	140	750	0.00	2025-01-06 05:32:25.429349	Pagado	t
751	197	751	2125.44	2024-08-11 04:04:38.218159	Pendiente	t
752	116	752	1541.05	2025-02-10 02:44:24.874475	Vencido	t
753	81	753	0.00	2025-03-30 20:54:55.26304	Pagado	t
754	20	754	4532.98	2025-05-13 15:09:14.988399	Pendiente	t
755	93	755	2300.96	2024-07-25 23:37:50.67789	Vencido	t
756	50	756	0.00	2024-12-05 10:29:33.039005	Pagado	t
757	143	757	1102.54	2025-02-28 04:43:30.093101	Pendiente	t
758	37	758	1774.08	2024-08-01 07:04:13.070365	Vencido	t
759	169	759	0.00	2024-08-24 14:01:32.925716	Pagado	t
760	95	760	2304.89	2025-04-04 15:57:40.787708	Pendiente	t
761	114	761	1242.55	2025-03-01 03:58:37.740348	Vencido	t
762	148	762	0.00	2025-02-24 05:08:30.792522	Pagado	t
763	93	763	2638.40	2025-04-07 22:36:51.775524	Pendiente	t
764	187	764	790.49	2025-05-15 02:55:09.083778	Vencido	t
765	120	765	0.00	2024-09-26 17:24:07.097179	Pagado	t
766	68	766	411.61	2024-07-15 21:09:26.007899	Pendiente	t
767	191	767	360.52	2025-06-10 17:50:57.982162	Vencido	t
768	200	768	0.00	2025-02-12 15:26:05.457989	Pagado	t
769	186	769	4807.67	2024-11-23 15:11:46.336571	Pendiente	t
770	189	770	2434.02	2024-11-01 13:22:39.812783	Vencido	t
771	2	771	0.00	2024-08-21 20:05:10.562733	Pagado	t
772	132	772	841.61	2025-04-10 04:45:19.628086	Pendiente	t
773	99	773	842.38	2024-08-05 13:57:43.809482	Vencido	t
774	138	774	0.00	2024-08-28 17:57:44.683457	Pagado	t
775	37	775	843.11	2024-09-19 05:26:27.36098	Pendiente	t
776	88	776	2392.30	2025-01-27 12:15:09.203358	Vencido	t
777	99	777	0.00	2024-08-29 01:48:13.701368	Pagado	t
778	114	778	1036.04	2025-06-20 18:15:20.241125	Pendiente	t
779	135	779	1740.29	2024-08-24 06:46:56.701654	Vencido	t
780	80	780	0.00	2025-03-02 20:56:59.532981	Pagado	t
781	122	781	550.22	2024-09-11 16:19:04.692786	Pendiente	t
782	106	782	361.42	2025-03-07 14:37:36.789816	Vencido	t
783	57	783	0.00	2025-06-14 14:20:59.371516	Pagado	t
784	38	784	2590.06	2025-04-10 15:17:16.031276	Pendiente	t
785	101	785	1089.20	2025-01-05 19:37:14.310613	Vencido	t
786	4	786	0.00	2025-07-02 12:08:59.758678	Pagado	t
787	138	787	2959.49	2024-11-25 18:51:31.524591	Pendiente	t
788	23	788	2022.44	2024-08-26 15:10:18.780096	Vencido	t
789	23	789	0.00	2024-08-31 10:54:47.452626	Pagado	t
790	119	790	4035.40	2025-05-26 16:43:11.440794	Pendiente	t
791	55	791	2041.34	2025-06-14 19:43:23.561061	Vencido	t
792	51	792	0.00	2024-11-22 01:30:35.857103	Pagado	t
793	52	793	3965.95	2024-11-12 01:18:42.111316	Pendiente	t
794	72	794	252.30	2025-02-15 14:24:50.915787	Vencido	t
795	156	795	0.00	2024-12-30 09:15:34.816731	Pagado	t
796	66	796	3801.63	2025-03-25 20:31:19.040529	Pendiente	t
797	114	797	1098.02	2024-10-10 16:28:53.960897	Vencido	t
798	112	798	0.00	2024-07-23 23:41:14.624863	Pagado	t
799	150	799	1108.35	2025-05-09 04:48:33.78225	Pendiente	t
800	187	800	2150.44	2024-08-03 20:17:28.86588	Vencido	t
801	149	801	0.00	2025-06-03 12:29:43.972968	Pagado	t
802	164	802	3037.11	2025-02-10 07:24:15.191116	Pendiente	t
803	85	803	1658.88	2024-08-20 19:59:20.972529	Vencido	t
804	120	804	0.00	2025-04-23 19:01:20.047421	Pagado	t
805	46	805	3164.52	2025-06-28 14:32:16.281957	Pendiente	t
806	190	806	2174.96	2024-10-26 04:48:37.400136	Vencido	t
807	108	807	0.00	2025-01-13 02:13:57.646462	Pagado	t
808	52	808	435.73	2024-09-23 01:21:53.117348	Pendiente	t
809	116	809	1723.15	2024-08-29 18:40:31.304815	Vencido	t
810	31	810	0.00	2025-06-07 03:13:07.911683	Pagado	t
811	117	811	3561.31	2024-12-12 19:18:35.711075	Pendiente	t
812	80	812	1760.08	2025-02-20 01:51:25.201995	Vencido	t
813	176	813	0.00	2025-01-12 08:02:39.827291	Pagado	t
814	6	814	2039.40	2025-05-29 00:03:58.92788	Pendiente	t
815	194	815	458.23	2024-09-14 00:58:51.894141	Vencido	t
816	165	816	0.00	2024-11-21 14:30:33.259391	Pagado	t
817	94	817	999.48	2024-10-08 05:09:26.998159	Pendiente	t
818	181	818	314.98	2025-02-03 08:16:31.739835	Vencido	t
819	145	819	0.00	2025-05-16 19:12:33.622788	Pagado	t
820	99	820	1926.12	2025-06-29 19:03:33.942121	Pendiente	t
821	41	821	807.54	2025-03-29 09:24:56.629433	Vencido	t
822	99	822	0.00	2025-05-14 12:14:23.815123	Pagado	t
823	169	823	2986.81	2024-12-28 22:29:48.36347	Pendiente	t
824	127	824	1860.73	2024-10-25 05:54:48.100257	Vencido	t
825	59	825	0.00	2025-05-16 17:41:18.267292	Pagado	t
826	19	826	2823.88	2025-01-22 11:19:09.925487	Pendiente	t
827	56	827	1758.18	2024-10-15 15:27:07.345674	Vencido	t
828	89	828	0.00	2024-12-14 07:28:48.999225	Pagado	t
829	130	829	4628.59	2024-10-27 01:33:23.436454	Pendiente	t
830	70	830	1782.26	2025-02-16 18:50:58.670615	Vencido	t
831	175	831	0.00	2024-07-16 09:03:20.623997	Pagado	t
832	140	832	290.99	2025-03-03 08:46:27.89273	Pendiente	t
833	59	833	1553.36	2024-10-17 23:35:09.839498	Vencido	t
834	150	834	0.00	2024-12-12 06:27:40.215049	Pagado	t
835	175	835	940.31	2024-08-06 05:55:21.315481	Pendiente	t
836	21	836	621.27	2025-03-16 01:40:41.18674	Vencido	t
837	34	837	0.00	2025-07-11 02:57:52.38182	Pagado	t
838	6	838	1588.47	2025-02-02 17:20:08.7482	Pendiente	t
839	192	839	1420.57	2024-12-31 03:03:12.137166	Vencido	t
840	187	840	0.00	2025-06-01 13:24:26.031785	Pagado	t
841	3	841	1400.16	2025-01-07 02:34:08.656206	Pendiente	t
842	42	842	175.08	2025-04-29 09:28:53.161823	Vencido	t
843	133	843	0.00	2024-08-14 12:18:34.371353	Pagado	t
844	105	844	2121.70	2025-02-15 08:50:39.706549	Pendiente	t
845	101	845	2408.86	2024-09-16 23:20:16.174001	Vencido	t
846	58	846	0.00	2024-11-17 21:38:16.454641	Pagado	t
847	5	847	3764.79	2025-04-20 02:36:30.310379	Pendiente	t
848	92	848	2252.12	2024-09-04 03:38:09.692835	Vencido	t
849	24	849	0.00	2025-05-31 13:51:54.274788	Pagado	t
850	59	850	188.53	2024-08-14 13:31:43.002713	Pendiente	t
851	198	851	468.52	2024-09-06 22:01:26.828881	Vencido	t
852	29	852	0.00	2025-02-01 22:41:35.784237	Pagado	t
853	71	853	1065.53	2025-02-20 17:52:48.093639	Pendiente	t
854	123	854	173.29	2025-04-14 19:22:01.958389	Vencido	t
855	182	855	0.00	2025-05-25 00:43:00.28376	Pagado	t
856	134	856	2294.04	2025-04-04 12:16:35.004799	Pendiente	t
857	32	857	1365.21	2024-09-16 17:16:17.538739	Vencido	t
858	15	858	0.00	2025-06-09 14:16:55.447879	Pagado	t
859	33	859	2270.12	2024-09-08 18:43:38.524274	Pendiente	t
860	76	860	2391.60	2024-10-26 03:04:24.681906	Vencido	t
861	8	861	0.00	2025-06-25 00:31:13.552359	Pagado	t
862	109	862	488.51	2025-07-08 09:43:30.188823	Pendiente	t
863	135	863	594.90	2024-12-05 13:40:13.787704	Vencido	t
864	113	864	0.00	2024-12-06 00:44:25.471377	Pagado	t
865	91	865	2688.12	2025-05-02 08:18:23.95541	Pendiente	t
866	156	866	134.98	2025-02-17 13:30:17.063065	Vencido	t
867	189	867	0.00	2025-07-12 13:39:16.013764	Pagado	t
868	13	868	4157.49	2024-07-20 11:55:55.272408	Pendiente	t
869	32	869	333.57	2025-05-19 16:39:17.315384	Vencido	t
870	70	870	0.00	2024-10-08 09:34:55.16902	Pagado	t
871	188	871	210.71	2025-04-22 16:17:16.946393	Pendiente	t
872	118	872	1619.40	2024-10-11 02:10:37.572442	Vencido	t
873	71	873	0.00	2024-08-06 14:29:19.784977	Pagado	t
874	135	874	150.36	2024-10-12 23:52:21.577678	Pendiente	t
875	196	875	1342.37	2025-03-09 14:09:26.325501	Vencido	t
876	198	876	0.00	2025-03-03 02:13:20.711258	Pagado	t
877	147	877	2415.96	2025-07-01 12:10:07.002999	Pendiente	t
878	122	878	1270.11	2025-01-29 04:07:37.706631	Vencido	t
879	123	879	0.00	2024-10-18 07:56:08.930961	Pagado	t
880	19	880	3299.23	2024-11-10 01:25:56.274002	Pendiente	t
881	36	881	667.49	2025-05-03 07:09:49.577677	Vencido	t
882	86	882	0.00	2024-09-30 16:34:40.327148	Pagado	t
883	154	883	413.50	2025-04-07 11:39:28.756977	Pendiente	t
884	88	884	281.36	2025-04-06 19:10:44.437496	Vencido	t
885	52	885	0.00	2025-06-28 11:54:26.065268	Pagado	t
886	63	886	4350.65	2025-04-30 23:34:49.358291	Pendiente	t
887	159	887	1307.03	2024-11-27 22:50:14.266608	Vencido	t
888	92	888	0.00	2025-02-25 21:14:54.44681	Pagado	t
889	6	889	3139.97	2025-07-05 16:17:09.511856	Pendiente	t
890	29	890	1089.55	2025-05-26 05:54:26.02702	Vencido	t
891	157	891	0.00	2024-07-23 07:06:21.670649	Pagado	t
892	133	892	496.55	2025-01-24 07:46:16.187923	Pendiente	t
893	63	893	657.69	2025-05-15 12:40:41.703261	Vencido	t
894	77	894	0.00	2025-04-15 12:44:03.2399	Pagado	t
895	179	895	2530.07	2025-02-17 21:16:16.946013	Pendiente	t
896	7	896	2109.52	2025-04-12 11:38:46.11685	Vencido	t
897	44	897	0.00	2025-04-05 15:58:00.29646	Pagado	t
898	81	898	3149.39	2025-02-26 21:21:11.014862	Pendiente	t
899	144	899	351.87	2025-01-13 00:32:54.942373	Vencido	t
900	44	900	0.00	2024-09-15 19:05:55.194271	Pagado	t
901	166	901	4555.04	2024-07-17 01:22:32.416183	Pendiente	t
902	146	902	819.27	2024-11-24 17:02:25.191277	Vencido	t
903	143	903	0.00	2025-05-28 02:03:02.315203	Pagado	t
904	104	904	3471.33	2024-10-30 18:50:40.625867	Pendiente	t
905	144	905	933.63	2024-09-08 14:05:02.400695	Vencido	t
906	69	906	0.00	2025-05-22 22:26:19.516188	Pagado	t
907	193	907	290.25	2024-09-01 19:55:12.337376	Pendiente	t
908	154	908	858.77	2025-03-27 09:06:22.230489	Vencido	t
909	14	909	0.00	2025-02-06 13:52:08.688269	Pagado	t
910	6	910	1510.28	2024-09-30 10:32:12.964199	Pendiente	t
911	141	911	548.43	2025-02-18 11:56:20.716243	Vencido	t
912	108	912	0.00	2024-12-25 08:37:52.412902	Pagado	t
913	200	913	578.13	2025-04-29 03:11:14.764762	Pendiente	t
914	5	914	1088.77	2024-10-11 16:43:05.777134	Vencido	t
915	161	915	0.00	2024-12-08 02:46:02.30467	Pagado	t
916	160	916	4141.78	2025-06-09 21:35:00.504671	Pendiente	t
917	138	917	1020.13	2024-10-13 11:23:15.758012	Vencido	t
918	190	918	0.00	2025-06-04 06:00:00.208409	Pagado	t
919	196	919	536.06	2025-03-08 04:26:21.186373	Pendiente	t
920	11	920	960.10	2024-09-14 11:35:08.614171	Vencido	t
921	177	921	0.00	2024-07-22 09:23:10.010879	Pagado	t
922	126	922	3991.68	2025-01-31 15:33:17.098689	Pendiente	t
923	172	923	2157.54	2025-05-26 19:55:31.967074	Vencido	t
924	144	924	0.00	2024-12-15 21:17:44.344905	Pagado	t
925	160	925	1584.97	2025-06-09 03:40:50.628835	Pendiente	t
926	196	926	658.90	2024-10-21 20:16:16.133805	Vencido	t
927	156	927	0.00	2025-05-22 13:09:29.363791	Pagado	t
928	129	928	3912.36	2025-06-21 10:57:28.401727	Pendiente	t
929	138	929	1459.16	2025-03-24 18:18:20.23467	Vencido	t
930	152	930	0.00	2025-01-27 22:47:23.545002	Pagado	t
931	67	931	3046.32	2024-10-12 17:12:17.106402	Pendiente	t
932	187	932	732.37	2025-05-11 02:27:11.271925	Vencido	t
933	50	933	0.00	2025-06-21 06:26:03.854972	Pagado	t
934	171	934	2763.28	2025-05-10 15:27:59.822084	Pendiente	t
935	157	935	229.65	2025-02-20 22:53:47.937782	Vencido	t
936	28	936	0.00	2024-08-11 11:34:05.594794	Pagado	t
937	126	937	3916.07	2025-02-16 16:56:44.576015	Pendiente	t
938	104	938	2521.87	2025-03-02 01:04:56.345502	Vencido	t
939	183	939	0.00	2025-05-04 21:50:27.474779	Pagado	t
940	80	940	1831.46	2024-09-30 02:13:34.128054	Pendiente	t
941	189	941	426.93	2024-08-06 16:54:02.976946	Vencido	t
942	41	942	0.00	2025-03-28 13:10:45.014508	Pagado	t
943	186	943	171.02	2025-02-16 17:23:29.605151	Pendiente	t
944	167	944	427.52	2025-02-14 08:08:46.251405	Vencido	t
945	115	945	0.00	2024-12-09 13:50:19.532175	Pagado	t
946	11	946	4189.25	2025-05-31 21:26:33.334021	Pendiente	t
947	111	947	2353.65	2025-05-26 20:33:38.195175	Vencido	t
948	167	948	0.00	2024-12-02 11:47:13.033553	Pagado	t
949	168	949	4253.72	2025-01-01 01:55:45.355681	Pendiente	t
950	71	950	721.19	2024-11-22 15:45:51.872267	Vencido	t
951	104	951	0.00	2024-08-17 02:39:09.125496	Pagado	t
952	171	952	1705.41	2024-11-13 18:00:11.149426	Pendiente	t
953	43	953	586.19	2024-07-30 15:49:24.420296	Vencido	t
954	21	954	0.00	2024-11-13 15:33:27.788316	Pagado	t
955	128	955	2494.58	2024-09-19 12:48:59.658281	Pendiente	t
956	97	956	1338.64	2024-10-25 11:26:40.258812	Vencido	t
957	154	957	0.00	2025-06-30 19:58:25.718291	Pagado	t
958	200	958	2640.38	2024-09-03 04:37:42.537905	Pendiente	t
959	99	959	1759.68	2024-07-31 10:46:00.63781	Vencido	t
960	68	960	0.00	2024-10-07 17:44:25.891874	Pagado	t
961	189	961	4154.06	2024-11-04 06:46:00.034511	Pendiente	t
962	62	962	1190.30	2025-05-27 05:47:05.584898	Vencido	t
963	43	963	0.00	2024-12-07 16:27:19.951403	Pagado	t
964	44	964	1884.11	2025-02-17 21:39:04.453716	Pendiente	t
965	109	965	1487.64	2024-10-18 05:20:59.446459	Vencido	t
966	6	966	0.00	2024-12-19 09:10:03.748083	Pagado	t
967	14	967	1836.27	2025-04-15 16:21:14.6554	Pendiente	t
968	96	968	233.13	2024-07-17 07:50:26.819737	Vencido	t
969	30	969	0.00	2024-09-23 18:39:36.575038	Pagado	t
970	103	970	4033.03	2025-01-07 11:45:32.205961	Pendiente	t
971	136	971	1802.95	2025-03-20 18:06:56.68109	Vencido	t
972	80	972	0.00	2024-11-28 14:40:45.410147	Pagado	t
973	16	973	4581.38	2025-01-30 17:44:48.502915	Pendiente	t
974	30	974	1044.60	2024-07-24 04:21:10.878774	Vencido	t
975	186	975	0.00	2025-01-18 19:16:06.075777	Pagado	t
976	188	976	1637.84	2024-10-26 16:12:28.066615	Pendiente	t
977	68	977	1218.85	2025-01-04 02:05:57.108677	Vencido	t
978	58	978	0.00	2024-11-14 00:28:30.882048	Pagado	t
979	25	979	3538.83	2024-10-06 01:04:06.79614	Pendiente	t
980	140	980	898.68	2024-07-22 21:23:18.061199	Vencido	t
981	28	981	0.00	2025-05-22 07:20:32.092872	Pagado	t
982	78	982	59.11	2025-04-12 15:03:40.497858	Pendiente	t
983	137	983	2038.30	2025-04-29 06:42:50.261694	Vencido	t
984	61	984	0.00	2025-03-10 14:06:18.438315	Pagado	t
985	153	985	4368.09	2024-07-28 21:14:54.670474	Pendiente	t
986	32	986	1278.89	2025-06-29 02:16:03.525314	Vencido	t
987	163	987	0.00	2025-06-03 16:27:34.111749	Pagado	t
988	42	988	3589.61	2024-10-05 20:12:43.758877	Pendiente	t
989	123	989	2269.48	2024-08-09 05:12:14.183157	Vencido	t
990	89	990	0.00	2025-02-13 04:12:56.934352	Pagado	t
991	122	991	2139.63	2024-09-10 18:03:19.324194	Pendiente	t
992	22	992	2062.69	2024-08-10 02:42:01.982442	Vencido	t
993	25	993	0.00	2025-04-02 14:13:52.180414	Pagado	t
994	178	994	4945.13	2024-11-01 04:40:37.934587	Pendiente	t
995	183	995	832.35	2024-09-29 15:38:34.74578	Vencido	t
996	143	996	0.00	2024-12-06 03:05:37.182496	Pagado	t
997	64	997	4860.09	2024-10-05 00:51:50.497932	Pendiente	t
998	29	998	1312.44	2025-01-10 18:07:45.587061	Vencido	t
999	60	999	0.00	2025-02-26 08:30:21.213131	Pagado	t
1000	175	1000	4480.54	2025-06-25 05:42:25.163856	Pendiente	t
1001	113	1001	662.15	2025-01-28 14:38:00.595968	Vencido	t
1002	59	1002	0.00	2024-12-19 18:59:33.4707	Pagado	t
1003	196	1003	1990.27	2025-04-01 22:10:00.710931	Pendiente	t
1004	131	1004	258.70	2025-03-26 13:52:07.653661	Vencido	t
1005	36	1005	0.00	2025-07-10 00:28:52.457784	Pagado	t
1006	174	1006	4054.30	2024-11-29 08:53:32.552254	Pendiente	t
1007	70	1007	2060.48	2025-05-06 01:09:43.383278	Vencido	t
1008	181	1008	0.00	2024-10-29 18:11:45.883141	Pagado	t
1009	24	1009	4132.82	2024-10-10 21:31:06.204156	Pendiente	t
1010	34	1010	2385.42	2025-05-28 02:49:54.394396	Vencido	t
1011	16	1011	0.00	2025-04-22 00:26:27.667744	Pagado	t
1012	148	1012	4159.01	2024-07-24 02:01:58.976004	Pendiente	t
1013	9	1013	687.38	2024-10-10 08:57:32.940064	Vencido	t
1014	56	1014	0.00	2024-08-28 05:30:16.143439	Pagado	t
1015	175	1015	3763.40	2025-01-21 23:54:51.219084	Pendiente	t
1016	199	1016	298.85	2024-11-01 08:05:51.391758	Vencido	t
1017	15	1017	0.00	2025-01-26 13:47:25.671121	Pagado	t
1018	194	1018	2034.94	2024-10-15 12:39:06.146099	Pendiente	t
1019	72	1019	43.50	2025-05-13 04:37:01.452452	Vencido	t
1020	184	1020	0.00	2025-05-13 01:11:48.819172	Pagado	t
1021	72	1021	4451.02	2025-01-31 03:44:56.439023	Pendiente	t
1022	196	1022	944.48	2025-03-06 23:46:17.411026	Vencido	t
1023	24	1023	0.00	2025-02-14 10:32:57.787247	Pagado	t
1024	93	1024	2879.96	2025-05-13 06:58:13.339288	Pendiente	t
1025	67	1025	2300.49	2025-04-27 10:50:17.102498	Vencido	t
1026	10	1026	0.00	2024-10-31 16:04:26.894677	Pagado	t
1027	84	1027	2297.43	2025-06-04 12:13:26.233673	Pendiente	t
1028	61	1028	377.97	2025-02-06 00:06:24.305235	Vencido	t
1029	191	1029	0.00	2024-11-05 10:46:19.937445	Pagado	t
1030	42	1030	2413.73	2025-05-28 07:14:24.310938	Pendiente	t
1031	176	1031	992.79	2024-11-25 06:53:11.601186	Vencido	t
1032	2	1032	0.00	2025-01-17 00:27:25.506121	Pagado	t
1033	139	1033	3820.33	2024-11-26 04:09:30.481282	Pendiente	t
1034	140	1034	1793.81	2024-12-24 22:28:56.60552	Vencido	t
1035	30	1035	0.00	2024-10-13 15:43:09.80009	Pagado	t
1036	156	1036	2263.66	2025-04-21 19:57:17.650763	Pendiente	t
1037	131	1037	1823.21	2024-10-21 20:30:07.635579	Vencido	t
1038	51	1038	0.00	2024-08-22 12:40:49.576675	Pagado	t
1039	43	1039	4071.48	2024-09-20 19:46:18.699242	Pendiente	t
1040	20	1040	2164.91	2025-01-10 23:53:02.891022	Vencido	t
1041	25	1041	0.00	2024-08-14 14:26:22.810708	Pagado	t
1042	18	1042	1894.76	2025-02-14 21:01:42.234235	Pendiente	t
1043	120	1043	1192.61	2025-03-23 18:21:45.548658	Vencido	t
1044	4	1044	0.00	2025-06-28 10:58:37.078531	Pagado	t
1045	81	1045	2900.39	2025-03-17 21:02:40.27736	Pendiente	t
1046	154	1046	1441.74	2024-10-06 23:10:31.594218	Vencido	t
1047	136	1047	0.00	2025-06-25 22:30:37.721006	Pagado	t
1048	55	1048	1340.90	2024-09-28 07:06:52.357366	Pendiente	t
1049	5	1049	1583.94	2024-08-24 17:11:13.891938	Vencido	t
1050	135	1050	0.00	2024-12-29 02:43:00.348326	Pagado	t
1051	87	1051	168.52	2025-01-22 09:43:01.913104	Pendiente	t
1052	136	1052	1765.35	2024-12-05 09:07:45.053591	Vencido	t
1053	2	1053	0.00	2025-06-09 13:30:53.811368	Pagado	t
1054	2	1054	421.42	2025-02-28 03:18:03.924692	Pendiente	t
1055	77	1055	2370.10	2024-07-23 00:33:23.44695	Vencido	t
1056	142	1056	0.00	2024-12-16 13:02:51.398162	Pagado	t
1057	193	1057	139.12	2024-11-22 23:51:22.705441	Pendiente	t
1058	21	1058	1553.85	2025-01-16 22:06:53.814328	Vencido	t
1059	13	1059	0.00	2024-10-19 21:31:49.19151	Pagado	t
1060	89	1060	2525.96	2024-08-07 19:57:32.441269	Pendiente	t
1061	45	1061	1604.51	2025-06-13 02:50:39.568623	Vencido	t
1062	118	1062	0.00	2024-10-06 17:25:39.506316	Pagado	t
1063	131	1063	1142.02	2024-08-25 06:46:03.472771	Pendiente	t
1064	73	1064	217.76	2024-12-06 05:45:15.107414	Vencido	t
1065	150	1065	0.00	2024-10-29 19:09:12.947428	Pagado	t
1066	73	1066	4581.32	2025-04-04 02:17:54.206735	Pendiente	t
1067	167	1067	2339.58	2025-06-04 02:37:23.130877	Vencido	t
1068	73	1068	0.00	2025-02-10 20:38:51.192633	Pagado	t
1069	189	1069	5044.14	2025-06-13 00:15:06.902139	Pendiente	t
1070	163	1070	1244.98	2024-09-05 22:12:46.618583	Vencido	t
1071	128	1071	0.00	2025-06-22 17:24:03.145171	Pagado	t
1072	59	1072	429.64	2025-07-05 12:18:08.95174	Pendiente	t
1073	61	1073	493.83	2025-02-11 01:15:31.834038	Vencido	t
1074	74	1074	0.00	2024-07-26 01:09:50.614547	Pagado	t
1075	54	1075	1400.51	2024-12-22 08:25:25.642795	Pendiente	t
1076	93	1076	2435.65	2024-12-14 13:17:27.04053	Vencido	t
1077	139	1077	0.00	2024-08-15 19:12:00.663968	Pagado	t
1078	68	1078	3199.44	2024-12-04 15:25:42.569691	Pendiente	t
1079	130	1079	1689.55	2025-02-13 06:00:16.332351	Vencido	t
1080	60	1080	0.00	2024-07-18 07:21:24.385196	Pagado	t
1081	51	1081	2869.73	2025-07-05 07:11:08.047489	Pendiente	t
1082	140	1082	508.40	2024-10-10 00:54:01.18067	Vencido	t
1083	76	1083	0.00	2025-06-30 01:04:16.962388	Pagado	t
1084	192	1084	3650.72	2024-11-27 00:46:29.981691	Pendiente	t
1085	38	1085	898.91	2024-10-02 15:29:22.825646	Vencido	t
1086	110	1086	0.00	2024-09-16 22:03:00.671496	Pagado	t
1087	75	1087	4291.61	2025-03-12 04:05:19.376235	Pendiente	t
1088	170	1088	1197.55	2024-08-07 11:36:37.056377	Vencido	t
1089	138	1089	0.00	2024-08-22 16:25:52.257342	Pagado	t
1090	163	1090	2078.74	2025-05-23 01:03:54.863339	Pendiente	t
1091	120	1091	332.49	2025-01-29 17:47:52.940023	Vencido	t
1092	143	1092	0.00	2024-08-05 14:05:15.687702	Pagado	t
1093	186	1093	3766.55	2024-12-24 10:34:58.768624	Pendiente	t
1094	68	1094	251.36	2024-10-23 08:08:15.061733	Vencido	t
1095	200	1095	0.00	2025-04-25 00:18:54.481375	Pagado	t
1096	90	1096	510.40	2024-08-14 05:28:15.53257	Pendiente	t
1097	116	1097	609.73	2024-09-03 15:25:39.361671	Vencido	t
1098	8	1098	0.00	2024-10-18 15:45:13.868837	Pagado	t
1099	140	1099	1478.99	2025-02-17 14:48:03.434153	Pendiente	t
1100	107	1100	444.91	2024-08-11 20:53:01.4125	Vencido	t
1101	181	1101	0.00	2024-11-28 22:59:14.131385	Pagado	t
1102	189	1102	2564.37	2025-04-19 00:16:18.004177	Pendiente	t
1103	135	1103	1894.26	2025-03-18 04:38:31.809992	Vencido	t
1104	185	1104	0.00	2024-09-27 05:00:18.576065	Pagado	t
1105	194	1105	1441.75	2024-12-27 10:27:03.548502	Pendiente	t
1106	44	1106	1806.40	2024-11-01 05:16:52.828713	Vencido	t
1107	168	1107	0.00	2024-08-30 04:26:08.18889	Pagado	t
1108	174	1108	4149.38	2024-09-28 19:28:59.906877	Pendiente	t
1109	167	1109	409.11	2025-07-07 03:00:44.659475	Vencido	t
1110	187	1110	0.00	2024-11-15 23:41:39.453222	Pagado	t
1111	74	1111	1807.16	2025-02-06 21:21:20.386534	Pendiente	t
1112	26	1112	2319.48	2025-05-16 17:10:02.726262	Vencido	t
1113	135	1113	0.00	2024-08-20 20:07:04.286243	Pagado	t
1114	114	1114	1343.61	2024-07-29 21:34:31.055213	Pendiente	t
1115	142	1115	2260.46	2024-11-15 18:11:30.9162	Vencido	t
1116	63	1116	0.00	2025-06-10 05:26:09.487458	Pagado	t
1117	55	1117	3143.69	2024-09-09 03:47:49.813201	Pendiente	t
1118	126	1118	360.53	2024-10-22 21:29:15.636639	Vencido	t
1119	33	1119	0.00	2025-05-22 00:19:37.279644	Pagado	t
1120	63	1120	2067.52	2025-02-10 04:03:58.558302	Pendiente	t
1121	49	1121	149.47	2025-06-25 12:05:15.348518	Vencido	t
1122	94	1122	0.00	2024-07-20 11:45:53.56727	Pagado	t
1123	14	1123	75.49	2024-12-14 15:51:34.722143	Pendiente	t
1124	46	1124	2056.84	2025-03-26 21:35:08.774467	Vencido	t
1125	35	1125	0.00	2024-12-07 17:55:43.22369	Pagado	t
1126	131	1126	1334.32	2025-04-19 06:09:56.601995	Pendiente	t
1127	62	1127	782.80	2024-07-22 12:48:26.348651	Vencido	t
1128	58	1128	0.00	2025-01-14 06:59:30.103451	Pagado	t
1129	41	1129	3734.37	2025-06-18 20:39:22.820742	Pendiente	t
1130	177	1130	531.64	2024-07-24 01:06:21.190749	Vencido	t
1131	4	1131	0.00	2025-04-08 11:04:25.542595	Pagado	t
1132	154	1132	4596.91	2025-04-01 07:14:23.795287	Pendiente	t
1133	117	1133	1887.25	2024-11-03 22:02:30.976339	Vencido	t
1134	166	1134	0.00	2025-02-20 15:37:17.417859	Pagado	t
1135	54	1135	940.26	2025-06-07 02:15:53.891656	Pendiente	t
1136	29	1136	658.80	2024-09-13 20:25:48.112573	Vencido	t
1137	122	1137	0.00	2025-06-23 12:22:35.435384	Pagado	t
1138	38	1138	2815.58	2024-10-18 03:21:07.81708	Pendiente	t
1139	168	1139	1103.60	2024-07-28 21:29:16.36263	Vencido	t
1140	181	1140	0.00	2024-11-09 19:16:05.118433	Pagado	t
1141	127	1141	786.35	2024-10-05 17:32:53.422124	Pendiente	t
1142	149	1142	796.28	2025-05-07 03:24:39.078912	Vencido	t
1143	40	1143	0.00	2024-08-19 04:26:56.437638	Pagado	t
1144	190	1144	1947.92	2024-11-11 00:10:48.447244	Pendiente	t
1145	3	1145	1371.44	2024-11-12 12:30:14.774574	Vencido	t
1146	97	1146	0.00	2025-02-20 03:03:07.383703	Pagado	t
1147	183	1147	887.89	2025-01-28 17:55:55.743098	Pendiente	t
1148	62	1148	2156.59	2025-03-08 20:36:09.454383	Vencido	t
1149	23	1149	0.00	2024-07-19 09:54:01.955079	Pagado	t
1150	194	1150	1766.76	2025-04-14 14:27:25.21542	Pendiente	t
1151	159	1151	114.69	2024-12-03 10:28:42.646325	Vencido	t
1152	116	1152	0.00	2024-08-28 08:44:58.509502	Pagado	t
1153	176	1153	4449.88	2024-11-06 21:02:50.239826	Pendiente	t
1154	28	1154	2073.47	2024-11-28 22:39:35.02582	Vencido	t
1155	38	1155	0.00	2025-05-29 02:15:31.571923	Pagado	t
1156	38	1156	4053.99	2025-03-22 22:50:15.626829	Pendiente	t
1157	164	1157	510.98	2024-12-17 21:45:03.278994	Vencido	t
1158	40	1158	0.00	2024-10-29 11:04:17.616783	Pagado	t
1159	124	1159	1083.28	2024-11-21 23:43:43.897297	Pendiente	t
1160	70	1160	1843.63	2024-12-08 16:47:19.026016	Vencido	t
1161	136	1161	0.00	2025-04-30 04:33:25.852453	Pagado	t
1162	78	1162	2114.21	2024-07-16 22:19:40.634325	Pendiente	t
1163	170	1163	2067.39	2025-06-29 14:50:56.777168	Vencido	t
1164	75	1164	0.00	2024-07-30 08:07:53.528472	Pagado	t
1165	103	1165	4312.04	2025-05-13 10:54:10.342179	Pendiente	t
1166	164	1166	1081.37	2025-03-04 00:38:31.126553	Vencido	t
1167	148	1167	0.00	2025-07-06 04:33:02.020718	Pagado	t
1168	44	1168	815.91	2024-08-11 17:19:38.623042	Pendiente	t
1169	59	1169	2207.85	2025-03-30 10:52:19.877104	Vencido	t
1170	168	1170	0.00	2024-08-12 05:02:52.492133	Pagado	t
1171	72	1171	671.05	2024-09-27 11:37:24.455253	Pendiente	t
1172	121	1172	1676.95	2024-11-17 02:01:38.357962	Vencido	t
1173	135	1173	0.00	2025-02-07 10:44:54.099931	Pagado	t
1174	85	1174	2346.81	2025-01-14 02:50:58.601355	Pendiente	t
1175	164	1175	1328.99	2024-12-09 16:49:42.290048	Vencido	t
1176	43	1176	0.00	2025-06-02 21:54:48.06593	Pagado	t
1177	89	1177	2503.35	2025-07-11 04:13:27.868716	Pendiente	t
1178	60	1178	290.06	2025-06-25 22:39:05.254813	Vencido	t
1179	115	1179	0.00	2024-11-07 08:40:57.637825	Pagado	t
1180	186	1180	587.71	2025-05-20 00:04:10.19894	Pendiente	t
1181	179	1181	1885.28	2024-11-07 11:14:50.479501	Vencido	t
1182	11	1182	0.00	2025-01-23 05:02:19.019624	Pagado	t
1183	7	1183	2891.00	2025-01-22 17:02:17.49158	Pendiente	t
1184	29	1184	2453.84	2025-04-07 08:34:21.230196	Vencido	t
1185	110	1185	0.00	2025-05-20 22:15:25.256804	Pagado	t
1186	75	1186	1788.55	2025-06-10 20:16:18.259612	Pendiente	t
1187	25	1187	2122.76	2024-12-31 23:47:12.647021	Vencido	t
1188	138	1188	0.00	2024-08-24 14:55:36.82073	Pagado	t
1189	199	1189	2420.57	2025-04-27 19:47:20.121434	Pendiente	t
1190	42	1190	1055.62	2025-02-11 07:50:47.293382	Vencido	t
1191	103	1191	0.00	2024-11-13 13:35:47.525959	Pagado	t
1192	170	1192	2119.26	2025-01-17 19:34:44.344386	Pendiente	t
1193	4	1193	2183.79	2024-08-30 00:46:30.283116	Vencido	t
1194	163	1194	0.00	2024-12-04 17:26:43.964013	Pagado	t
1195	16	1195	1770.54	2024-08-09 17:06:13.17592	Pendiente	t
1196	30	1196	2131.05	2025-02-22 00:42:45.056958	Vencido	t
1197	74	1197	0.00	2025-04-08 18:52:56.696639	Pagado	t
1198	184	1198	4396.02	2025-03-31 10:25:01.484031	Pendiente	t
1199	136	1199	1643.80	2024-10-05 12:51:57.98033	Vencido	t
1200	133	1200	0.00	2025-02-27 19:52:19.49634	Pagado	t
1201	198	1201	1506.89	2024-12-27 00:03:26.430522	Pendiente	t
1202	73	1202	239.42	2025-03-12 11:53:49.538173	Vencido	t
1203	133	1203	0.00	2025-01-22 21:19:42.222684	Pagado	t
1204	33	1204	1290.53	2024-07-28 08:39:22.735134	Pendiente	t
1205	66	1205	2185.40	2025-05-22 07:20:46.547427	Vencido	t
1206	138	1206	0.00	2024-09-25 13:21:40.148881	Pagado	t
1207	83	1207	1884.12	2025-02-19 05:30:23.012008	Pendiente	t
1208	157	1208	1092.63	2025-01-15 10:12:21.017958	Vencido	t
1209	15	1209	0.00	2025-07-11 06:11:50.838896	Pagado	t
1210	191	1210	3035.85	2025-03-05 03:04:00.663794	Pendiente	t
1211	31	1211	891.66	2025-02-16 15:07:11.313818	Vencido	t
1212	88	1212	0.00	2025-01-09 03:25:22.827939	Pagado	t
1213	57	1213	4205.48	2024-12-04 16:33:49.35184	Pendiente	t
1214	129	1214	759.91	2024-08-27 23:18:20.432779	Vencido	t
1215	56	1215	0.00	2025-05-31 19:57:15.238793	Pagado	t
1216	148	1216	2559.85	2025-04-11 11:02:40.387335	Pendiente	t
1217	66	1217	2405.46	2024-07-26 16:51:01.014417	Vencido	t
1218	174	1218	0.00	2024-08-22 21:39:36.960115	Pagado	t
1219	158	1219	1105.91	2024-10-10 03:23:21.147279	Pendiente	t
1220	185	1220	1889.71	2025-03-03 01:09:51.002197	Vencido	t
1221	97	1221	0.00	2025-03-23 00:14:47.683139	Pagado	t
1222	165	1222	3708.72	2024-07-22 01:45:43.18929	Pendiente	t
1223	159	1223	1400.18	2024-11-06 02:23:44.156032	Vencido	t
1224	19	1224	0.00	2024-12-25 22:06:44.527118	Pagado	t
1225	134	1225	687.68	2024-07-16 12:50:22.819438	Pendiente	t
1226	111	1226	1621.09	2024-09-19 03:10:52.747612	Vencido	t
1227	142	1227	0.00	2025-01-16 22:41:11.638439	Pagado	t
1228	9	1228	4379.20	2024-07-13 18:27:39.168682	Pendiente	t
1229	172	1229	1009.27	2024-09-27 17:16:49.767194	Vencido	t
1230	6	1230	0.00	2024-12-13 02:49:38.75128	Pagado	t
1231	105	1231	3630.58	2024-11-07 02:08:43.19074	Pendiente	t
1232	62	1232	246.37	2024-07-31 12:29:22.860247	Vencido	t
1233	22	1233	0.00	2024-08-19 22:11:15.307208	Pagado	t
1234	82	1234	3043.11	2024-11-14 23:24:40.001107	Pendiente	t
1235	128	1235	832.36	2025-05-27 12:25:39.144959	Vencido	t
1236	173	1236	0.00	2024-12-20 11:34:13.530462	Pagado	t
1237	13	1237	675.86	2024-09-08 08:45:49.33803	Pendiente	t
1238	122	1238	1097.86	2024-09-05 09:59:25.303285	Vencido	t
1239	187	1239	0.00	2025-05-31 00:10:58.851798	Pagado	t
1240	53	1240	316.58	2024-08-27 15:34:27.172191	Pendiente	t
1241	35	1241	1532.06	2025-02-04 15:30:14.616306	Vencido	t
1242	3	1242	0.00	2025-06-30 17:31:06.885357	Pagado	t
1243	21	1243	2259.66	2024-10-07 17:20:35.664737	Pendiente	t
1244	108	1244	2493.26	2024-08-08 04:42:57.644505	Vencido	t
1245	3	1245	0.00	2025-07-01 03:28:02.169661	Pagado	t
1246	141	1246	1369.82	2025-01-26 00:42:48.889094	Pendiente	t
1247	96	1247	725.28	2025-05-06 10:55:43.766302	Vencido	t
1248	156	1248	0.00	2024-11-14 11:30:36.515273	Pagado	t
1249	131	1249	710.13	2025-02-19 18:49:06.295325	Pendiente	t
1250	13	1250	360.20	2024-11-27 05:15:03.493578	Vencido	t
1251	56	1251	0.00	2024-08-20 10:47:00.060311	Pagado	t
1252	91	1252	3137.69	2025-05-06 11:35:04.576654	Pendiente	t
1253	134	1253	1518.56	2024-10-12 03:44:28.044968	Vencido	t
1254	44	1254	0.00	2024-07-17 20:07:54.944373	Pagado	t
1255	43	1255	4508.11	2024-08-02 16:56:53.417922	Pendiente	t
1256	123	1256	1613.52	2025-01-20 19:49:01.873271	Vencido	t
1257	163	1257	0.00	2025-02-01 19:42:49.310421	Pagado	t
1258	8	1258	3036.91	2024-10-25 04:47:03.59622	Pendiente	t
1259	110	1259	2502.83	2025-01-06 22:13:44.250508	Vencido	t
1260	58	1260	0.00	2025-05-07 18:21:54.59146	Pagado	t
1261	180	1261	3714.54	2024-11-14 23:44:01.825088	Pendiente	t
1262	61	1262	1481.69	2024-10-16 06:57:10.721966	Vencido	t
1263	4	1263	0.00	2025-07-02 15:53:51.377573	Pagado	t
1264	46	1264	985.85	2025-03-23 09:39:51.257988	Pendiente	t
1265	143	1265	2489.55	2025-04-02 01:11:35.536254	Vencido	t
1266	178	1266	0.00	2025-01-20 13:42:27.793222	Pagado	t
1267	6	1267	3295.64	2024-07-26 07:55:13.766399	Pendiente	t
1268	133	1268	1506.59	2024-12-27 14:48:17.296974	Vencido	t
1269	137	1269	0.00	2025-03-03 10:12:24.937957	Pagado	t
1270	170	1270	4180.50	2024-08-21 03:13:51.966617	Pendiente	t
1271	100	1271	1675.74	2024-07-21 19:23:34.75385	Vencido	t
1272	52	1272	0.00	2025-03-13 08:52:20.895539	Pagado	t
1273	141	1273	4980.36	2024-07-26 00:33:54.547025	Pendiente	t
1274	168	1274	2503.19	2024-10-09 12:00:23.507187	Vencido	t
1275	65	1275	0.00	2025-02-25 01:08:13.373696	Pagado	t
1276	30	1276	1390.64	2025-02-24 06:24:06.665479	Pendiente	t
1277	47	1277	759.12	2025-03-04 00:30:23.699801	Vencido	t
1278	16	1278	0.00	2024-09-19 17:49:27.483468	Pagado	t
1279	192	1279	3979.29	2025-05-29 12:50:43.797051	Pendiente	t
1280	167	1280	2032.87	2024-10-12 17:33:43.749289	Vencido	t
1281	139	1281	0.00	2024-07-30 20:35:10.059207	Pagado	t
1282	4	1282	4374.07	2024-08-08 14:28:41.59565	Pendiente	t
1283	2	1283	245.74	2024-08-28 06:17:34.118859	Vencido	t
1284	44	1284	0.00	2025-03-24 02:11:57.335106	Pagado	t
1285	138	1285	1997.56	2024-10-21 09:55:58.976483	Pendiente	t
1286	140	1286	1932.61	2025-06-12 13:19:25.418533	Vencido	t
1287	87	1287	0.00	2025-05-23 10:45:37.813556	Pagado	t
1288	49	1288	3598.14	2025-04-19 23:40:21.724207	Pendiente	t
1289	5	1289	207.08	2025-06-02 13:10:39.098706	Vencido	t
1290	28	1290	0.00	2025-04-15 10:38:22.40259	Pagado	t
1291	21	1291	2193.84	2025-05-06 07:54:27.798183	Pendiente	t
1292	34	1292	2091.13	2025-03-20 08:23:15.956329	Vencido	t
1293	14	1293	0.00	2024-12-05 04:31:02.851294	Pagado	t
1294	36	1294	301.49	2024-12-01 15:33:11.0978	Pendiente	t
1295	44	1295	1764.95	2025-03-23 00:25:04.881273	Vencido	t
1296	65	1296	0.00	2024-07-14 06:56:56.537669	Pagado	t
1297	88	1297	1218.72	2024-12-18 13:08:04.495367	Pendiente	t
1298	180	1298	1855.54	2025-01-01 19:35:22.731914	Vencido	t
1299	26	1299	0.00	2024-09-21 18:27:40.524127	Pagado	t
1300	135	1300	818.35	2024-09-18 16:51:04.726719	Pendiente	t
1301	141	1301	2407.89	2025-03-03 05:11:08.462712	Vencido	t
1302	13	1302	0.00	2024-08-30 23:10:00.164736	Pagado	t
1303	42	1303	1365.47	2024-12-13 11:48:05.213387	Pendiente	t
1304	21	1304	2316.27	2025-04-21 04:05:44.358104	Vencido	t
1305	48	1305	0.00	2024-12-11 18:49:06.221322	Pagado	t
1306	125	1306	2370.57	2025-01-09 05:23:35.952514	Pendiente	t
1307	171	1307	75.79	2024-07-31 02:37:33.692115	Vencido	t
1308	200	1308	0.00	2025-01-20 07:00:23.214829	Pagado	t
1309	200	1309	2650.23	2024-10-18 00:58:23.350175	Pendiente	t
1310	140	1310	304.99	2024-09-16 05:01:11.237825	Vencido	t
1311	192	1311	0.00	2024-09-13 14:44:49.939579	Pagado	t
1312	155	1312	1949.08	2025-06-03 02:04:42.865901	Pendiente	t
1313	181	1313	460.61	2025-05-19 18:24:56.026745	Vencido	t
1314	65	1314	0.00	2024-11-07 17:39:41.71711	Pagado	t
1315	140	1315	3148.51	2025-01-28 00:20:17.999046	Pendiente	t
1316	82	1316	1710.73	2025-01-15 12:54:14.607512	Vencido	t
1317	200	1317	0.00	2025-04-02 14:53:50.933421	Pagado	t
1318	117	1318	2944.63	2025-03-01 15:35:40.247253	Pendiente	t
1319	38	1319	674.17	2025-04-14 10:54:39.072722	Vencido	t
1320	161	1320	0.00	2025-01-05 17:39:01.363856	Pagado	t
1321	27	1321	3622.60	2025-05-21 00:06:08.856053	Pendiente	t
1322	34	1322	2038.60	2024-11-24 22:01:00.264954	Vencido	t
1323	117	1323	0.00	2024-11-12 04:09:37.604546	Pagado	t
1324	98	1324	4767.26	2025-05-23 03:25:30.437942	Pendiente	t
1325	115	1325	1320.28	2024-10-14 21:24:48.375957	Vencido	t
1326	168	1326	0.00	2025-05-12 18:30:59.157967	Pagado	t
1327	35	1327	3886.59	2025-03-20 10:37:18.6374	Pendiente	t
1328	173	1328	1485.40	2024-12-03 13:55:30.50621	Vencido	t
1329	160	1329	0.00	2024-07-24 07:32:14.387648	Pagado	t
1330	4	1330	2967.66	2025-04-02 14:44:30.193829	Pendiente	t
1331	92	1331	1631.55	2025-04-16 00:22:21.480925	Vencido	t
1332	132	1332	0.00	2024-09-06 02:23:43.597679	Pagado	t
1333	55	1333	4663.45	2025-07-07 05:36:44.565245	Pendiente	t
1334	44	1334	59.45	2024-12-07 23:42:46.056352	Vencido	t
1335	173	1335	0.00	2025-01-05 15:25:02.264323	Pagado	t
1336	114	1336	3666.29	2025-06-14 14:42:30.260993	Pendiente	t
1337	157	1337	1683.82	2024-08-02 21:19:20.306813	Vencido	t
1338	99	1338	0.00	2024-11-26 05:15:35.725559	Pagado	t
1339	40	1339	1445.98	2025-03-23 14:26:53.649159	Pendiente	t
1340	117	1340	1246.42	2024-09-17 04:20:58.139449	Vencido	t
1341	168	1341	0.00	2024-09-18 21:53:22.260136	Pagado	t
1342	166	1342	2739.92	2025-02-14 00:43:29.320961	Pendiente	t
1343	150	1343	2012.49	2025-02-09 14:55:15.090702	Vencido	t
1344	51	1344	0.00	2024-11-16 17:59:09.244494	Pagado	t
1345	26	1345	1994.83	2024-08-09 00:48:42.083935	Pendiente	t
1346	78	1346	574.97	2024-12-14 14:12:06.611914	Vencido	t
1347	8	1347	0.00	2024-09-13 20:45:40.792374	Pagado	t
1348	68	1348	3242.29	2024-07-27 19:21:28.556177	Pendiente	t
1349	10	1349	2363.84	2025-07-01 11:19:31.136672	Vencido	t
1350	145	1350	0.00	2025-03-16 16:03:57.004538	Pagado	t
1351	78	1351	732.72	2024-11-03 02:25:14.196323	Pendiente	t
1352	10	1352	494.84	2024-11-15 04:42:45.379189	Vencido	t
1353	44	1353	0.00	2025-02-18 05:36:04.075922	Pagado	t
1354	111	1354	156.40	2024-07-26 03:03:16.682984	Pendiente	t
1355	61	1355	1179.52	2025-05-30 05:44:58.097371	Vencido	t
1356	78	1356	0.00	2024-07-14 00:26:57.063471	Pagado	t
1357	97	1357	2423.08	2024-12-06 06:23:40.131538	Pendiente	t
1358	193	1358	987.64	2025-06-18 14:20:43.493996	Vencido	t
1359	41	1359	0.00	2024-10-12 07:43:42.042295	Pagado	t
1360	186	1360	754.47	2024-08-15 19:13:19.574277	Pendiente	t
1361	184	1361	2427.14	2025-02-22 20:34:34.137144	Vencido	t
1362	55	1362	0.00	2025-02-26 21:15:50.003028	Pagado	t
1363	112	1363	1860.34	2024-12-24 06:05:18.543857	Pendiente	t
1364	11	1364	865.17	2025-03-28 04:38:34.618576	Vencido	t
1365	72	1365	0.00	2024-10-02 16:14:15.654592	Pagado	t
1366	178	1366	870.49	2025-01-08 05:35:27.123045	Pendiente	t
1367	140	1367	2220.52	2025-07-05 02:23:18.891509	Vencido	t
1368	101	1368	0.00	2024-08-26 14:23:28.51934	Pagado	t
1369	99	1369	985.37	2024-11-16 04:05:29.040038	Pendiente	t
1370	85	1370	2104.97	2024-09-22 00:58:49.690658	Vencido	t
1371	142	1371	0.00	2024-08-15 12:32:16.543405	Pagado	t
1372	25	1372	3518.21	2024-11-17 10:04:21.814632	Pendiente	t
1373	32	1373	1595.55	2025-07-12 15:49:14.516017	Vencido	t
1374	190	1374	0.00	2024-08-03 11:18:53.182611	Pagado	t
1375	71	1375	2061.75	2025-04-16 04:46:35.943573	Pendiente	t
1376	105	1376	464.64	2025-04-08 20:06:58.393237	Vencido	t
1377	3	1377	0.00	2025-01-22 12:44:17.162463	Pagado	t
1378	39	1378	275.56	2024-12-21 15:08:00.45081	Pendiente	t
1379	183	1379	418.77	2025-05-15 08:53:35.685264	Vencido	t
1380	193	1380	0.00	2024-12-01 14:34:16.334963	Pagado	t
1381	26	1381	1624.36	2025-01-25 16:22:03.876329	Pendiente	t
1382	157	1382	1812.60	2025-02-11 04:49:52.619726	Vencido	t
1383	13	1383	0.00	2024-12-26 06:04:59.817354	Pagado	t
1384	92	1384	2158.73	2025-02-20 12:04:59.72927	Pendiente	t
1385	116	1385	1981.29	2024-08-27 19:31:03.194037	Vencido	t
1386	47	1386	0.00	2024-07-23 07:24:50.378724	Pagado	t
1387	61	1387	2420.16	2024-07-16 19:12:35.290781	Pendiente	t
1388	139	1388	172.98	2025-03-30 12:17:22.952062	Vencido	t
1389	143	1389	0.00	2024-09-12 10:44:12.692195	Pagado	t
1390	157	1390	143.56	2024-11-19 09:19:53.208779	Pendiente	t
1391	166	1391	226.21	2024-10-17 08:49:50.950685	Vencido	t
1392	138	1392	0.00	2024-08-12 13:28:51.252366	Pagado	t
1393	91	1393	3599.86	2024-09-14 08:57:56.125534	Pendiente	t
1394	86	1394	1584.25	2025-05-02 11:48:42.789134	Vencido	t
1395	65	1395	0.00	2024-08-06 09:54:57.470107	Pagado	t
1396	108	1396	893.50	2024-12-30 05:50:13.679629	Pendiente	t
1397	6	1397	437.45	2025-01-14 22:00:55.871136	Vencido	t
1398	38	1398	0.00	2024-12-22 10:31:53.04505	Pagado	t
1399	88	1399	1451.82	2024-11-22 01:34:07.41203	Pendiente	t
1400	13	1400	2302.09	2025-02-05 04:03:58.925792	Vencido	t
1401	35	1401	0.00	2025-02-15 00:26:25.758652	Pagado	t
1402	171	1402	1825.48	2025-07-12 08:21:23.145783	Pendiente	t
1403	56	1403	2385.48	2024-07-23 01:23:35.062547	Vencido	t
1404	156	1404	0.00	2025-01-03 07:30:31.060904	Pagado	t
1405	159	1405	2571.88	2024-11-09 06:07:49.690668	Pendiente	t
1406	77	1406	1728.14	2025-02-15 00:37:25.952967	Vencido	t
1407	156	1407	0.00	2025-01-01 01:19:34.718199	Pagado	t
1408	22	1408	313.78	2024-08-16 11:52:07.25848	Pendiente	t
1409	79	1409	1309.74	2025-02-16 15:13:20.35097	Vencido	t
1410	18	1410	0.00	2024-09-23 12:35:27.798792	Pagado	t
1411	52	1411	4891.20	2024-12-23 07:37:52.046292	Pendiente	t
1412	110	1412	1009.25	2025-02-02 11:23:53.617465	Vencido	t
1413	14	1413	0.00	2024-11-15 00:34:19.27031	Pagado	t
1414	117	1414	1774.96	2024-10-08 14:34:23.859058	Pendiente	t
1415	136	1415	747.29	2025-01-13 07:34:35.550764	Vencido	t
1416	132	1416	0.00	2024-10-20 12:50:35.534703	Pagado	t
1417	26	1417	1534.82	2024-10-31 15:57:38.686775	Pendiente	t
1418	190	1418	2332.59	2025-07-05 16:46:36.536344	Vencido	t
1419	33	1419	0.00	2025-05-08 06:47:33.4146	Pagado	t
1420	103	1420	4299.31	2025-06-16 11:47:53.831818	Pendiente	t
1421	40	1421	1290.04	2025-06-08 23:05:02.647281	Vencido	t
1422	165	1422	0.00	2024-09-03 22:16:36.756754	Pagado	t
1423	34	1423	4759.40	2024-12-09 23:05:18.247655	Pendiente	t
1424	117	1424	907.59	2025-01-08 08:05:34.982606	Vencido	t
1425	66	1425	0.00	2024-07-19 02:26:20.925125	Pagado	t
1426	113	1426	5038.73	2025-05-31 04:47:15.075866	Pendiente	t
1427	7	1427	679.83	2024-07-29 16:27:43.339248	Vencido	t
1428	132	1428	0.00	2025-06-16 00:36:55.80904	Pagado	t
1429	172	1429	1477.85	2025-01-02 10:42:37.455306	Pendiente	t
1430	30	1430	460.67	2024-11-25 10:50:28.471696	Vencido	t
1431	40	1431	0.00	2025-01-20 20:31:53.840265	Pagado	t
1432	72	1432	636.87	2024-12-04 08:17:57.37613	Pendiente	t
1433	153	1433	2498.29	2025-07-07 21:45:55.355109	Vencido	t
1434	17	1434	0.00	2025-04-29 21:18:44.958063	Pagado	t
1435	30	1435	159.13	2025-01-09 16:36:59.921761	Pendiente	t
1436	152	1436	1593.78	2025-06-21 18:49:07.057439	Vencido	t
1437	52	1437	0.00	2025-07-09 17:28:25.166983	Pagado	t
1438	114	1438	4380.44	2024-07-18 16:58:08.405649	Pendiente	t
1439	7	1439	1416.74	2024-10-16 10:39:17.797377	Vencido	t
1440	183	1440	0.00	2024-09-03 01:09:55.837657	Pagado	t
1441	23	1441	3332.64	2025-01-28 22:48:05.453724	Pendiente	t
1442	61	1442	306.50	2025-02-25 18:44:04.366688	Vencido	t
1443	90	1443	0.00	2024-12-10 05:08:21.524004	Pagado	t
1444	126	1444	2619.37	2025-06-29 21:03:19.796117	Pendiente	t
1445	135	1445	1840.02	2025-02-12 13:20:41.843146	Vencido	t
1446	38	1446	0.00	2025-05-11 16:25:05.042681	Pagado	t
1447	148	1447	1098.21	2024-12-04 02:21:00.512379	Pendiente	t
1448	55	1448	342.78	2025-04-08 07:48:00.867281	Vencido	t
1449	179	1449	0.00	2025-05-15 03:38:10.744667	Pagado	t
1450	40	1450	166.44	2025-05-13 18:53:20.969963	Pendiente	t
1451	161	1451	520.54	2024-10-12 20:09:37.315703	Vencido	t
1452	152	1452	0.00	2025-01-05 02:09:42.61201	Pagado	t
1453	79	1453	5019.50	2024-08-05 23:25:31.564381	Pendiente	t
1454	75	1454	2089.16	2024-11-28 18:26:29.51482	Vencido	t
1455	8	1455	0.00	2025-01-01 16:40:14.952171	Pagado	t
1456	66	1456	2705.75	2024-10-09 00:12:20.001511	Pendiente	t
1457	81	1457	2501.65	2024-11-24 03:07:33.283373	Vencido	t
1458	83	1458	0.00	2025-03-02 12:30:50.392535	Pagado	t
1459	180	1459	5014.37	2024-09-09 11:45:20.82015	Pendiente	t
1460	127	1460	542.56	2025-06-25 11:52:29.942734	Vencido	t
1461	110	1461	0.00	2025-02-11 00:19:05.163932	Pagado	t
1462	65	1462	3521.70	2024-11-06 23:23:12.566403	Pendiente	t
1463	153	1463	1810.84	2025-06-09 18:37:17.935074	Vencido	t
1464	116	1464	0.00	2024-07-18 05:14:33.429057	Pagado	t
1465	22	1465	3332.03	2024-09-07 23:29:57.046871	Pendiente	t
1466	25	1466	668.43	2024-09-07 20:48:41.928386	Vencido	t
1467	23	1467	0.00	2024-10-08 09:28:22.782995	Pagado	t
1468	155	1468	477.10	2024-11-20 18:50:59.165498	Pendiente	t
1469	183	1469	64.32	2024-09-30 07:06:22.98952	Vencido	t
1470	101	1470	0.00	2024-08-12 04:20:26.925525	Pagado	t
1471	7	1471	69.01	2025-06-06 12:15:07.812232	Pendiente	t
1472	4	1472	557.76	2025-07-05 22:51:59.784227	Vencido	t
1473	28	1473	0.00	2024-07-31 04:01:00.94576	Pagado	t
1474	199	1474	2002.75	2024-11-24 13:32:10.865062	Pendiente	t
1475	136	1475	2492.37	2024-08-20 22:06:11.390512	Vencido	t
1476	128	1476	0.00	2024-11-30 02:59:52.611533	Pagado	t
1477	144	1477	324.14	2024-09-15 00:44:22.537762	Pendiente	t
1478	136	1478	980.03	2024-08-22 19:35:43.876811	Vencido	t
1479	31	1479	0.00	2025-05-31 04:02:39.707544	Pagado	t
1480	191	1480	2822.23	2025-01-04 00:28:31.628618	Pendiente	t
1481	21	1481	31.01	2024-07-21 11:30:59.261621	Vencido	t
1482	39	1482	0.00	2025-06-19 05:46:11.222207	Pagado	t
1483	198	1483	2317.42	2024-09-29 15:33:59.318692	Pendiente	t
1484	108	1484	1317.24	2024-12-24 10:15:59.261862	Vencido	t
1485	23	1485	0.00	2024-12-07 13:41:22.871616	Pagado	t
1486	63	1486	192.60	2025-03-26 10:58:17.060517	Pendiente	t
1487	9	1487	1961.58	2025-06-01 04:36:27.684918	Vencido	t
1488	15	1488	0.00	2025-05-05 19:52:32.300978	Pagado	t
1489	165	1489	106.87	2024-09-25 20:02:54.916666	Pendiente	t
1490	119	1490	1837.61	2025-03-30 21:21:50.436783	Vencido	t
1491	43	1491	0.00	2025-02-21 22:39:18.748764	Pagado	t
1492	171	1492	2328.74	2025-02-06 13:23:30.583975	Pendiente	t
1493	150	1493	1075.04	2025-03-09 08:06:20.473539	Vencido	t
1494	168	1494	0.00	2025-04-25 04:36:42.794475	Pagado	t
1495	57	1495	2435.32	2024-08-08 01:49:51.880569	Pendiente	t
1496	133	1496	2002.42	2024-11-16 11:21:20.136831	Vencido	t
1497	3	1497	0.00	2025-03-07 18:58:56.437061	Pagado	t
1498	49	1498	4407.80	2024-11-29 01:52:46.356096	Pendiente	t
1499	198	1499	614.59	2025-01-05 10:16:02.342662	Vencido	t
1500	172	1500	0.00	2025-01-25 00:11:50.160681	Pagado	t
1501	51	1501	3183.98	2024-11-29 12:56:09.699976	Pendiente	t
1502	185	1502	710.37	2024-10-20 00:59:42.747849	Vencido	t
1503	83	1503	0.00	2025-06-07 18:32:54.563902	Pagado	t
1504	154	1504	3970.02	2024-10-19 11:51:50.145661	Pendiente	t
1505	134	1505	1821.95	2024-11-14 05:38:38.855805	Vencido	t
1506	105	1506	0.00	2025-06-24 03:27:38.962036	Pagado	t
1507	51	1507	485.84	2025-01-28 10:22:05.364109	Pendiente	t
1508	144	1508	2336.46	2025-07-04 21:41:31.526517	Vencido	t
1509	184	1509	0.00	2024-12-04 22:15:09.748329	Pagado	t
1510	8	1510	1013.35	2024-10-20 21:10:22.323197	Pendiente	t
1511	102	1511	2221.22	2024-11-03 14:31:21.858504	Vencido	t
1512	185	1512	0.00	2025-03-18 11:26:03.872494	Pagado	t
1513	102	1513	1562.12	2025-05-13 16:19:07.087598	Pendiente	t
1514	190	1514	1133.07	2025-03-03 21:12:17.064434	Vencido	t
1515	170	1515	0.00	2024-12-10 13:40:56.033457	Pagado	t
1516	119	1516	4454.19	2025-01-16 16:11:43.546818	Pendiente	t
1517	71	1517	402.60	2024-10-20 06:06:38.204899	Vencido	t
1518	29	1518	0.00	2024-11-02 16:36:32.868616	Pagado	t
1519	55	1519	1870.82	2025-01-05 17:31:59.533484	Pendiente	t
1520	196	1520	2180.45	2024-09-25 11:00:12.762405	Vencido	t
1521	57	1521	0.00	2024-10-08 02:53:42.670269	Pagado	t
1522	26	1522	2092.29	2025-01-23 00:17:16.645511	Pendiente	t
1523	7	1523	242.45	2025-03-12 03:45:25.227516	Vencido	t
1524	30	1524	0.00	2024-10-07 07:25:19.376338	Pagado	t
1525	185	1525	3379.11	2025-04-05 17:23:23.635054	Pendiente	t
1526	74	1526	2361.87	2025-06-21 00:57:54.91931	Vencido	t
1527	89	1527	0.00	2025-02-27 21:33:50.993261	Pagado	t
1528	22	1528	1449.76	2024-09-16 11:50:38.975753	Pendiente	t
1529	96	1529	464.87	2024-10-13 06:10:32.078275	Vencido	t
1530	193	1530	0.00	2024-11-25 17:25:37.701623	Pagado	t
1531	33	1531	2123.64	2025-05-09 23:53:47.310354	Pendiente	t
1532	123	1532	902.00	2024-08-14 11:57:05.052663	Vencido	t
1533	101	1533	0.00	2025-01-15 03:13:30.231165	Pagado	t
1534	89	1534	890.04	2025-05-13 23:13:32.293482	Pendiente	t
1535	118	1535	1545.92	2025-01-29 14:07:22.732722	Vencido	t
1536	108	1536	0.00	2025-01-25 15:13:33.373475	Pagado	t
1537	66	1537	751.23	2024-07-13 18:21:10.285311	Pendiente	t
1538	6	1538	928.01	2025-02-03 13:08:22.159274	Vencido	t
1539	124	1539	0.00	2024-09-07 10:15:21.764369	Pagado	t
1540	141	1540	4660.25	2024-12-26 14:17:49.581956	Pendiente	t
1541	173	1541	2260.94	2025-01-02 08:09:50.31426	Vencido	t
1542	167	1542	0.00	2024-07-16 09:24:00.391761	Pagado	t
1543	117	1543	1657.62	2025-04-22 23:14:01.830334	Pendiente	t
1544	7	1544	67.87	2025-01-04 13:17:45.848514	Vencido	t
1545	48	1545	0.00	2024-11-27 20:47:04.84351	Pagado	t
1546	109	1546	1160.14	2024-11-14 21:56:47.798125	Pendiente	t
1547	77	1547	1651.65	2024-08-19 14:04:30.861811	Vencido	t
1548	120	1548	0.00	2024-07-21 06:36:32.911221	Pagado	t
1549	63	1549	3228.10	2025-04-14 16:31:43.890823	Pendiente	t
1550	99	1550	898.35	2024-11-26 10:46:14.726934	Vencido	t
1551	115	1551	0.00	2025-05-05 07:00:46.804537	Pagado	t
1552	72	1552	2608.33	2024-07-24 07:27:30.008329	Pendiente	t
1553	125	1553	120.08	2025-01-28 06:10:46.385938	Vencido	t
1554	72	1554	0.00	2025-04-30 19:27:42.496209	Pagado	t
1555	120	1555	1942.49	2024-09-04 12:45:27.104746	Pendiente	t
1556	48	1556	1642.51	2024-07-20 01:14:03.777306	Vencido	t
1557	159	1557	0.00	2024-07-14 13:10:42.280147	Pagado	t
1558	140	1558	616.05	2024-08-10 12:51:24.451231	Pendiente	t
1559	62	1559	2219.41	2024-09-05 07:32:26.623795	Vencido	t
1560	69	1560	0.00	2025-05-23 17:10:12.616198	Pagado	t
1561	196	1561	2764.32	2025-05-20 00:12:20.003047	Pendiente	t
1562	9	1562	2148.09	2025-05-06 19:59:17.896479	Vencido	t
1563	86	1563	0.00	2025-06-02 01:06:45.49164	Pagado	t
1564	6	1564	1796.09	2024-11-03 15:18:52.200982	Pendiente	t
1565	87	1565	1720.67	2024-12-30 16:58:37.047177	Vencido	t
1566	59	1566	0.00	2025-03-09 16:03:58.597505	Pagado	t
1567	144	1567	4825.83	2025-06-05 00:32:34.06183	Pendiente	t
1568	90	1568	1498.74	2025-07-05 19:36:27.045848	Vencido	t
1569	91	1569	0.00	2024-07-28 19:01:19.922357	Pagado	t
1570	122	1570	4211.06	2024-10-10 00:05:47.700177	Pendiente	t
1571	103	1571	875.53	2025-01-21 06:58:59.29935	Vencido	t
1572	66	1572	0.00	2025-06-14 00:04:21.511337	Pagado	t
1573	41	1573	3032.28	2024-11-10 01:18:31.422607	Pendiente	t
1574	119	1574	1477.93	2024-11-02 02:43:15.904584	Vencido	t
1575	96	1575	0.00	2025-05-17 14:57:48.594446	Pagado	t
1576	100	1576	2711.18	2025-02-14 18:02:09.591354	Pendiente	t
1577	14	1577	491.29	2025-03-22 21:04:38.857328	Vencido	t
1578	186	1578	0.00	2025-04-29 16:27:32.194914	Pagado	t
1579	34	1579	2652.66	2025-02-15 18:33:12.279945	Pendiente	t
1580	77	1580	2466.90	2024-10-01 22:04:22.780657	Vencido	t
1581	184	1581	0.00	2025-04-14 16:33:34.44357	Pagado	t
1582	77	1582	848.03	2024-08-06 17:23:23.344524	Pendiente	t
1583	190	1583	700.05	2024-11-19 19:13:48.986488	Vencido	t
1584	167	1584	0.00	2025-03-07 13:52:13.746606	Pagado	t
1585	97	1585	2773.31	2024-10-15 04:59:58.428708	Pendiente	t
1586	87	1586	1434.11	2024-08-03 11:56:56.800936	Vencido	t
1587	85	1587	0.00	2025-02-27 14:31:58.2136	Pagado	t
1588	168	1588	3393.92	2025-03-13 14:52:03.428892	Pendiente	t
1589	15	1589	949.17	2025-02-26 06:56:18.531924	Vencido	t
1590	157	1590	0.00	2025-05-30 22:33:24.95881	Pagado	t
1591	177	1591	3422.87	2025-01-08 19:59:09.073194	Pendiente	t
1592	12	1592	862.31	2024-09-24 04:01:20.478463	Vencido	t
1593	172	1593	0.00	2024-11-29 02:04:45.332598	Pagado	t
1594	163	1594	303.01	2025-05-21 14:24:32.977948	Pendiente	t
1595	4	1595	2225.73	2025-01-02 06:08:59.054905	Vencido	t
1596	95	1596	0.00	2025-02-22 06:12:22.261146	Pagado	t
1597	164	1597	2899.27	2025-05-15 13:22:18.459862	Pendiente	t
1598	84	1598	1575.55	2024-10-01 03:25:32.763883	Vencido	t
1599	155	1599	0.00	2025-05-30 17:59:17.033601	Pagado	t
1600	7	1600	4154.69	2025-07-09 11:30:48.815919	Pendiente	t
1601	109	1601	1571.32	2024-08-04 01:01:37.880749	Vencido	t
1602	196	1602	0.00	2024-11-12 07:42:51.450625	Pagado	t
1603	93	1603	4544.00	2025-01-16 16:41:00.617441	Pendiente	t
1604	118	1604	1707.27	2025-01-31 18:01:36.466471	Vencido	t
1605	8	1605	0.00	2024-11-23 22:14:02.280333	Pagado	t
1606	142	1606	3960.30	2025-06-08 21:05:54.863452	Pendiente	t
1607	58	1607	419.11	2025-06-29 13:29:46.459108	Vencido	t
1608	196	1608	0.00	2024-08-01 01:10:04.64932	Pagado	t
1609	93	1609	730.00	2024-07-26 07:50:22.415382	Pendiente	t
1610	163	1610	1014.87	2025-01-21 07:29:27.661817	Vencido	t
1611	106	1611	0.00	2025-04-02 09:31:10.660168	Pagado	t
1612	169	1612	1389.46	2024-07-30 01:32:04.282252	Pendiente	t
1613	198	1613	174.43	2025-06-16 22:11:39.090848	Vencido	t
1614	22	1614	0.00	2024-09-08 08:01:25.01635	Pagado	t
1615	66	1615	86.57	2025-01-10 21:57:28.761097	Pendiente	t
1616	150	1616	1787.88	2024-08-08 01:31:20.057257	Vencido	t
1617	38	1617	0.00	2025-07-11 03:27:02.888134	Pagado	t
1618	44	1618	5038.02	2025-02-15 12:57:11.05868	Pendiente	t
1619	25	1619	1312.12	2025-05-15 09:41:04.791645	Vencido	t
1620	61	1620	0.00	2024-12-01 02:19:37.985843	Pagado	t
1621	147	1621	1110.74	2024-07-20 07:22:55.424754	Pendiente	t
1622	168	1622	984.74	2025-03-03 16:18:42.0316	Vencido	t
1623	127	1623	0.00	2024-07-26 19:56:09.838857	Pagado	t
1624	160	1624	2645.72	2025-05-20 03:47:03.577083	Pendiente	t
1625	184	1625	1053.49	2025-06-07 02:46:37.10267	Vencido	t
1626	9	1626	0.00	2025-03-05 09:52:26.008876	Pagado	t
1627	174	1627	4335.39	2024-08-09 04:01:21.890212	Pendiente	t
1628	129	1628	644.20	2024-09-26 19:54:22.448365	Vencido	t
1629	46	1629	0.00	2025-06-11 17:40:24.079955	Pagado	t
1630	197	1630	2359.66	2025-02-13 20:55:44.661944	Pendiente	t
1631	124	1631	1516.87	2024-12-01 04:21:27.921309	Vencido	t
1632	85	1632	0.00	2024-09-05 22:35:47.825246	Pagado	t
1633	107	1633	3094.02	2024-08-31 14:41:04.334321	Pendiente	t
1634	62	1634	875.51	2025-05-06 21:49:47.928385	Vencido	t
1635	20	1635	0.00	2024-10-12 05:54:06.778247	Pagado	t
1636	195	1636	3991.37	2025-07-04 18:31:07.658301	Pendiente	t
1637	190	1637	740.00	2024-10-25 16:08:36.145075	Vencido	t
1638	128	1638	0.00	2025-07-03 00:13:02.09055	Pagado	t
1639	57	1639	2092.38	2025-06-23 06:37:12.403654	Pendiente	t
1640	160	1640	1034.77	2025-06-24 02:36:30.452554	Vencido	t
1641	199	1641	0.00	2024-10-09 03:57:46.876065	Pagado	t
1642	18	1642	912.64	2025-02-10 08:27:06.490171	Pendiente	t
1643	12	1643	2408.89	2025-06-16 12:54:07.937141	Vencido	t
1644	48	1644	0.00	2024-12-17 15:29:34.635843	Pagado	t
1645	180	1645	4293.05	2024-09-12 17:57:42.866225	Pendiente	t
1646	69	1646	2224.09	2024-12-12 06:53:05.276846	Vencido	t
1647	127	1647	0.00	2025-03-24 17:14:34.236555	Pagado	t
1648	102	1648	2288.93	2025-03-24 06:39:27.739469	Pendiente	t
1649	151	1649	1660.62	2024-11-23 18:12:10.683431	Vencido	t
1650	173	1650	0.00	2025-03-06 13:25:26.483832	Pagado	t
1651	48	1651	4922.79	2025-04-21 16:07:49.897599	Pendiente	t
1652	45	1652	2282.99	2025-05-17 09:29:56.426899	Vencido	t
1653	86	1653	0.00	2025-01-10 03:24:09.117287	Pagado	t
1654	161	1654	620.07	2024-10-08 10:55:45.286486	Pendiente	t
1655	19	1655	1182.53	2024-09-05 02:59:07.153563	Vencido	t
1656	162	1656	0.00	2024-08-03 11:51:32.991744	Pagado	t
1657	104	1657	2622.54	2025-05-20 23:42:46.112498	Pendiente	t
1658	167	1658	2286.98	2024-08-27 16:18:55.909519	Vencido	t
1659	124	1659	0.00	2025-04-22 19:52:20.957153	Pagado	t
1660	66	1660	1756.08	2025-05-31 15:15:11.139079	Pendiente	t
1661	24	1661	1272.29	2025-04-19 12:15:42.128053	Vencido	t
1662	33	1662	0.00	2024-12-10 13:38:28.73967	Pagado	t
1663	58	1663	282.89	2025-04-21 23:28:58.573221	Pendiente	t
1664	80	1664	1702.67	2024-07-21 02:01:33.936236	Vencido	t
1665	32	1665	0.00	2025-02-15 22:53:59.327763	Pagado	t
1666	79	1666	103.19	2025-05-20 05:11:37.953551	Pendiente	t
1667	137	1667	662.34	2025-04-03 12:10:48.182951	Vencido	t
1668	162	1668	0.00	2024-10-16 23:13:27.114339	Pagado	t
1669	10	1669	847.47	2025-04-09 05:06:13.153165	Pendiente	t
1670	85	1670	1773.69	2024-12-30 21:33:58.19785	Vencido	t
1671	87	1671	0.00	2025-07-01 19:30:32.923638	Pagado	t
1672	186	1672	469.19	2025-01-31 18:32:09.639096	Pendiente	t
1673	34	1673	728.03	2025-01-17 06:44:48.082976	Vencido	t
1674	102	1674	0.00	2025-04-15 17:31:00.969502	Pagado	t
1675	44	1675	2900.54	2025-06-16 18:35:26.764007	Pendiente	t
1676	158	1676	2375.51	2024-10-30 15:53:00.084223	Vencido	t
1677	120	1677	0.00	2024-12-08 05:24:58.767212	Pagado	t
1678	169	1678	4301.24	2024-10-06 02:10:40.507952	Pendiente	t
1679	145	1679	603.46	2025-05-07 20:24:30.013425	Vencido	t
1680	186	1680	0.00	2024-11-26 12:00:20.495995	Pagado	t
1681	159	1681	3535.30	2025-04-05 08:32:33.064935	Pendiente	t
1682	182	1682	2174.97	2025-04-02 14:02:53.311444	Vencido	t
1683	142	1683	0.00	2025-01-15 14:08:50.964368	Pagado	t
1684	11	1684	1071.25	2024-09-22 07:14:33.697806	Pendiente	t
1685	182	1685	1536.30	2025-03-23 19:26:08.289261	Vencido	t
1686	23	1686	0.00	2025-02-04 18:52:48.506659	Pagado	t
1687	35	1687	234.47	2025-07-02 23:52:08.700315	Pendiente	t
1688	186	1688	1415.72	2024-12-20 23:08:27.983903	Vencido	t
1689	31	1689	0.00	2024-10-18 00:28:49.129435	Pagado	t
1690	141	1690	3307.43	2024-07-30 23:08:02.458997	Pendiente	t
1691	189	1691	773.36	2024-09-05 07:49:06.004622	Vencido	t
1692	28	1692	0.00	2024-11-14 20:07:14.540394	Pagado	t
1693	157	1693	220.01	2025-07-07 11:37:14.858571	Pendiente	t
1694	87	1694	2443.16	2025-06-02 08:27:01.349575	Vencido	t
1695	183	1695	0.00	2024-11-16 07:44:49.317596	Pagado	t
1696	38	1696	1448.87	2025-05-09 04:11:17.660129	Pendiente	t
1697	56	1697	2230.47	2025-02-15 13:23:59.894445	Vencido	t
1698	17	1698	0.00	2025-01-30 19:22:15.451941	Pagado	t
1699	53	1699	1872.12	2024-08-28 20:01:41.047585	Pendiente	t
1700	160	1700	101.97	2025-06-24 06:52:47.241069	Vencido	t
1701	76	1701	0.00	2025-05-02 10:41:14.892869	Pagado	t
1702	143	1702	2739.81	2025-05-28 05:49:42.009502	Pendiente	t
1703	68	1703	1313.05	2024-12-01 08:20:20.464603	Vencido	t
1704	44	1704	0.00	2025-05-07 17:59:17.595165	Pagado	t
1705	52	1705	1483.88	2025-02-01 04:44:13.245533	Pendiente	t
1706	49	1706	451.95	2025-04-02 15:41:16.724238	Vencido	t
1707	37	1707	0.00	2024-08-23 07:41:35.297317	Pagado	t
1708	85	1708	5032.47	2024-12-02 00:26:02.217692	Pendiente	t
1709	42	1709	168.03	2024-08-05 07:31:53.968088	Vencido	t
1710	129	1710	0.00	2024-10-08 23:50:50.299491	Pagado	t
1711	120	1711	4920.89	2025-04-27 07:55:10.760997	Pendiente	t
1712	26	1712	1946.44	2024-08-30 07:16:03.734209	Vencido	t
1713	15	1713	0.00	2025-02-18 20:22:08.862838	Pagado	t
1714	189	1714	1583.81	2024-08-07 18:49:36.924795	Pendiente	t
1715	4	1715	1369.00	2025-03-01 12:23:16.079549	Vencido	t
1716	182	1716	0.00	2024-09-17 03:46:05.54753	Pagado	t
1717	103	1717	4245.04	2025-04-12 06:51:23.786906	Pendiente	t
1718	63	1718	536.56	2024-10-13 20:07:33.790767	Vencido	t
1719	139	1719	0.00	2024-12-15 20:08:15.03897	Pagado	t
1720	50	1720	3681.08	2025-02-18 02:57:22.15234	Pendiente	t
1721	33	1721	210.10	2024-09-09 03:34:30.810314	Vencido	t
1722	138	1722	0.00	2025-01-26 22:43:26.472542	Pagado	t
1723	190	1723	1998.16	2025-05-04 07:14:45.693219	Pendiente	t
1724	197	1724	2016.03	2025-02-24 05:37:02.540168	Vencido	t
1725	185	1725	0.00	2024-10-28 01:55:58.037378	Pagado	t
1726	198	1726	4259.66	2025-05-22 01:49:08.012391	Pendiente	t
1727	10	1727	1563.08	2025-03-20 17:08:02.818112	Vencido	t
1728	2	1728	0.00	2025-03-25 03:34:09.382903	Pagado	t
1729	153	1729	1303.65	2025-03-24 21:34:20.352336	Pendiente	t
1730	122	1730	1024.83	2024-10-12 08:53:48.728575	Vencido	t
1731	147	1731	0.00	2024-11-07 17:40:01.422216	Pagado	t
1732	119	1732	1063.90	2025-06-05 07:12:19.311706	Pendiente	t
1733	146	1733	2489.00	2024-10-24 04:58:58.467997	Vencido	t
1734	137	1734	0.00	2025-04-13 16:00:19.783339	Pagado	t
1735	119	1735	1349.45	2025-05-15 15:47:44.60357	Pendiente	t
1736	19	1736	2449.22	2024-12-30 00:22:28.514318	Vencido	t
1737	192	1737	0.00	2024-08-06 15:07:43.311796	Pagado	t
1738	165	1738	1404.19	2024-09-26 10:46:31.441425	Pendiente	t
1739	93	1739	1902.94	2025-01-06 17:19:08.125455	Vencido	t
1740	136	1740	0.00	2024-08-28 00:26:39.046409	Pagado	t
1741	114	1741	4609.24	2025-05-14 04:44:59.456193	Pendiente	t
1742	12	1742	1308.13	2024-08-23 03:21:46.458465	Vencido	t
1743	63	1743	0.00	2024-12-03 21:18:43.61334	Pagado	t
1744	95	1744	2830.53	2025-06-23 05:24:37.236628	Pendiente	t
1745	2	1745	222.12	2024-08-17 21:14:03.978863	Vencido	t
1746	7	1746	0.00	2025-03-13 07:20:13.607793	Pagado	t
1747	182	1747	4747.97	2024-09-10 09:20:59.172862	Pendiente	t
1748	81	1748	44.35	2025-02-27 01:10:29.469194	Vencido	t
1749	165	1749	0.00	2025-01-12 04:46:42.022913	Pagado	t
1750	79	1750	1859.51	2025-05-05 06:35:02.992495	Pendiente	t
1751	152	1751	1352.65	2024-09-21 14:56:41.76147	Vencido	t
1752	130	1752	0.00	2024-11-18 10:24:52.33341	Pagado	t
1753	193	1753	4445.13	2024-10-29 05:44:35.794259	Pendiente	t
1754	62	1754	1471.59	2025-01-17 17:51:31.894348	Vencido	t
1755	200	1755	0.00	2024-08-11 19:13:53.773697	Pagado	t
1756	67	1756	522.26	2025-01-08 05:23:40.526528	Pendiente	t
1757	154	1757	1867.36	2025-05-31 08:44:07.40864	Vencido	t
1758	23	1758	0.00	2025-02-20 11:18:46.140231	Pagado	t
1759	159	1759	2360.83	2025-01-05 01:24:48.610167	Pendiente	t
1760	9	1760	2313.05	2025-06-08 04:47:42.503875	Vencido	t
1761	98	1761	0.00	2024-07-31 22:08:01.235066	Pagado	t
1762	20	1762	1700.04	2024-08-29 04:35:08.289502	Pendiente	t
1763	163	1763	1772.23	2024-10-07 22:46:20.935938	Vencido	t
1764	60	1764	0.00	2025-03-14 05:54:08.19355	Pagado	t
1765	63	1765	288.71	2025-06-13 04:57:59.645229	Pendiente	t
1766	12	1766	2183.74	2024-12-03 15:59:26.813936	Vencido	t
1767	25	1767	0.00	2025-03-18 14:02:53.340574	Pagado	t
1768	109	1768	130.48	2024-12-31 18:11:48.843808	Pendiente	t
1769	113	1769	227.82	2025-02-25 00:51:18.711764	Vencido	t
1770	161	1770	0.00	2025-02-28 19:40:38.250837	Pagado	t
1771	55	1771	4492.11	2024-12-28 17:22:29.036448	Pendiente	t
1772	40	1772	2512.69	2025-05-29 17:11:38.326492	Vencido	t
1773	143	1773	0.00	2024-12-30 23:00:00.279995	Pagado	t
1774	114	1774	51.62	2024-09-23 03:54:13.520137	Pendiente	t
1775	157	1775	1639.90	2024-09-07 03:46:52.031347	Vencido	t
1776	178	1776	0.00	2025-01-11 21:25:04.880047	Pagado	t
1777	31	1777	680.02	2024-08-12 19:05:46.562038	Pendiente	t
1778	117	1778	992.89	2025-06-30 23:08:03.577607	Vencido	t
1779	90	1779	0.00	2024-08-01 14:47:27.945436	Pagado	t
1780	32	1780	3905.24	2025-02-01 22:20:46.981123	Pendiente	t
1781	19	1781	1405.42	2024-11-28 04:28:40.22926	Vencido	t
1782	116	1782	0.00	2025-03-07 02:42:46.065134	Pagado	t
1783	32	1783	1510.31	2024-07-20 23:04:37.678548	Pendiente	t
1784	24	1784	259.58	2024-09-27 09:41:22.11722	Vencido	t
1785	124	1785	0.00	2024-09-24 11:41:25.06942	Pagado	t
1786	177	1786	4275.72	2024-10-04 04:29:55.75602	Pendiente	t
1787	170	1787	2293.42	2024-07-25 15:25:40.460902	Vencido	t
1788	67	1788	0.00	2025-04-28 18:17:01.023677	Pagado	t
1789	106	1789	3964.81	2025-02-18 04:53:53.919994	Pendiente	t
1790	189	1790	2197.17	2025-02-19 15:18:20.590351	Vencido	t
1791	109	1791	0.00	2024-09-26 23:43:10.626883	Pagado	t
1792	73	1792	2435.26	2025-01-28 23:38:08.036017	Pendiente	t
1793	11	1793	491.60	2024-12-02 09:53:15.076827	Vencido	t
1794	70	1794	0.00	2025-01-30 22:26:26.025793	Pagado	t
1795	10	1795	328.44	2024-12-05 12:09:28.705306	Pendiente	t
1796	105	1796	163.06	2025-06-23 18:24:26.022189	Vencido	t
1797	73	1797	0.00	2024-09-05 05:27:54.825731	Pagado	t
1798	132	1798	1095.82	2025-01-08 20:53:40.055924	Pendiente	t
1799	181	1799	1964.06	2024-11-30 13:48:00.652592	Vencido	t
1800	7	1800	0.00	2025-05-16 11:11:06.515165	Pagado	t
1801	10	2007	300.00	2025-07-14 05:28:31.17263	Pendiente	t
1802	10	2015	200.00	2025-07-16 15:11:38.436792	Pendiente	t
1803	14	2016	1000.00	2025-07-16 16:03:24.280198	Pendiente	t
\.


--
-- Data for Name: detalleventas; Type: TABLE DATA; Schema: public; Owner: erp_user
--

COPY public.detalleventas (detalleid, ventaid, productoid, cantidad, preciounitario, activo) FROM stdin;
1	677	34	3	957.16	t
2	932	2	3	1578.96	t
3	992	16	5	2061.58	t
4	1737	16	4	2076.15	t
5	161	24	4	1441.14	t
6	561	48	5	807.52	t
7	815	7	3	2230.76	t
8	1178	43	1	2393.83	t
9	451	43	4	113.38	t
10	799	23	2	1609.87	t
11	1191	15	2	1106.96	t
12	1086	33	3	1480.24	t
13	69	22	4	1495.86	t
14	437	39	1	2414.00	t
15	198	9	2	1615.53	t
16	1934	43	5	45.63	t
17	1583	50	2	1962.97	t
18	938	12	2	1433.35	t
19	15	44	3	2030.40	t
20	1717	38	2	1937.17	t
21	1504	19	4	735.77	t
22	1061	27	3	2264.38	t
23	1043	22	4	1627.75	t
24	1540	37	3	1805.03	t
25	54	48	3	1566.46	t
26	1256	13	3	1153.35	t
27	680	28	3	1336.69	t
28	928	20	5	1654.62	t
29	504	32	3	2042.17	t
30	802	24	2	654.55	t
31	1146	10	4	1414.87	t
32	722	3	4	1602.00	t
33	876	34	4	1097.17	t
34	1691	8	4	2201.63	t
35	721	45	1	2272.26	t
36	75	32	4	1031.44	t
37	117	49	4	791.01	t
38	523	13	4	1870.65	t
39	1589	40	2	694.14	t
40	1147	12	1	2249.65	t
41	876	21	3	1566.76	t
42	1811	32	1	833.66	t
43	1952	8	4	540.96	t
44	1319	45	1	2474.56	t
45	1855	45	4	823.13	t
46	857	41	4	1313.24	t
47	1721	40	2	308.49	t
48	687	29	2	2257.62	t
49	1137	3	2	1722.15	t
50	937	23	1	221.46	t
51	161	42	4	1720.15	t
52	1129	36	4	187.98	t
53	587	40	4	1641.77	t
54	766	5	3	1465.99	t
55	1351	42	5	1788.80	t
56	1035	11	5	1192.11	t
57	878	21	4	1291.86	t
58	1920	20	2	1692.05	t
59	1450	16	3	1896.80	t
60	778	31	2	382.05	t
61	20	25	1	488.03	t
62	1229	28	3	916.68	t
63	1823	36	2	1894.03	t
64	752	28	4	93.19	t
65	1512	29	3	1832.96	t
66	314	44	5	1653.96	t
67	21	26	4	811.12	t
68	715	11	3	1120.19	t
69	1160	29	4	333.42	t
70	1946	48	2	235.98	t
71	1178	13	5	873.43	t
72	24	27	3	1421.01	t
73	1218	1	4	1769.01	t
74	1098	39	4	2106.18	t
75	1524	24	3	219.59	t
76	106	11	2	1495.16	t
77	1772	22	5	885.86	t
78	802	48	3	817.14	t
79	1433	23	2	748.99	t
80	191	33	4	694.63	t
81	413	41	2	1206.56	t
82	331	41	1	883.17	t
83	96	15	5	1804.94	t
84	1539	29	3	2097.40	t
85	1402	43	1	1202.54	t
86	1543	11	2	1106.98	t
87	1265	41	4	896.29	t
88	141	19	3	2473.41	t
89	122	2	2	794.43	t
90	654	35	3	1657.03	t
91	33	10	4	876.30	t
92	380	28	3	1920.45	t
93	846	38	3	359.17	t
94	476	48	3	590.75	t
95	691	39	3	622.46	t
96	951	19	5	2175.30	t
97	527	6	1	2419.38	t
98	1939	39	2	878.39	t
99	71	23	4	2180.54	t
100	1452	26	4	114.70	t
101	1322	37	3	2256.61	t
102	1863	40	3	2430.83	t
103	1952	39	3	1500.76	t
104	1976	42	3	2113.51	t
105	385	31	1	1519.03	t
106	1652	8	4	1758.67	t
107	1416	49	3	99.38	t
108	1795	3	5	1664.65	t
109	1303	29	3	2228.44	t
110	1859	19	5	1254.75	t
111	1422	48	2	274.14	t
112	1742	37	3	2101.50	t
113	898	42	3	1992.65	t
114	1505	13	4	1580.99	t
115	159	46	4	1100.06	t
116	555	45	2	357.63	t
117	1563	30	5	2423.01	t
118	29	26	3	2191.27	t
119	1489	10	1	1249.50	t
120	1581	45	2	1933.54	t
121	679	31	2	846.15	t
122	1540	31	4	269.71	t
123	404	36	1	336.46	t
124	1716	36	2	2359.76	t
125	463	8	3	1680.51	t
126	376	33	1	1315.23	t
127	1959	46	4	2033.35	t
128	806	17	5	2341.80	t
129	239	29	3	1397.81	t
130	1545	14	1	620.01	t
131	1762	1	4	2242.96	t
132	1001	21	4	1602.23	t
133	543	39	2	1485.91	t
134	1163	36	3	1196.74	t
135	1873	2	2	2298.44	t
136	987	26	2	2319.12	t
137	1934	48	2	90.87	t
138	522	33	1	660.14	t
139	64	33	5	1634.11	t
140	734	23	3	419.47	t
141	1710	20	2	2100.08	t
142	183	14	4	1553.43	t
143	1953	24	3	1089.70	t
144	172	32	1	1193.07	t
145	1808	6	3	1701.34	t
146	650	44	1	1350.47	t
147	1747	39	4	1200.05	t
148	81	41	4	1251.35	t
149	743	25	4	2427.11	t
150	384	48	2	1119.51	t
151	1555	16	3	1851.57	t
152	414	49	4	2287.35	t
153	40	20	1	2273.91	t
154	40	29	2	156.90	t
155	1127	49	4	1267.27	t
156	1917	2	3	40.97	t
157	416	41	5	2212.66	t
158	753	28	5	1873.78	t
159	1265	29	3	1148.82	t
160	1561	27	1	1877.26	t
161	1166	9	2	1677.06	t
162	1397	21	3	1880.27	t
163	63	24	1	893.81	t
164	1263	36	4	2414.87	t
165	1075	8	3	2309.20	t
166	177	25	3	712.72	t
167	1130	41	1	2233.54	t
168	1516	36	4	2195.98	t
169	477	41	2	2199.49	t
170	676	16	4	758.82	t
171	233	14	4	2018.46	t
172	1645	20	5	782.63	t
173	1559	12	4	1524.05	t
174	1029	33	2	664.00	t
175	263	28	5	2048.73	t
176	659	6	4	1354.59	t
177	1467	25	2	471.18	t
178	354	23	2	1784.72	t
179	1743	19	5	103.33	t
180	1578	31	2	1050.50	t
181	448	34	3	2237.82	t
182	1753	46	3	1730.59	t
183	403	8	5	1729.33	t
184	1988	12	1	618.05	t
185	274	33	2	1435.85	t
186	379	18	5	2224.09	t
187	999	23	3	2080.36	t
188	1484	4	2	848.59	t
189	1365	27	3	529.53	t
190	1205	31	5	2065.81	t
191	1006	9	1	1352.58	t
192	902	44	1	526.92	t
193	1512	10	2	2108.63	t
194	1325	30	3	2346.50	t
195	143	18	5	2404.16	t
196	1414	10	4	2018.56	t
197	84	44	3	1880.23	t
198	1572	5	1	1829.50	t
199	1615	27	4	1591.47	t
200	446	36	1	481.75	t
201	299	5	1	361.93	t
202	1964	34	4	897.62	t
203	1446	47	2	1376.38	t
204	1197	29	2	1272.74	t
205	1416	7	2	1893.74	t
206	1578	44	3	1576.77	t
207	24	7	4	2073.17	t
208	192	2	4	1902.93	t
209	1182	19	1	2372.35	t
210	273	38	1	2252.49	t
211	1957	21	4	738.32	t
212	1659	6	2	991.91	t
213	1108	37	3	1456.95	t
214	363	9	5	1782.92	t
215	1761	38	4	992.31	t
216	1178	47	4	1044.44	t
217	314	45	4	1976.24	t
218	614	22	4	1812.52	t
219	1325	25	1	91.71	t
220	1238	12	4	2044.58	t
221	697	14	2	589.46	t
222	1629	36	5	539.31	t
223	1993	3	4	460.09	t
224	1169	18	3	201.69	t
225	1908	48	4	334.25	t
226	1154	2	4	2180.64	t
227	1483	31	3	1567.73	t
228	1601	26	3	1281.68	t
229	517	7	1	935.60	t
230	154	10	3	2433.21	t
231	1718	30	2	1784.69	t
232	1308	46	4	1055.73	t
233	372	32	2	1959.94	t
234	801	44	4	2174.64	t
235	1970	34	3	945.10	t
236	7	13	3	1472.45	t
237	253	17	3	1674.04	t
238	486	27	4	1658.52	t
239	93	42	2	1239.73	t
240	68	36	4	1755.48	t
241	1888	6	1	1039.25	t
242	1480	18	1	170.17	t
243	1075	36	4	1917.92	t
244	46	26	2	1151.64	t
245	838	23	3	972.63	t
246	949	45	4	1289.26	t
247	1729	15	5	143.07	t
248	677	1	1	1024.13	t
249	1764	2	4	713.93	t
250	391	11	2	1869.07	t
251	1976	14	4	2114.24	t
252	1554	44	3	2252.81	t
253	1186	38	2	22.11	t
254	1736	18	5	2027.84	t
255	900	44	4	894.63	t
256	789	14	2	1481.08	t
257	452	21	3	1593.25	t
258	1943	34	4	953.84	t
259	1560	43	2	99.83	t
260	38	2	4	2028.63	t
261	1175	32	3	872.00	t
262	1262	42	4	315.24	t
263	209	48	4	1842.36	t
264	705	23	5	1577.17	t
265	622	9	4	2221.86	t
266	702	7	5	533.15	t
267	1015	14	4	2487.37	t
268	1107	42	3	2276.73	t
269	1370	8	2	938.11	t
270	713	34	3	641.03	t
271	1702	37	1	2369.29	t
272	1991	48	2	2282.73	t
273	854	10	2	2288.52	t
274	1267	31	5	412.92	t
275	237	25	3	85.01	t
276	302	33	3	1741.28	t
277	543	20	4	1652.14	t
278	1081	40	5	1758.89	t
279	703	7	4	1996.87	t
280	1950	46	1	2042.21	t
281	752	10	4	2153.47	t
282	1657	35	2	557.17	t
283	986	4	2	2007.26	t
284	986	28	2	1947.87	t
285	1493	21	4	2271.89	t
286	1473	8	5	980.93	t
287	695	2	1	1549.60	t
288	1460	11	2	297.74	t
289	661	13	4	1345.84	t
290	1985	4	1	1427.74	t
291	1842	36	2	1261.49	t
292	1612	45	5	608.95	t
293	1014	12	2	1191.17	t
294	1129	20	4	1338.73	t
295	1510	37	2	1625.53	t
296	1435	37	1	237.39	t
297	1362	40	4	408.18	t
298	1674	38	1	649.78	t
299	464	18	1	2269.22	t
300	829	10	1	1566.20	t
301	388	8	2	1997.25	t
302	1785	2	2	916.28	t
303	104	43	4	337.38	t
304	1317	26	4	46.91	t
305	1210	2	2	808.33	t
306	546	13	2	1210.68	t
307	158	25	2	51.27	t
308	137	23	2	875.54	t
309	1172	49	5	2375.34	t
310	1419	18	3	380.41	t
311	1181	32	1	1830.14	t
312	810	19	5	954.45	t
313	778	46	4	676.30	t
314	387	2	2	1349.72	t
315	390	37	2	417.83	t
316	1737	47	4	1276.09	t
317	1136	20	1	675.87	t
318	1565	6	3	2270.43	t
319	1222	33	3	269.41	t
320	783	38	2	2261.30	t
321	61	30	2	1810.10	t
322	146	32	3	2330.72	t
323	977	6	4	1572.21	t
324	214	44	2	1225.33	t
325	547	20	5	1220.63	t
326	134	15	4	2367.53	t
327	581	46	1	2111.46	t
328	486	24	2	353.63	t
329	736	50	4	633.41	t
330	1495	45	5	2293.20	t
331	1023	31	4	2333.89	t
332	1739	2	4	1164.51	t
333	1596	35	1	50.78	t
334	1673	28	2	1484.75	t
335	910	13	3	88.56	t
336	1856	42	4	1007.83	t
337	871	45	2	973.35	t
338	554	25	5	514.95	t
339	1062	28	2	1620.11	t
340	51	36	3	1683.66	t
341	1348	23	3	623.69	t
342	775	25	3	284.22	t
343	839	21	2	2391.22	t
344	543	32	4	2436.85	t
345	96	12	3	353.72	t
346	470	42	3	1154.66	t
347	1806	17	1	1806.64	t
348	1800	40	3	1692.98	t
349	35	7	2	1061.84	t
350	1913	9	2	820.34	t
351	1199	26	4	1826.77	t
352	1238	36	2	201.06	t
353	378	31	4	1679.83	t
354	1990	44	2	1870.14	t
355	1137	29	2	1856.51	t
356	1640	43	3	2036.11	t
357	853	10	2	421.68	t
358	1513	13	3	2267.64	t
359	871	28	3	1477.35	t
360	341	1	2	2246.47	t
361	477	13	3	1822.44	t
362	525	49	2	545.25	t
363	328	16	4	2249.38	t
364	1766	35	1	577.28	t
365	335	25	3	1892.68	t
366	1413	8	2	1700.49	t
367	1243	29	3	552.55	t
368	17	10	1	1482.64	t
369	583	45	3	1395.81	t
370	523	29	3	628.58	t
371	207	23	2	541.35	t
372	926	9	4	849.06	t
373	603	49	2	1577.04	t
374	194	25	4	1156.15	t
375	318	7	2	472.85	t
376	1658	4	2	543.69	t
377	1318	7	5	1741.55	t
378	369	6	4	2482.71	t
379	380	10	3	2017.30	t
380	1729	46	1	1103.22	t
381	1300	36	2	2095.51	t
382	1117	28	2	1058.40	t
383	1618	28	3	989.18	t
384	1849	14	4	1509.96	t
385	1868	43	1	2232.96	t
386	1293	41	4	2026.46	t
387	1112	50	4	1005.01	t
388	1920	33	1	1102.45	t
389	1457	2	3	1376.55	t
390	1700	37	1	2114.46	t
391	900	29	4	1781.50	t
392	201	22	4	1711.69	t
393	87	44	3	2292.67	t
394	1765	5	1	1426.00	t
395	1972	16	4	1871.35	t
396	1402	8	4	1306.92	t
397	334	1	4	207.93	t
398	1394	47	3	1351.52	t
399	69	8	1	1909.74	t
400	701	46	4	1175.33	t
401	1655	45	1	169.05	t
402	121	4	4	212.23	t
403	1812	6	3	1241.36	t
404	1256	45	4	1409.47	t
405	1966	5	5	268.80	t
406	1054	19	5	2077.04	t
407	949	12	3	2152.26	t
408	1155	22	4	1705.69	t
409	1093	12	3	1250.54	t
410	1443	39	4	1261.16	t
411	1349	6	5	893.08	t
412	1943	35	2	1427.82	t
413	1727	50	3	2107.30	t
414	256	14	2	591.94	t
415	749	30	4	356.19	t
416	1727	23	2	177.35	t
417	55	22	4	2364.23	t
418	2	11	2	379.72	t
419	1878	8	1	1215.29	t
420	1995	14	3	2140.20	t
421	527	8	3	1549.00	t
422	1538	46	3	1792.30	t
423	1882	33	4	524.57	t
424	1848	24	2	772.32	t
425	847	42	4	1718.69	t
426	112	18	5	1954.91	t
427	1325	11	5	1170.46	t
428	337	38	3	248.83	t
429	1906	31	2	531.33	t
430	294	50	2	1381.87	t
431	94	6	2	624.81	t
432	464	30	4	1119.09	t
433	1971	29	4	1585.86	t
434	105	32	4	183.75	t
435	1411	25	1	459.74	t
436	340	35	2	1783.53	t
437	1644	30	4	1109.92	t
438	688	26	4	436.26	t
439	453	35	3	2328.67	t
440	1515	33	4	1813.26	t
441	750	28	3	778.49	t
442	1806	15	4	1218.09	t
443	1824	5	4	1767.55	t
444	1766	37	2	1374.92	t
445	258	15	4	361.42	t
446	735	32	3	443.25	t
447	76	29	2	2404.52	t
448	559	11	2	1360.69	t
449	707	1	1	1481.54	t
450	1181	36	2	90.18	t
451	1815	40	3	1502.81	t
452	1619	7	2	1485.54	t
453	1513	15	2	627.45	t
454	929	12	4	2356.52	t
455	466	16	1	1594.28	t
456	891	48	3	1459.78	t
457	314	35	1	1104.14	t
458	1985	12	3	1439.21	t
459	464	33	4	1935.86	t
460	1558	8	3	2425.01	t
461	353	12	3	921.17	t
462	1727	21	4	1390.33	t
463	269	45	2	1554.29	t
464	1291	37	4	607.37	t
465	1947	3	3	1255.68	t
466	1117	15	1	171.59	t
467	1848	7	1	518.22	t
468	1781	12	4	438.97	t
469	494	32	2	707.91	t
470	117	46	1	1219.96	t
471	180	36	3	1170.83	t
472	646	31	4	1631.82	t
473	1327	12	4	577.85	t
474	1273	37	4	1063.13	t
475	1121	30	1	994.13	t
476	1627	19	4	2190.96	t
477	922	24	2	515.41	t
478	95	29	2	929.31	t
479	1174	38	1	1493.11	t
480	1351	40	5	2318.81	t
481	1527	46	2	277.87	t
482	1159	9	1	2007.78	t
483	421	19	1	1543.50	t
484	134	31	2	610.29	t
485	1088	40	4	1266.82	t
486	236	32	3	1893.18	t
487	906	35	4	450.61	t
488	1783	22	4	303.89	t
489	1755	18	4	79.37	t
490	1855	31	2	1332.44	t
491	1504	32	3	2183.08	t
492	107	39	4	1617.44	t
493	694	47	5	2485.68	t
494	1104	9	4	1478.80	t
495	1437	14	1	1611.03	t
496	184	28	3	936.36	t
497	974	13	4	544.74	t
498	1363	31	1	554.60	t
499	1975	36	4	2107.14	t
500	1645	31	3	1222.28	t
501	105	28	3	1210.51	t
502	1090	19	3	1589.42	t
503	1838	39	4	2159.10	t
504	1112	7	2	975.60	t
505	663	34	2	2242.15	t
506	986	14	3	799.14	t
507	1331	33	3	1057.02	t
508	1299	25	1	72.02	t
509	1102	24	2	590.18	t
510	386	37	5	862.38	t
511	1402	16	3	2457.47	t
512	1549	34	5	1667.01	t
513	411	36	4	738.53	t
514	1365	27	5	1290.59	t
515	742	49	3	1457.64	t
516	601	14	3	1082.29	t
517	1455	7	5	1981.65	t
518	1817	29	2	199.79	t
519	372	50	3	1636.94	t
520	250	5	2	1684.40	t
521	1837	32	2	1906.62	t
522	329	5	1	1408.39	t
523	1183	26	2	2471.82	t
524	437	49	4	1289.77	t
525	173	38	1	218.73	t
526	19	45	2	1455.67	t
527	701	6	1	332.25	t
528	1124	43	2	1426.89	t
529	1913	9	4	1111.14	t
530	1885	3	5	1894.55	t
531	502	40	5	2151.17	t
532	346	16	2	1832.57	t
533	1475	19	2	1981.29	t
534	1304	23	4	396.19	t
535	1950	17	3	1030.66	t
536	997	42	4	1621.86	t
537	261	9	3	2279.89	t
538	1941	32	2	2371.09	t
539	1185	21	3	273.14	t
540	1012	39	3	455.04	t
541	639	29	4	2266.56	t
542	1977	20	3	525.84	t
543	955	33	4	716.85	t
544	57	29	1	396.06	t
545	492	18	3	2048.48	t
546	519	10	3	958.12	t
547	1285	40	1	1073.22	t
548	636	17	4	2418.39	t
549	1974	49	1	661.10	t
550	1983	40	5	611.45	t
551	1724	44	4	800.99	t
552	726	33	3	1902.52	t
553	825	44	5	1217.37	t
554	1193	46	5	789.87	t
555	359	32	4	167.11	t
556	1762	10	2	73.77	t
557	695	31	3	1717.45	t
558	132	46	2	2194.74	t
559	959	33	2	229.33	t
560	760	28	3	292.51	t
561	1265	34	5	1171.84	t
562	1072	47	3	495.70	t
563	515	13	4	97.64	t
564	1292	7	3	2076.51	t
565	898	26	1	2479.14	t
566	513	33	5	532.81	t
567	656	22	4	1715.36	t
568	266	30	2	2260.48	t
569	1360	12	3	757.35	t
570	132	18	4	675.03	t
571	218	46	3	212.79	t
572	348	44	4	2074.34	t
573	251	12	3	2444.70	t
574	104	14	3	494.48	t
575	1076	3	1	309.73	t
576	780	42	3	794.60	t
577	1725	24	3	1377.12	t
578	1956	21	3	1520.88	t
579	742	34	2	2371.25	t
580	1019	12	1	1107.12	t
581	740	5	3	1750.85	t
582	1284	40	3	1875.79	t
583	1163	20	2	515.49	t
584	1955	15	3	1992.33	t
585	285	21	4	2237.50	t
586	786	14	5	1538.77	t
587	249	32	1	520.76	t
588	1702	12	4	1537.94	t
589	1295	7	3	752.90	t
590	1009	44	3	1001.51	t
591	1615	35	3	96.56	t
592	469	48	3	1627.04	t
593	1060	48	4	228.41	t
594	561	19	4	511.66	t
595	122	40	1	2142.77	t
596	497	13	4	1838.27	t
597	1331	2	2	1455.20	t
598	1832	39	2	20.65	t
599	1681	6	4	1399.30	t
600	1763	26	3	2363.27	t
601	1818	4	3	2044.65	t
602	212	7	2	946.62	t
603	554	16	2	2493.48	t
604	1913	26	5	522.90	t
605	1399	7	2	836.75	t
606	1423	43	2	1091.14	t
607	132	36	4	234.31	t
608	1744	38	2	404.28	t
609	884	49	2	1719.31	t
610	1415	40	2	1335.33	t
611	1488	7	4	1942.13	t
612	1697	36	2	1185.92	t
613	1905	16	3	881.68	t
614	1434	22	4	1600.92	t
615	16	23	2	1605.80	t
616	54	37	2	559.78	t
617	521	42	2	1954.77	t
618	952	49	4	2153.86	t
619	1462	3	3	2139.71	t
620	1728	42	3	104.93	t
621	654	18	3	1258.38	t
622	1595	45	1	490.17	t
623	22	13	3	1433.94	t
624	1742	16	4	1207.52	t
625	147	24	1	1656.12	t
626	1400	42	2	786.57	t
627	1689	47	2	1119.23	t
628	1094	6	4	1493.01	t
629	441	39	4	2363.86	t
630	1753	17	3	2267.19	t
631	1463	6	3	1438.57	t
632	545	11	3	2369.88	t
633	983	46	2	1897.80	t
634	131	1	5	1697.77	t
635	1424	47	3	2367.04	t
636	1365	22	2	744.26	t
637	1626	14	4	1947.05	t
638	76	13	1	1916.96	t
639	311	17	2	800.83	t
640	1720	23	4	1916.51	t
641	8	17	5	856.18	t
642	305	48	5	1784.47	t
643	1546	46	4	451.80	t
644	1173	49	3	1716.93	t
645	1596	26	2	1685.59	t
646	1531	43	4	1160.34	t
647	1962	10	3	183.37	t
648	1681	13	2	2236.94	t
649	314	6	3	1431.69	t
650	682	19	5	966.80	t
651	1291	49	4	1395.16	t
652	102	11	3	489.09	t
653	1733	47	5	913.86	t
654	1044	19	3	2247.79	t
655	1736	50	4	1935.50	t
656	1106	13	1	213.70	t
657	841	42	4	217.18	t
658	1149	35	5	1739.17	t
659	448	16	4	2088.23	t
660	1389	2	2	1006.42	t
661	633	29	4	2304.67	t
662	1290	12	2	458.67	t
663	1065	36	4	1511.97	t
664	1495	16	2	2224.92	t
665	713	40	3	1278.17	t
666	1766	32	1	193.84	t
667	388	46	4	618.76	t
668	1964	2	2	118.95	t
669	1835	17	3	376.72	t
670	1591	12	2	793.19	t
671	509	16	4	2077.15	t
672	1908	9	4	425.86	t
673	617	47	5	1509.64	t
674	610	21	3	2272.76	t
675	1032	10	2	1998.26	t
676	1379	14	4	2490.86	t
677	6	39	2	942.94	t
678	446	28	4	1600.24	t
679	54	29	4	1199.54	t
680	1540	44	2	1367.18	t
681	24	36	3	388.87	t
682	1413	39	2	1889.07	t
683	1152	34	2	1763.46	t
684	1992	14	3	22.37	t
685	1220	3	4	842.36	t
686	1756	27	3	2275.60	t
687	1452	5	3	806.23	t
688	1778	27	5	224.80	t
689	91	48	4	1274.82	t
690	9	3	3	1186.65	t
691	1522	41	2	1759.84	t
692	1130	31	4	38.83	t
693	501	24	5	985.75	t
694	378	29	3	1886.61	t
695	1084	10	2	713.27	t
696	1078	12	1	436.80	t
697	229	9	4	2177.74	t
698	1659	33	1	1604.54	t
699	1352	41	4	2443.59	t
700	1910	36	3	2268.63	t
701	880	3	2	2152.58	t
702	1833	41	5	2275.21	t
703	774	14	4	91.40	t
704	1177	14	4	1079.40	t
705	310	29	2	2434.44	t
706	1926	24	5	425.09	t
707	1693	16	5	1076.48	t
708	565	49	4	40.64	t
709	546	7	5	1781.19	t
710	68	41	2	1865.95	t
711	814	13	2	2316.58	t
712	1908	28	5	549.89	t
713	1893	36	3	2048.14	t
714	500	32	5	2403.91	t
715	824	12	3	1293.20	t
716	228	15	5	1745.82	t
717	1753	15	4	736.16	t
718	948	11	2	1578.58	t
719	144	11	1	1166.13	t
720	220	49	3	1981.91	t
721	31	25	5	2006.25	t
722	1627	16	4	2315.24	t
723	1738	48	2	1871.97	t
724	1485	31	5	782.08	t
725	934	47	3	2412.77	t
726	1907	42	5	683.07	t
727	1919	48	3	1472.60	t
728	1069	11	3	99.10	t
729	1551	19	3	1395.08	t
730	331	3	4	886.83	t
731	589	36	4	1085.54	t
732	1297	28	1	987.38	t
733	228	37	4	1330.56	t
734	369	39	2	711.97	t
735	308	12	4	1925.59	t
736	885	36	5	977.96	t
737	310	40	5	722.72	t
738	1601	11	3	1643.96	t
739	498	16	3	2257.26	t
740	77	49	2	24.41	t
741	1459	25	5	1577.73	t
742	1315	21	3	1388.17	t
743	197	6	2	430.44	t
744	1731	35	2	1668.38	t
745	1754	24	2	2408.81	t
746	1378	8	4	1834.73	t
747	1959	3	3	581.43	t
748	698	38	3	216.05	t
749	1674	11	4	466.41	t
750	1440	43	2	770.41	t
751	1216	21	2	2148.70	t
752	1813	18	4	2455.17	t
753	958	46	3	1844.18	t
754	1096	6	5	1243.07	t
755	1743	35	4	1613.75	t
756	404	49	3	767.52	t
757	957	10	2	1815.06	t
758	15	49	5	1219.71	t
759	1434	28	3	867.24	t
760	1205	43	5	2349.76	t
761	1836	4	2	1892.37	t
762	380	8	5	1096.64	t
763	971	21	2	689.85	t
764	1510	2	5	2302.69	t
765	982	5	3	1246.95	t
766	1872	24	4	1855.10	t
767	1636	15	4	32.03	t
768	454	22	3	862.75	t
769	1310	11	4	1269.33	t
770	1439	37	4	1513.30	t
771	1215	41	3	410.93	t
772	1934	34	2	2148.63	t
773	1206	20	5	468.15	t
774	348	11	2	89.60	t
775	702	36	3	1916.56	t
776	1834	33	5	1534.57	t
777	607	21	5	1242.48	t
778	708	14	3	1678.45	t
779	1409	40	2	1079.78	t
780	1318	36	2	2024.33	t
781	1840	49	4	1400.89	t
782	1228	43	2	164.46	t
783	1086	30	3	1144.39	t
784	341	24	2	1221.96	t
785	797	1	4	1256.86	t
786	1634	12	5	362.75	t
787	1388	20	4	2479.60	t
788	50	10	3	355.64	t
789	819	29	4	2184.59	t
790	219	44	5	399.07	t
791	235	21	3	1451.08	t
792	839	10	3	1443.42	t
793	262	18	4	607.55	t
794	1027	18	2	239.12	t
795	633	36	4	1278.66	t
796	670	22	3	2402.30	t
797	314	21	2	2493.63	t
798	1509	21	3	1230.49	t
799	955	27	1	2450.58	t
800	163	36	3	2012.66	t
801	80	37	3	332.06	t
802	230	6	3	1622.16	t
803	1865	39	3	2278.86	t
804	909	16	2	1463.19	t
805	1052	11	3	2222.88	t
806	1809	28	2	2429.60	t
807	807	47	2	624.97	t
808	1459	34	3	2073.76	t
809	589	38	4	2153.94	t
810	1447	16	1	1399.41	t
811	856	23	4	2271.30	t
812	552	26	4	1685.00	t
813	1314	12	1	1166.23	t
814	1467	3	4	2169.31	t
815	1045	28	1	111.62	t
816	441	30	4	499.59	t
817	214	23	1	2453.85	t
818	1070	46	1	1808.03	t
819	498	21	4	705.67	t
820	1401	14	5	1143.99	t
821	762	1	2	1974.67	t
822	915	4	2	2024.24	t
823	969	47	4	1725.37	t
824	545	45	4	1660.64	t
825	792	10	4	738.23	t
826	369	15	4	676.26	t
827	1049	37	4	1765.96	t
828	1445	3	3	377.25	t
829	1910	4	4	1361.74	t
830	968	12	3	1998.41	t
831	1632	32	1	1033.26	t
832	1713	47	5	989.57	t
833	573	30	2	153.47	t
834	1224	1	4	1152.92	t
835	878	30	3	1231.70	t
836	49	4	2	77.01	t
837	1063	16	2	2245.69	t
838	1924	31	4	2303.92	t
839	990	18	3	1713.44	t
840	1877	16	1	1975.23	t
841	742	5	1	664.74	t
842	341	27	3	794.21	t
843	1056	36	2	1688.36	t
844	1685	18	2	2198.49	t
845	438	25	5	550.90	t
846	246	27	2	409.68	t
847	183	49	3	860.33	t
848	1003	41	5	997.61	t
849	797	16	3	1610.14	t
850	1277	21	3	1745.47	t
851	1147	15	3	1064.69	t
852	57	42	3	1955.73	t
853	869	17	2	1292.47	t
854	753	45	3	1258.32	t
855	23	34	5	549.37	t
856	650	6	3	693.27	t
857	389	44	2	2209.96	t
858	1468	39	2	93.64	t
859	559	46	5	308.77	t
860	201	3	3	1902.90	t
861	1029	29	2	928.74	t
862	28	42	3	1390.15	t
863	78	45	4	473.99	t
864	343	10	4	332.10	t
865	1724	24	1	815.04	t
866	1566	14	5	1012.74	t
867	1258	24	2	1908.03	t
868	226	44	1	2265.57	t
869	391	50	2	426.19	t
870	945	9	1	1430.76	t
871	1242	18	2	1581.70	t
872	917	40	4	185.93	t
873	759	41	1	2212.53	t
874	1469	21	4	1822.80	t
875	1172	16	1	751.86	t
876	1548	8	3	1966.53	t
877	1149	48	4	1926.51	t
878	1567	38	5	1565.08	t
879	109	19	4	2462.71	t
880	1697	15	4	1515.71	t
881	1415	12	5	1009.20	t
882	69	39	5	937.64	t
883	1506	13	5	606.28	t
884	1041	46	3	1616.32	t
885	111	39	4	1162.17	t
886	42	4	3	1774.57	t
887	1079	38	2	1550.24	t
888	885	39	2	1892.26	t
889	553	44	1	2121.19	t
890	1181	50	3	849.31	t
891	540	4	4	1072.15	t
892	633	23	2	2294.83	t
893	896	46	1	85.93	t
894	1279	43	4	1173.78	t
895	329	32	2	1653.22	t
896	1685	20	2	635.45	t
897	827	13	2	1143.41	t
898	601	32	3	1707.92	t
899	1907	29	3	2464.63	t
900	453	12	2	1612.79	t
901	377	27	3	202.87	t
902	1874	30	3	1935.62	t
903	158	19	3	1408.02	t
904	1563	27	4	1344.58	t
905	734	40	3	162.62	t
906	437	12	1	1198.58	t
907	784	27	2	2226.80	t
908	1478	3	3	1743.23	t
909	1354	7	2	94.69	t
910	1810	9	1	2161.60	t
911	1427	32	3	1351.12	t
912	1899	9	2	1866.68	t
913	886	15	4	176.56	t
914	1898	16	5	2394.47	t
915	887	7	3	1084.13	t
916	189	26	4	1817.58	t
917	1299	18	5	52.59	t
918	1537	18	3	2092.56	t
919	1551	27	3	2285.20	t
920	1414	9	2	575.81	t
921	952	16	2	236.17	t
922	627	41	4	701.27	t
923	235	7	5	1970.57	t
924	1524	43	4	2410.30	t
925	927	11	3	987.20	t
926	183	31	4	1189.10	t
927	492	38	3	1861.31	t
928	1227	49	2	568.39	t
929	274	48	4	476.93	t
930	822	38	1	1866.68	t
931	1606	26	3	1676.21	t
932	604	12	2	1247.68	t
933	106	31	3	760.92	t
934	1680	5	3	2461.92	t
935	1396	37	4	1331.71	t
936	1674	9	3	251.23	t
937	410	34	5	1329.42	t
938	340	33	1	1479.24	t
939	170	21	2	329.70	t
940	1529	6	4	2234.50	t
941	350	41	1	2149.47	t
942	1628	7	2	349.18	t
943	466	26	4	1620.92	t
944	600	11	3	2072.52	t
945	1968	38	4	2389.42	t
946	789	33	2	1642.41	t
947	608	27	2	2090.72	t
948	243	18	2	1119.30	t
949	1848	49	1	2033.20	t
950	1049	11	2	2187.92	t
951	213	44	2	1421.98	t
952	378	24	3	2121.28	t
953	1002	25	3	893.74	t
954	1065	28	2	534.97	t
955	1011	14	5	2236.02	t
956	841	20	5	1410.18	t
957	581	7	2	1217.45	t
958	1819	8	1	1084.51	t
959	574	32	3	1857.88	t
960	1322	47	4	1416.57	t
961	1333	37	4	2343.29	t
962	25	3	5	2146.38	t
963	487	7	5	329.76	t
964	278	23	1	1475.58	t
965	840	46	2	1124.57	t
966	588	38	1	1489.16	t
967	1183	10	4	2482.87	t
968	586	42	4	126.28	t
969	360	18	2	1706.40	t
970	1029	23	2	1996.24	t
971	58	23	4	1926.84	t
972	449	45	4	2483.88	t
973	1741	24	5	224.32	t
974	808	12	1	1745.07	t
975	1785	48	3	1120.77	t
976	1289	30	4	851.21	t
977	1241	14	2	2384.52	t
978	1895	40	4	1174.07	t
979	846	19	4	42.41	t
980	49	35	4	1220.22	t
981	229	48	4	711.21	t
982	683	11	3	1887.49	t
983	788	30	2	2490.50	t
984	273	15	3	666.95	t
985	22	30	5	35.71	t
986	104	14	2	608.72	t
987	1863	48	2	952.22	t
988	1981	35	4	730.88	t
989	1385	48	3	471.27	t
990	1814	10	2	2092.59	t
991	1067	22	2	657.84	t
992	1702	31	4	1979.76	t
993	277	7	3	1657.07	t
994	296	1	2	125.00	t
995	397	39	3	1182.84	t
996	298	31	3	1517.96	t
997	566	18	1	195.50	t
998	452	5	2	806.76	t
999	1820	44	2	1519.05	t
1000	870	40	3	454.38	t
1001	1023	12	4	2348.09	t
1002	1950	15	5	2059.90	t
1003	1088	37	4	702.50	t
1004	1893	48	3	1590.79	t
1005	1569	45	3	1338.31	t
1006	1626	25	3	1955.92	t
1007	900	44	3	131.15	t
1008	769	36	4	2445.70	t
1009	178	31	1	990.35	t
1010	1156	30	5	68.64	t
1011	1945	11	5	216.38	t
1012	540	11	3	1580.42	t
1013	170	26	1	1753.48	t
1014	288	25	5	1900.57	t
1015	1313	20	4	1222.05	t
1016	363	34	4	1999.07	t
1017	620	39	1	140.73	t
1018	959	15	2	2477.38	t
1019	1371	25	3	200.56	t
1020	724	34	3	1456.17	t
1021	928	42	4	1978.50	t
1022	90	36	1	1771.05	t
1023	1335	7	2	893.98	t
1024	1867	5	4	2285.29	t
1025	737	48	1	1033.51	t
1026	316	6	1	2018.28	t
1027	1073	11	4	287.63	t
1028	265	34	4	2032.28	t
1029	1396	27	3	1897.96	t
1030	820	33	1	100.98	t
1031	1849	7	4	1827.90	t
1032	1803	19	3	1474.98	t
1033	792	13	3	1150.50	t
1034	830	4	2	1828.33	t
1035	398	28	4	1794.86	t
1036	735	31	1	1458.50	t
1037	6	18	5	175.91	t
1038	1521	14	4	1164.91	t
1039	764	11	4	967.73	t
1040	140	15	3	133.80	t
1041	265	33	3	515.21	t
1042	1126	19	1	1486.73	t
1043	1425	7	3	1823.33	t
1044	623	36	5	1589.73	t
1045	865	29	3	1069.60	t
1046	326	9	4	1935.10	t
1047	1410	41	3	2438.82	t
1048	890	32	3	1844.02	t
1049	1565	8	3	2175.06	t
1050	391	39	4	1980.04	t
1051	425	40	4	230.43	t
1052	1834	4	3	1478.28	t
1053	73	41	1	547.02	t
1054	879	31	4	45.97	t
1055	182	48	1	1939.32	t
1056	1868	42	4	1999.76	t
1057	547	20	1	1097.61	t
1058	369	5	4	1814.29	t
1059	1223	18	2	544.73	t
1060	32	20	4	2490.77	t
1061	1986	8	3	1659.97	t
1062	66	50	2	2460.58	t
1063	486	2	4	1247.66	t
1064	1791	47	1	1550.32	t
1065	1394	45	2	2057.42	t
1066	1192	11	3	2210.21	t
1067	830	2	2	1437.00	t
1068	1950	24	2	1759.43	t
1069	591	18	3	2250.12	t
1070	1188	31	3	620.05	t
1071	1851	44	4	1157.34	t
1072	1523	17	5	1349.97	t
1073	463	25	3	1412.08	t
1074	11	49	5	679.68	t
1075	933	30	5	1909.61	t
1076	1532	27	5	1928.68	t
1077	1096	13	3	1399.42	t
1078	263	45	2	1366.51	t
1079	565	11	4	2415.53	t
1080	1545	20	3	2047.21	t
1081	1059	3	3	2388.94	t
1082	717	11	4	691.81	t
1083	1368	15	3	605.59	t
1084	327	9	2	2362.63	t
1085	394	21	5	1931.78	t
1086	83	13	4	904.29	t
1087	1072	27	2	1555.69	t
1088	223	9	4	1434.72	t
1089	1472	44	2	1302.96	t
1090	1515	26	5	109.74	t
1091	269	34	3	176.56	t
1092	844	3	2	2343.65	t
1093	1386	3	3	2026.77	t
1094	426	11	3	616.91	t
1095	1867	8	2	894.50	t
1096	1070	46	4	400.41	t
1097	1458	42	2	288.05	t
1098	1493	13	5	1452.70	t
1099	1956	42	4	275.29	t
1100	941	25	2	788.00	t
1101	1069	45	1	235.56	t
1102	1849	45	2	1625.10	t
1103	489	32	4	1984.62	t
1104	1443	19	2	1169.35	t
1105	1153	4	2	1589.21	t
1106	790	15	4	2143.01	t
1107	1440	30	2	1322.92	t
1108	1815	10	2	1527.87	t
1109	455	43	5	2137.61	t
1110	956	14	3	1915.07	t
1111	1175	6	4	304.44	t
1112	1316	47	3	724.29	t
1113	987	31	2	1261.72	t
1114	474	27	3	690.83	t
1115	838	37	5	592.50	t
1116	1330	3	4	1260.59	t
1117	342	13	4	1598.89	t
1118	791	20	3	1708.77	t
1119	157	33	2	2153.82	t
1120	1332	40	5	108.26	t
1121	1356	8	2	1817.22	t
1122	696	26	2	1652.67	t
1123	1014	45	3	893.68	t
1124	315	33	3	964.48	t
1125	1961	13	1	2378.08	t
1126	274	15	2	227.68	t
1127	49	6	4	2481.24	t
1128	588	38	5	1004.44	t
1129	1038	46	4	1014.46	t
1130	1907	13	4	1249.07	t
1131	1289	25	2	1469.67	t
1132	556	15	1	1003.18	t
1133	153	34	2	2133.05	t
1134	686	11	3	902.77	t
1135	1084	44	5	1809.87	t
1136	1172	20	4	2128.49	t
1137	9	30	1	998.18	t
1138	1072	11	3	2375.83	t
1139	762	2	2	1403.13	t
1140	80	25	5	2195.88	t
1141	1652	15	1	798.20	t
1142	1285	29	3	2391.36	t
1143	1121	45	3	2493.52	t
1144	1615	33	4	606.63	t
1145	1175	43	4	276.01	t
1146	1134	10	1	2029.63	t
1147	1857	35	4	1387.83	t
1148	1456	35	4	1234.82	t
1149	1687	24	4	1954.89	t
1150	1078	2	2	2117.65	t
1151	1947	9	4	485.57	t
1152	689	39	4	1780.50	t
1153	280	27	4	2094.20	t
1154	1201	36	1	422.51	t
1155	617	22	4	367.73	t
1156	74	3	3	2470.03	t
1157	797	17	4	1879.99	t
1158	771	11	4	1118.23	t
1159	81	37	4	1628.03	t
1160	598	39	2	459.10	t
1161	1170	9	3	2106.41	t
1162	1869	24	3	1120.98	t
1163	1509	38	3	705.53	t
1164	645	14	2	401.00	t
1165	1618	29	3	1333.01	t
1166	1769	39	5	2264.10	t
1167	984	3	2	2170.06	t
1168	134	43	1	2058.96	t
1169	527	37	2	1377.24	t
1170	1004	5	3	1164.48	t
1171	380	30	4	543.73	t
1172	1728	1	4	1347.71	t
1173	709	38	2	1633.17	t
1174	1321	43	4	1395.63	t
1175	1502	22	3	2473.17	t
1176	1923	8	2	387.30	t
1177	788	49	2	1473.39	t
1178	1410	2	1	1687.03	t
1179	375	29	3	1438.01	t
1180	7	37	4	1016.91	t
1181	378	23	1	768.78	t
1182	1408	35	3	1377.40	t
1183	207	9	1	1639.41	t
1184	740	13	4	765.52	t
1185	1678	45	4	509.98	t
1186	771	25	2	615.20	t
1187	444	15	5	1030.07	t
1188	882	48	5	140.67	t
1189	1919	15	1	2390.23	t
1190	507	36	4	68.71	t
1191	629	1	3	1971.68	t
1192	402	37	1	452.10	t
1193	1220	25	2	70.25	t
1194	526	8	1	171.56	t
1195	1444	39	2	165.29	t
1196	1497	6	2	1252.02	t
1197	1688	12	3	1659.42	t
1198	534	47	4	104.85	t
1199	904	5	5	1418.78	t
1200	348	35	4	1385.42	t
1201	218	12	4	1584.31	t
1202	1794	15	3	1714.59	t
1203	985	4	5	894.37	t
1204	379	40	3	1273.28	t
1205	1913	44	3	1215.94	t
1206	411	3	4	1019.31	t
1207	440	36	4	2190.30	t
1208	270	44	1	374.47	t
1209	1162	17	2	1012.11	t
1210	1242	20	2	1365.13	t
1211	1447	30	3	714.21	t
1212	1961	10	2	2021.55	t
1213	1905	46	3	1760.64	t
1214	638	19	3	2301.82	t
1215	641	4	3	1758.07	t
1216	348	6	3	2073.95	t
1217	1042	5	4	62.15	t
1218	1715	46	4	316.65	t
1219	904	21	4	1894.53	t
1220	1590	31	4	2112.51	t
1221	1629	19	4	1429.86	t
1222	99	11	1	914.26	t
1223	38	29	2	527.99	t
1224	608	2	1	1202.53	t
1225	1448	9	4	1660.56	t
1226	300	17	4	1524.57	t
1227	750	23	5	1548.16	t
1228	127	42	2	2403.87	t
1229	1989	16	2	1900.87	t
1230	34	41	3	1966.26	t
1231	1258	43	2	225.41	t
1232	639	26	2	1777.03	t
1233	642	10	2	1913.11	t
1234	698	49	1	2072.45	t
1235	1786	50	2	1819.07	t
1236	1671	39	2	2262.17	t
1237	270	41	2	444.48	t
1238	1539	8	4	873.68	t
1239	386	32	3	1757.36	t
1240	1575	48	4	1321.23	t
1241	850	37	4	1978.59	t
1242	775	6	3	391.05	t
1243	1477	40	4	2014.76	t
1244	777	11	2	2080.50	t
1245	78	14	2	2291.41	t
1246	220	19	4	2237.33	t
1247	715	26	2	1430.22	t
1248	632	32	3	176.92	t
1249	211	13	4	1279.79	t
1250	1246	7	1	2151.38	t
1251	554	45	3	902.48	t
1252	616	49	4	1191.74	t
1253	1651	36	4	2093.93	t
1254	1267	21	2	271.35	t
1255	1122	34	4	1978.83	t
1256	1675	27	4	1969.56	t
1257	1567	37	3	2182.30	t
1258	1582	18	2	1896.45	t
1259	1216	1	3	1408.32	t
1260	371	26	3	1021.95	t
1261	1748	15	3	1694.28	t
1262	1768	16	2	1115.34	t
1263	1163	31	3	1604.47	t
1264	1506	4	3	1056.36	t
1265	1676	19	3	952.10	t
1266	802	6	4	1475.18	t
1267	794	15	1	1436.07	t
1268	116	38	3	1523.89	t
1269	801	30	2	2176.66	t
1270	432	6	4	791.79	t
1271	785	3	2	2024.17	t
1272	810	6	1	1367.49	t
1273	930	49	5	78.31	t
1274	603	41	4	1696.15	t
1275	33	16	2	132.50	t
1276	726	39	2	2389.34	t
1277	583	14	2	458.46	t
1278	100	5	2	2299.24	t
1279	1270	23	2	850.25	t
1280	697	27	4	1958.35	t
1281	1970	37	4	431.67	t
1282	697	4	2	1385.08	t
1283	1385	18	2	1782.81	t
1284	1752	40	3	1666.01	t
1285	718	27	2	1119.81	t
1286	527	9	3	1953.53	t
1287	1998	4	4	1224.99	t
1288	1725	13	3	540.08	t
1289	919	20	2	1354.71	t
1290	1128	30	3	1786.41	t
1291	712	37	5	2299.92	t
1292	343	27	3	1942.88	t
1293	1947	10	2	1639.77	t
1294	442	15	1	1102.31	t
1295	964	18	3	1674.24	t
1296	65	30	2	2241.55	t
1297	504	33	2	1005.75	t
1298	663	15	2	551.18	t
1299	860	26	3	2204.01	t
1300	377	6	3	1437.49	t
1301	805	30	3	2251.46	t
1302	185	26	2	2172.91	t
1303	1001	19	4	991.53	t
1304	1285	30	2	1604.59	t
1305	1820	4	4	21.53	t
1306	785	32	4	1097.28	t
1307	1477	8	5	2242.86	t
1308	1363	17	1	89.20	t
1309	234	4	2	2185.77	t
1310	322	28	1	688.69	t
1311	84	42	2	1784.36	t
1312	1025	8	2	1896.12	t
1313	1100	33	5	2355.93	t
1314	775	41	2	560.34	t
1315	1867	9	4	1850.42	t
1316	452	48	3	1968.46	t
1317	1933	10	3	903.27	t
1318	622	44	3	1956.51	t
1319	270	48	4	1257.52	t
1320	1563	7	1	2451.28	t
1321	1767	48	4	1557.32	t
1322	973	40	3	1819.58	t
1323	995	31	2	2026.71	t
1324	1492	45	3	491.32	t
1325	1641	40	1	1525.95	t
1326	270	46	2	806.00	t
1327	1577	22	4	2318.42	t
1328	40	2	2	1277.20	t
1329	1689	18	4	1255.62	t
1330	1676	28	3	1269.77	t
1331	1663	22	2	2120.14	t
1332	1139	34	5	1578.64	t
1333	683	23	3	2086.34	t
1334	452	42	2	2417.57	t
1335	104	40	2	431.88	t
1336	592	18	5	1777.36	t
1337	1629	36	4	376.64	t
1338	580	43	4	1150.35	t
1339	740	31	1	996.49	t
1340	1681	38	4	1617.43	t
1341	534	7	3	1319.03	t
1342	122	49	1	2354.04	t
1343	964	37	4	2082.55	t
1344	761	29	4	1127.52	t
1345	1373	21	1	624.91	t
1346	1958	49	3	1910.29	t
1347	1961	35	1	493.65	t
1348	1548	47	4	839.13	t
1349	1372	35	5	1750.35	t
1350	1261	12	2	445.19	t
1351	962	6	1	2076.75	t
1352	1739	21	1	1486.24	t
1353	509	11	3	437.23	t
1354	830	32	1	975.84	t
1355	1795	22	3	1138.25	t
1356	443	9	1	1172.97	t
1357	1379	3	2	2282.03	t
1358	1793	46	3	926.30	t
1359	161	34	5	2379.70	t
1360	1258	45	2	2349.94	t
1361	169	5	2	1257.67	t
1362	1910	48	1	1625.43	t
1363	1961	10	3	458.23	t
1364	1317	47	4	1561.39	t
1365	45	19	4	214.04	t
1366	1110	42	1	2238.09	t
1367	1606	1	1	1374.43	t
1368	1298	18	1	2178.96	t
1369	350	35	2	1641.59	t
1370	496	38	4	511.39	t
1371	895	3	5	1635.11	t
1372	465	23	2	124.98	t
1373	630	18	2	25.80	t
1374	598	36	4	1039.88	t
1375	972	9	2	2205.75	t
1376	1323	33	1	876.10	t
1377	366	21	3	826.00	t
1378	1512	21	3	789.04	t
1379	1144	50	4	1561.11	t
1380	297	19	3	992.92	t
1381	855	35	3	2081.79	t
1382	487	31	5	1044.05	t
1383	973	11	3	1694.18	t
1384	706	47	3	1703.59	t
1385	1130	43	3	1015.96	t
1386	429	34	5	478.15	t
1387	1328	13	2	230.64	t
1388	1748	37	2	454.86	t
1389	865	33	4	1394.76	t
1390	629	34	3	1353.68	t
1391	991	46	1	2414.36	t
1392	236	24	3	2333.55	t
1393	1782	43	2	2078.06	t
1394	111	26	3	1605.12	t
1395	1624	26	1	837.57	t
1396	1051	38	1	1558.08	t
1397	1162	14	4	1316.70	t
1398	1342	44	1	1622.15	t
1399	1934	45	2	2277.25	t
1400	735	4	2	418.23	t
1401	426	46	5	869.23	t
1402	1939	12	5	826.05	t
1403	627	31	3	1616.14	t
1404	73	23	5	570.09	t
1405	518	39	4	1053.00	t
1406	588	29	4	1934.42	t
1407	763	16	3	153.37	t
1408	393	32	2	1319.47	t
1409	221	48	2	1701.53	t
1410	368	2	4	378.02	t
1411	619	10	5	1186.69	t
1412	908	32	4	2105.16	t
1413	439	38	3	1862.15	t
1414	1536	6	4	2154.66	t
1415	43	13	3	2401.24	t
1416	670	3	3	639.65	t
1417	1539	9	2	2424.39	t
1418	1744	32	3	872.61	t
1419	1177	38	2	1989.39	t
1420	457	41	3	1916.88	t
1421	575	15	1	2466.34	t
1422	669	15	2	1993.98	t
1423	1812	27	4	1281.40	t
1424	1330	11	3	566.33	t
1425	848	6	1	131.30	t
1426	887	3	2	1677.26	t
1427	1350	15	2	1063.57	t
1428	905	22	4	56.99	t
1429	1555	6	5	1360.15	t
1430	1213	32	3	511.50	t
1431	1521	44	4	1885.92	t
1432	1310	15	2	1373.76	t
1433	298	31	4	716.97	t
1434	127	11	4	517.99	t
1435	370	23	3	905.24	t
1436	647	9	1	235.25	t
1437	262	6	3	814.07	t
1438	1249	2	4	2354.10	t
1439	832	12	4	701.37	t
1440	1263	36	2	33.86	t
1441	705	48	2	1334.21	t
1442	1030	27	2	1490.20	t
1443	767	16	1	1195.41	t
1444	1147	5	1	2026.82	t
1445	636	28	1	2332.07	t
1446	1464	41	2	2041.93	t
1447	775	16	2	1638.27	t
1448	684	22	1	1568.54	t
1449	989	45	3	1031.69	t
1450	1584	7	2	111.89	t
1451	1732	15	1	2227.61	t
1452	308	7	3	1635.27	t
1453	1067	33	3	1504.72	t
1454	117	46	4	1471.47	t
1455	401	43	3	2321.87	t
1456	106	34	4	714.04	t
1457	1987	13	2	1494.08	t
1458	1399	43	1	1135.40	t
1459	1107	6	5	371.50	t
1460	582	21	4	967.93	t
1461	32	10	3	1842.35	t
1462	1131	18	3	2203.52	t
1463	1166	14	3	333.83	t
1464	270	36	2	1580.24	t
1465	1160	7	2	269.08	t
1466	1326	25	2	1879.53	t
1467	149	41	5	2116.48	t
1468	1776	22	2	1740.89	t
1469	127	12	3	2003.36	t
1470	1560	15	5	2010.46	t
1471	25	38	3	354.26	t
1472	1610	11	2	402.15	t
1473	1118	34	5	2266.99	t
1474	1941	23	1	1242.51	t
1475	51	28	3	685.62	t
1476	1265	48	2	859.14	t
1477	1682	8	1	2159.04	t
1478	1600	41	3	833.26	t
1479	1910	35	3	407.84	t
1480	102	23	4	1519.76	t
1481	1464	8	2	695.45	t
1482	143	30	2	1089.99	t
1483	1396	31	4	919.87	t
1484	409	29	4	336.73	t
1485	1606	11	4	1072.06	t
1486	115	3	5	1124.06	t
1487	729	15	2	2325.50	t
1488	1231	9	2	1412.36	t
1489	1161	6	5	1964.49	t
1490	1096	13	5	1205.86	t
1491	348	3	3	1560.26	t
1492	874	15	3	853.07	t
1493	9	17	2	371.22	t
1494	1994	33	2	2137.44	t
1495	1912	37	2	1638.01	t
1496	172	34	2	1406.00	t
1497	1202	46	1	1477.88	t
1498	734	48	1	502.03	t
1499	531	10	2	1654.88	t
1500	350	5	2	44.23	t
1501	1843	13	3	1242.09	t
1502	1457	25	4	2281.90	t
1503	599	10	2	620.84	t
1504	1102	40	1	1985.17	t
1505	1559	42	1	697.47	t
1506	1959	7	4	2189.92	t
1507	972	33	3	1120.31	t
1508	600	34	4	547.42	t
1509	1374	38	2	2209.18	t
1510	721	32	3	91.07	t
1511	1706	3	2	1016.20	t
1512	927	16	4	1942.05	t
1513	236	7	2	83.14	t
1514	1492	11	2	2337.64	t
1515	619	24	2	1059.36	t
1516	1	1	1	147.54	t
1517	1656	39	4	523.45	t
1518	1500	7	1	1923.55	t
1519	831	40	1	1852.44	t
1520	198	7	3	2307.41	t
1521	34	38	3	1511.67	t
1522	540	10	5	153.58	t
1523	1679	28	4	1567.62	t
1524	727	18	5	1373.86	t
1525	451	18	3	1761.06	t
1526	1054	5	2	1402.87	t
1527	1362	8	3	2062.96	t
1528	1071	42	3	189.64	t
1529	355	34	1	2171.50	t
1530	1100	47	3	2358.88	t
1531	847	45	5	1895.59	t
1532	41	25	4	822.38	t
1533	1407	22	5	484.20	t
1534	1121	19	3	1094.14	t
1535	759	26	5	905.17	t
1536	1699	11	1	1483.33	t
1537	595	21	1	519.42	t
1538	1973	5	3	2130.69	t
1539	143	47	3	1483.77	t
1540	471	6	3	1822.21	t
1541	1206	7	4	1608.36	t
1542	257	45	3	1905.44	t
1543	873	43	3	1982.05	t
1544	1992	22	2	891.25	t
1545	960	10	5	1715.29	t
1546	45	17	4	841.54	t
1547	880	15	4	2049.76	t
1548	777	44	4	1618.28	t
1549	154	43	4	252.99	t
1550	1853	5	4	1368.49	t
1551	1793	37	5	628.69	t
1552	31	39	2	1156.99	t
1553	1995	32	2	1598.28	t
1554	364	6	2	542.71	t
1555	1456	25	4	2375.43	t
1556	1723	13	2	1361.66	t
1557	284	29	2	643.33	t
1558	827	11	5	1632.37	t
1559	1539	4	4	1351.20	t
1560	1960	22	5	742.62	t
1561	188	30	4	542.17	t
1562	242	15	4	2473.12	t
1563	666	40	5	1393.24	t
1564	119	18	3	1252.03	t
1565	98	12	3	814.85	t
1566	1435	33	3	518.65	t
1567	1917	43	4	1665.80	t
1568	1992	10	3	999.34	t
1569	443	15	2	1056.12	t
1570	1357	17	2	854.62	t
1571	1803	14	1	984.97	t
1572	438	1	2	2098.21	t
1573	827	30	5	2108.87	t
1574	394	9	4	661.63	t
1575	1569	32	2	2021.01	t
1576	1693	29	3	1345.68	t
1577	100	38	3	871.97	t
1578	1593	46	1	1275.01	t
1579	1709	2	3	1317.00	t
1580	1371	50	3	100.68	t
1581	508	45	2	493.80	t
1582	1411	33	4	1904.22	t
1583	1085	26	1	125.66	t
1584	651	9	3	1674.00	t
1585	287	16	5	1184.64	t
1586	476	35	2	1460.52	t
1587	354	20	1	167.70	t
1588	889	48	3	2065.99	t
1589	488	12	5	1539.46	t
1590	1460	5	5	854.00	t
1591	1638	49	2	678.17	t
1592	1004	24	3	1159.08	t
1593	1604	49	4	645.53	t
1594	268	43	3	51.33	t
1595	1445	40	5	968.81	t
1596	136	36	3	1448.39	t
1597	1089	23	2	1976.68	t
1598	1669	19	5	2223.63	t
1599	144	17	2	2149.28	t
1600	751	25	4	1141.67	t
1601	1151	19	3	1078.69	t
1602	840	48	1	943.72	t
1603	1645	32	1	184.80	t
1604	181	49	1	916.63	t
1605	1687	22	2	172.24	t
1606	94	26	2	1692.92	t
1607	1368	21	2	1381.06	t
1608	1267	21	3	1158.53	t
1609	1744	27	3	1280.09	t
1610	580	14	1	829.70	t
1611	287	11	2	1421.35	t
1612	1425	29	5	1159.96	t
1613	931	44	3	1136.22	t
1614	1246	15	2	1580.23	t
1615	1080	4	5	2106.55	t
1616	986	6	3	1240.70	t
1617	1496	20	5	708.67	t
1618	1608	40	2	2499.83	t
1619	483	45	5	1729.70	t
1620	5	25	2	947.81	t
1621	338	22	4	611.94	t
1622	1409	9	1	2376.87	t
1623	251	47	4	1556.47	t
1624	158	17	2	1700.12	t
1625	1970	35	3	140.90	t
1626	86	11	3	996.28	t
1627	568	7	3	979.18	t
1628	729	38	3	2372.45	t
1629	369	37	2	919.27	t
1630	1356	14	4	714.52	t
1631	16	43	4	1736.35	t
1632	44	22	4	1589.32	t
1633	526	34	4	957.58	t
1634	319	1	2	2114.65	t
1635	928	28	4	1038.07	t
1636	750	42	2	2158.08	t
1637	1999	11	2	2105.25	t
1638	1511	36	3	1181.47	t
1639	1432	37	2	2036.99	t
1640	1494	19	4	976.13	t
1641	1918	48	2	2154.48	t
1642	1867	49	3	480.86	t
1643	1938	24	1	701.84	t
1644	1206	31	3	2139.16	t
1645	631	40	4	201.80	t
1646	1594	44	3	1724.31	t
1647	1185	20	1	437.11	t
1648	759	35	5	1387.14	t
1649	1316	44	5	1239.33	t
1650	428	50	2	1859.99	t
1651	522	46	3	158.24	t
1652	1871	46	5	2360.29	t
1653	1528	31	5	2306.94	t
1654	471	32	3	695.26	t
1655	1410	30	2	2488.43	t
1656	1517	17	2	1367.15	t
1657	130	3	2	996.68	t
1658	184	22	2	2039.79	t
1659	48	9	3	314.61	t
1660	1236	20	5	1581.62	t
1661	579	32	3	42.69	t
1662	1287	2	4	502.86	t
1663	1964	3	2	2296.75	t
1664	1779	47	2	1101.85	t
1665	9	34	5	752.56	t
1666	1735	27	2	1361.22	t
1667	477	29	5	1246.90	t
1668	1015	42	1	2043.31	t
1669	716	5	2	1591.85	t
1670	522	11	1	1714.15	t
1671	1300	40	2	1695.60	t
1672	1873	31	3	2035.33	t
1673	1376	25	3	1354.41	t
1674	86	31	3	1795.13	t
1675	311	24	5	2021.03	t
1676	757	11	5	1096.25	t
1677	48	24	1	2209.31	t
1678	1197	22	2	1032.96	t
1679	78	3	5	1795.26	t
1680	1350	8	2	1437.01	t
1681	928	7	1	2335.00	t
1682	8	7	4	1828.03	t
1683	1135	45	5	2242.37	t
1684	1660	2	1	65.65	t
1685	646	28	2	1025.25	t
1686	365	4	2	191.78	t
1687	221	4	4	829.24	t
1688	549	11	3	569.55	t
1689	733	47	2	632.90	t
1690	399	29	1	559.50	t
1691	526	47	3	516.33	t
1692	1968	12	1	30.90	t
1693	128	27	4	1517.10	t
1694	1445	18	2	1351.20	t
1695	1154	4	4	555.67	t
1696	796	11	3	1786.98	t
1697	285	17	4	2357.91	t
1698	389	38	2	548.27	t
1699	326	47	4	1999.08	t
1700	1878	17	4	1434.80	t
1701	863	30	3	2023.15	t
1702	16	33	3	1227.06	t
1703	1216	4	2	788.13	t
1704	1268	36	3	1842.51	t
1705	1791	24	2	1362.06	t
1706	148	16	2	1550.47	t
1707	1017	41	5	1584.34	t
1708	694	44	3	887.86	t
1709	158	30	5	2346.64	t
1710	838	3	4	1519.38	t
1711	888	18	1	103.43	t
1712	1108	37	5	2223.03	t
1713	1698	15	3	1727.37	t
1714	1927	45	5	1823.43	t
1715	1085	21	3	1610.69	t
1716	1274	4	5	687.00	t
1717	1075	27	1	768.88	t
1718	528	46	3	253.59	t
1719	42	1	1	672.45	t
1720	1940	36	4	1279.98	t
1721	599	12	3	115.72	t
1722	147	10	3	1171.90	t
1723	683	35	3	2423.92	t
1724	1056	26	3	672.35	t
1725	1521	23	3	2071.24	t
1726	1949	14	4	1518.68	t
1727	973	29	1	1925.11	t
1728	778	33	3	1703.43	t
1729	1828	27	4	1643.35	t
1730	40	45	2	2460.84	t
1731	1717	23	2	633.08	t
1732	1767	27	5	2256.70	t
1733	611	37	2	2169.62	t
1734	1415	38	4	1086.15	t
1735	109	46	3	258.64	t
1736	689	25	2	51.25	t
1737	1256	34	2	1949.24	t
1738	803	23	5	2341.12	t
1739	770	12	3	152.94	t
1740	1256	12	2	968.19	t
1741	1088	19	2	1864.12	t
1742	477	32	4	1782.54	t
1743	350	34	5	2116.73	t
1744	1264	47	3	2046.87	t
1745	595	11	4	1507.25	t
1746	1216	36	3	1851.21	t
1747	1191	36	4	1670.12	t
1748	237	3	2	1167.85	t
1749	1224	5	3	131.91	t
1750	1084	35	2	1972.64	t
1751	1334	23	3	420.03	t
1752	468	2	1	286.37	t
1753	197	16	2	1174.92	t
1754	32	10	5	1404.61	t
1755	1061	47	3	1489.70	t
1756	1013	15	2	579.36	t
1757	1445	2	4	1897.34	t
1758	374	5	2	1841.49	t
1759	718	48	2	956.03	t
1760	327	6	3	474.24	t
1761	728	26	5	2276.03	t
1762	1247	33	3	597.61	t
1763	1497	29	4	1842.80	t
1764	581	45	2	1242.86	t
1765	625	13	4	1462.15	t
1766	1730	22	3	1519.62	t
1767	1000	11	4	2253.28	t
1768	10	49	3	131.84	t
1769	950	22	4	589.48	t
1770	1930	12	4	1555.23	t
1771	663	17	2	539.55	t
1772	1460	37	2	1264.87	t
1773	1180	3	1	1024.33	t
1774	163	18	3	1883.14	t
1775	224	13	5	528.53	t
1776	129	29	4	833.13	t
1777	1596	44	5	2029.18	t
1778	1422	19	2	72.11	t
1779	1140	29	4	1678.38	t
1780	1229	6	4	1585.00	t
1781	1599	36	2	1886.71	t
1782	815	2	1	2293.10	t
1783	1388	21	4	2406.15	t
1784	1528	8	4	1973.64	t
1785	1180	25	3	1251.83	t
1786	1617	12	2	357.06	t
1787	369	3	4	1403.58	t
1788	417	21	1	1563.62	t
1789	1095	19	4	842.85	t
1790	1540	29	4	643.59	t
1791	1984	14	5	1480.31	t
1792	1946	12	2	2420.82	t
1793	712	10	3	1365.78	t
1794	1930	6	4	785.14	t
1795	988	44	2	1647.22	t
1796	352	48	2	1640.80	t
1797	1015	47	3	457.45	t
1798	1211	31	4	2025.22	t
1799	1056	17	3	2200.58	t
1800	122	41	3	165.65	t
1801	155	36	3	71.80	t
1802	1004	23	4	1704.50	t
1803	1040	39	3	708.44	t
1804	147	10	3	1521.43	t
1805	1893	46	5	1302.25	t
1806	514	6	4	1837.62	t
1807	1422	47	3	1082.40	t
1808	1871	1	3	2490.33	t
1809	975	27	1	2321.69	t
1810	1310	27	2	416.12	t
1811	1490	13	4	2184.10	t
1812	787	7	3	1933.83	t
1813	736	26	4	271.09	t
1814	100	45	1	1456.62	t
1815	1798	9	4	2027.58	t
1816	1564	43	2	717.78	t
1817	258	6	2	1489.83	t
1818	1403	19	2	469.63	t
1819	1464	12	4	1780.69	t
1820	184	30	3	1756.76	t
1821	466	27	2	714.80	t
1822	1434	49	4	369.45	t
1823	252	28	2	814.08	t
1824	80	39	3	1072.47	t
1825	603	26	1	1036.61	t
1826	1398	44	5	1769.39	t
1827	110	24	4	2490.60	t
1828	765	46	4	502.97	t
1829	526	1	3	2261.49	t
1830	882	19	3	1502.72	t
1831	618	10	1	1931.88	t
1832	199	30	4	2002.45	t
1833	1565	49	2	1501.18	t
1834	1108	17	2	580.76	t
1835	720	37	4	809.01	t
1836	1063	37	4	342.76	t
1837	953	46	3	693.37	t
1838	113	19	3	473.65	t
1839	559	40	4	1130.24	t
1840	1541	10	4	1620.38	t
1841	1038	12	2	1236.66	t
1842	1521	8	5	707.59	t
1843	1128	49	5	1072.73	t
1844	1152	17	3	31.10	t
1845	1647	22	3	566.32	t
1846	277	42	2	706.46	t
1847	1924	26	4	2388.85	t
1848	105	22	2	1066.77	t
1849	1164	1	4	736.59	t
1850	315	16	4	538.57	t
1851	230	41	4	1738.23	t
1852	1336	40	2	2048.07	t
1853	531	14	3	662.31	t
1854	1793	24	3	457.56	t
1855	1246	18	1	532.67	t
1856	1513	31	5	1915.63	t
1857	1276	20	2	2173.23	t
1858	624	29	2	1712.46	t
1859	39	15	3	635.20	t
1860	1235	40	2	624.55	t
1861	1616	43	2	1311.28	t
1862	1494	32	3	2124.89	t
1863	1862	42	1	2231.33	t
1864	387	25	4	1975.54	t
1865	1301	4	5	609.98	t
1866	759	44	4	1490.07	t
1867	642	44	5	2014.68	t
1868	1061	20	1	1964.07	t
1869	343	28	4	1670.14	t
1870	877	43	4	462.65	t
1871	1183	30	3	1086.77	t
1872	1420	16	2	1260.12	t
1873	173	43	3	867.40	t
1874	1854	45	4	192.56	t
1875	832	30	1	2424.79	t
1876	845	37	3	1049.61	t
1877	312	35	1	35.80	t
1878	1453	7	1	1384.56	t
1879	1755	21	5	1278.82	t
1880	79	12	4	754.68	t
1881	580	50	4	1698.42	t
1882	746	39	5	2091.58	t
1883	1066	45	1	1800.07	t
1884	1646	26	2	923.23	t
1885	1852	29	3	875.13	t
1886	808	43	4	2433.02	t
1887	1374	25	3	2407.70	t
1888	1624	49	2	1949.61	t
1889	1606	35	2	1028.41	t
1890	1727	22	3	642.98	t
1891	1744	34	3	1105.17	t
1892	526	17	3	1365.82	t
1893	268	12	5	876.65	t
1894	160	48	2	75.50	t
1895	1386	42	1	1249.80	t
1896	1903	41	5	2180.93	t
1897	1634	23	4	432.54	t
1898	694	15	3	185.17	t
1899	1523	43	2	1235.57	t
1900	1986	22	5	1437.25	t
1901	899	25	3	295.33	t
1902	962	9	3	907.32	t
1903	197	39	3	181.98	t
1904	1637	15	1	439.66	t
1905	348	7	3	2263.57	t
1906	767	29	5	1275.33	t
1907	1766	16	3	1532.03	t
1908	985	31	5	1351.21	t
1909	1280	18	4	2001.18	t
1910	1616	21	5	2238.20	t
1911	147	18	1	1282.76	t
1912	1424	23	3	768.29	t
1913	1643	4	1	253.82	t
1914	1962	31	4	1054.42	t
1915	790	16	3	587.62	t
1916	773	23	3	2217.46	t
1917	480	45	5	972.61	t
1918	1974	12	2	491.75	t
1919	364	38	3	1834.78	t
1920	1123	23	4	950.24	t
1921	722	25	2	2244.62	t
1922	1303	9	2	573.81	t
1923	1716	6	4	1962.96	t
1924	1556	7	2	1099.58	t
1925	620	45	4	941.89	t
1926	1062	46	4	900.55	t
1927	1758	42	3	2229.05	t
1928	940	13	2	1616.73	t
1929	1793	4	2	1101.29	t
1930	30	38	1	1888.48	t
1931	556	16	3	267.58	t
1932	1164	21	1	1440.50	t
1933	1153	39	2	2127.14	t
1934	12	48	3	121.03	t
1935	1391	7	4	1622.22	t
1936	1838	33	4	87.64	t
1937	1275	34	5	852.32	t
1938	136	11	5	812.05	t
1939	77	15	2	2049.88	t
1940	1778	42	5	768.60	t
1941	223	4	4	2300.01	t
1942	1165	16	1	1882.49	t
1943	1507	4	4	2143.78	t
1944	620	49	2	520.12	t
1945	321	44	2	1021.29	t
1946	379	25	2	1248.68	t
1947	657	21	5	1405.27	t
1948	1499	46	4	419.29	t
1949	141	15	2	805.74	t
1950	1271	15	1	1685.50	t
1951	1255	4	3	570.17	t
1952	268	22	2	833.82	t
1953	1631	24	2	1758.30	t
1954	1014	21	4	1603.77	t
1955	279	22	4	2302.42	t
1956	1851	32	1	928.33	t
1957	1704	6	5	2435.38	t
1958	1236	20	2	265.21	t
1959	1916	18	3	499.34	t
1960	1025	48	3	769.62	t
1961	451	6	2	1435.86	t
1962	1830	17	2	1907.99	t
1963	1583	35	3	114.19	t
1964	1475	7	1	774.30	t
1965	1345	43	1	2293.58	t
1966	1832	49	3	1441.77	t
1967	1415	39	3	1142.16	t
1968	1704	29	2	1360.58	t
1969	677	41	2	376.77	t
1970	1833	3	2	2101.35	t
1971	114	31	4	387.81	t
1972	1314	27	3	1665.31	t
1973	1904	29	3	1638.81	t
1974	857	29	1	107.93	t
1975	1775	38	1	1336.57	t
1976	1864	48	5	1776.05	t
1977	1329	22	2	65.11	t
1978	506	4	3	475.61	t
1979	470	10	3	1893.23	t
1980	19	32	3	914.33	t
1981	78	20	1	1661.60	t
1982	1697	21	3	1081.37	t
1983	1963	25	2	1143.35	t
1984	1645	35	4	272.57	t
1985	980	40	2	1808.64	t
1986	608	4	4	1297.84	t
1987	1518	44	3	2068.42	t
1988	1352	45	1	269.82	t
1989	423	4	2	465.23	t
1990	212	37	3	1329.52	t
1991	805	30	4	1133.55	t
1992	725	40	4	2334.85	t
1993	1358	2	1	184.97	t
1994	206	46	3	2080.36	t
1995	490	40	3	470.43	t
1996	1141	37	5	2229.44	t
1997	819	28	4	2135.38	t
1998	1588	12	4	2051.37	t
1999	140	19	3	2050.70	t
2000	765	36	3	2449.56	t
2001	88	8	3	1337.11	t
2002	1013	42	2	434.84	t
2003	1422	23	1	926.79	t
2004	713	27	4	2395.27	t
2005	303	50	2	187.38	t
2006	1130	19	4	87.92	t
2007	337	40	5	1814.49	t
2008	959	29	4	1595.21	t
2009	1418	20	3	199.44	t
2010	1030	19	4	444.09	t
2011	36	15	2	1928.22	t
2012	1353	45	2	2376.00	t
2013	326	5	2	92.84	t
2014	1659	33	4	371.46	t
2015	29	24	4	208.90	t
2016	145	42	4	1141.04	t
2017	749	27	1	1935.70	t
2018	705	3	4	268.25	t
2019	939	27	3	1412.25	t
2020	757	5	2	2291.30	t
2021	1818	20	4	1522.14	t
2022	1677	22	4	466.12	t
2023	1478	26	1	60.22	t
2024	1532	12	3	1383.07	t
2025	1758	27	4	1431.14	t
2026	692	13	4	381.64	t
2027	660	47	2	1418.49	t
2028	844	3	4	409.96	t
2029	1030	20	4	1473.00	t
2030	1807	9	5	955.53	t
2031	1350	19	2	766.11	t
2032	1007	40	3	908.27	t
2033	352	28	1	2472.41	t
2034	859	26	3	942.27	t
2035	1714	9	4	2480.48	t
2036	1109	12	2	1022.31	t
2037	169	43	3	2177.71	t
2038	83	13	5	1470.67	t
2039	1271	44	2	328.16	t
2040	293	15	2	385.31	t
2041	210	32	4	1813.35	t
2042	392	6	4	1217.25	t
2043	1316	43	4	1014.54	t
2044	1229	48	2	1897.28	t
2045	1457	23	3	112.26	t
2046	3	2	2	1150.45	t
2047	964	27	1	1542.91	t
2048	160	27	2	2055.16	t
2049	680	15	1	1921.24	t
2050	396	12	2	1631.83	t
2051	709	12	4	2046.47	t
2052	1979	44	5	1788.96	t
2053	1368	30	4	983.83	t
2054	1610	34	3	306.51	t
2055	1022	42	4	1906.36	t
2056	1023	1	3	1098.53	t
2057	936	41	3	1640.24	t
2058	547	34	2	454.14	t
2059	244	20	4	853.35	t
2060	1348	30	1	1890.12	t
2061	919	43	1	720.44	t
2062	815	16	2	630.89	t
2063	321	41	5	845.55	t
2064	1759	35	5	1399.38	t
2065	1218	46	4	1314.37	t
2066	904	15	5	1606.48	t
2067	1572	37	4	944.70	t
2068	1419	34	3	1648.04	t
2069	1856	20	4	1611.22	t
2070	483	33	1	2042.72	t
2071	1538	40	3	129.49	t
2072	1648	11	4	268.71	t
2073	1237	4	2	1374.47	t
2074	144	44	4	559.77	t
2075	488	42	3	655.25	t
2076	965	49	4	1943.69	t
2077	1924	48	3	1378.27	t
2078	754	10	3	408.95	t
2079	1868	45	1	1837.19	t
2080	647	5	2	196.50	t
2081	1431	34	2	380.18	t
2082	1042	44	1	1611.61	t
2083	1643	25	2	2381.81	t
2084	897	11	2	2050.62	t
2085	984	35	3	1283.08	t
2086	1772	43	5	287.84	t
2087	309	32	3	867.93	t
2088	1448	28	3	2457.18	t
2089	155	11	4	1735.75	t
2090	594	46	5	2264.74	t
2091	1377	50	4	2012.86	t
2092	1852	45	4	1208.79	t
2093	466	29	2	1631.40	t
2094	1312	34	1	2227.00	t
2095	225	37	3	1271.53	t
2096	882	35	3	582.60	t
2097	1404	32	3	453.20	t
2098	1503	12	2	95.44	t
2099	1093	48	5	1975.58	t
2100	143	46	2	32.71	t
2101	1989	9	3	499.72	t
2102	1955	36	4	721.60	t
2103	988	8	2	1931.40	t
2104	1878	44	5	1916.39	t
2105	1489	35	2	2227.19	t
2106	1124	22	5	1385.02	t
2107	1041	43	2	784.79	t
2108	603	38	2	1192.59	t
2109	1139	33	4	674.88	t
2110	268	48	3	25.85	t
2111	1685	8	3	1224.49	t
2112	1201	3	4	507.80	t
2113	1644	48	4	593.07	t
2114	518	6	3	958.57	t
2115	109	14	1	1739.13	t
2116	1608	31	2	2463.84	t
2117	698	49	2	684.43	t
2118	1559	10	4	2059.46	t
2119	1633	45	1	496.19	t
2120	1855	26	3	1706.42	t
2121	1493	27	3	344.68	t
2122	1248	6	4	1109.24	t
2123	1106	38	2	2220.16	t
2124	1158	3	5	285.62	t
2125	1538	10	5	1485.24	t
2126	924	21	2	2116.05	t
2127	548	22	2	2364.96	t
2128	1061	47	5	2325.23	t
2129	242	18	4	906.07	t
2130	1900	24	1	2157.78	t
2131	1187	28	2	1725.56	t
2132	221	36	3	640.28	t
2133	1013	19	2	461.10	t
2134	295	46	4	637.99	t
2135	1716	21	2	1637.46	t
2136	1288	30	3	677.66	t
2137	70	39	3	22.67	t
2138	261	17	1	1574.65	t
2139	725	26	1	486.49	t
2140	1169	33	4	407.97	t
2141	247	28	2	553.19	t
2142	1251	26	2	2269.55	t
2143	1933	7	1	332.05	t
2144	668	28	5	251.40	t
2145	1191	18	2	444.19	t
2146	1765	14	1	2411.03	t
2147	1309	47	5	2181.14	t
2148	1308	4	4	2135.45	t
2149	25	4	2	1236.11	t
2150	290	6	2	845.67	t
2151	936	46	3	1169.64	t
2152	770	15	1	1329.01	t
2153	532	19	5	1636.98	t
2154	374	18	3	1728.88	t
2155	761	24	1	1291.64	t
2156	1904	5	3	222.46	t
2157	524	23	3	935.48	t
2158	769	23	4	2136.25	t
2159	1025	3	3	2213.54	t
2160	748	4	3	907.62	t
2161	1521	2	4	354.28	t
2162	1082	31	4	859.04	t
2163	1649	49	4	29.04	t
2164	650	41	4	735.84	t
2165	73	11	3	256.40	t
2166	1489	3	4	2232.53	t
2167	332	46	5	1867.77	t
2168	1236	35	3	1365.98	t
2169	1202	7	4	1717.35	t
2170	723	44	4	1266.70	t
2171	426	21	1	373.47	t
2172	1671	2	3	2417.39	t
2173	905	40	2	660.86	t
2174	468	19	3	1342.12	t
2175	1666	4	3	1659.05	t
2176	277	27	3	902.92	t
2177	100	13	1	1499.87	t
2178	1014	24	2	586.47	t
2179	1283	10	5	202.60	t
2180	1148	20	2	751.37	t
2181	968	47	2	216.54	t
2182	1063	27	3	474.71	t
2183	954	22	3	491.41	t
2184	1731	12	3	384.70	t
2185	465	35	3	1237.79	t
2186	703	42	4	1325.61	t
2187	15	8	2	1283.93	t
2188	756	33	4	1354.07	t
2189	1298	23	3	1503.31	t
2190	1515	31	5	1368.28	t
2191	1533	22	5	774.55	t
2192	354	49	5	783.96	t
2193	1300	24	1	1982.74	t
2194	930	42	3	2143.72	t
2195	116	19	5	737.88	t
2196	230	6	2	720.90	t
2197	260	18	4	691.64	t
2198	451	20	2	601.72	t
2199	210	6	5	1459.62	t
2200	440	24	2	756.45	t
2201	1854	38	1	164.87	t
2202	1771	21	3	677.63	t
2203	1115	14	1	173.93	t
2204	275	9	5	559.57	t
2205	492	44	4	950.51	t
2206	1281	40	1	2161.20	t
2207	972	39	3	2201.35	t
2208	1306	6	4	1147.90	t
2209	323	21	5	1614.90	t
2210	301	10	4	342.51	t
2211	340	34	3	1925.48	t
2212	378	5	2	160.57	t
2213	202	5	3	1764.06	t
2214	1133	34	4	794.16	t
2215	832	33	1	755.15	t
2216	1288	5	2	532.10	t
2217	277	43	2	718.23	t
2218	1650	45	5	286.80	t
2219	1544	27	5	887.19	t
2220	1999	28	4	2256.56	t
2221	330	19	1	57.25	t
2222	614	17	2	1531.70	t
2223	430	27	2	2449.85	t
2224	703	18	3	29.61	t
2225	211	22	2	1818.71	t
2226	821	22	2	714.80	t
2227	1961	47	2	1064.74	t
2228	480	13	3	412.41	t
2229	680	46	2	1518.68	t
2230	1094	40	2	475.15	t
2231	1401	12	3	2114.51	t
2232	1449	8	4	1664.28	t
2233	195	48	3	1746.48	t
2234	862	45	4	2224.95	t
2235	1255	25	2	2441.16	t
2236	85	35	5	2055.67	t
2237	1965	3	2	1890.98	t
2238	124	48	2	2293.12	t
2239	1357	39	4	425.65	t
2240	322	27	2	1852.51	t
2241	1357	26	5	1476.57	t
2242	256	27	1	1903.97	t
2243	1111	35	3	236.91	t
2244	125	14	4	1874.12	t
2245	506	34	4	1525.44	t
2246	1442	47	4	1951.09	t
2247	1987	10	3	369.05	t
2248	1129	25	4	789.68	t
2249	290	46	5	764.93	t
2250	366	2	2	47.44	t
2251	1497	33	2	527.44	t
2252	249	27	3	109.65	t
2253	975	21	5	2295.13	t
2254	1243	12	4	1507.08	t
2255	1633	41	3	567.21	t
2256	804	10	3	1111.60	t
2257	117	12	5	1301.69	t
2258	87	16	4	117.78	t
2259	275	36	1	1731.45	t
2260	1500	35	2	1219.64	t
2261	1286	3	4	2400.30	t
2262	104	12	4	1862.84	t
2263	1126	26	2	280.26	t
2264	763	33	4	1574.33	t
2265	1425	4	4	470.65	t
2266	641	16	4	2448.88	t
2267	158	38	4	1003.52	t
2268	840	32	2	1002.89	t
2269	311	35	3	356.61	t
2270	966	29	3	1715.20	t
2271	100	15	5	1487.78	t
2272	952	18	3	716.94	t
2273	462	10	4	508.17	t
2274	609	40	3	796.62	t
2275	1647	47	2	713.46	t
2276	833	34	1	1750.48	t
2277	1725	23	4	652.52	t
2278	1991	38	3	1911.91	t
2279	516	49	3	1718.66	t
2280	654	24	2	2261.39	t
2281	987	7	1	353.24	t
2282	398	11	3	640.17	t
2283	1193	29	2	1250.06	t
2284	634	37	2	655.84	t
2285	1316	34	4	1057.05	t
2286	1988	42	3	1368.62	t
2287	489	43	1	1192.00	t
2288	986	38	3	898.02	t
2289	1303	9	1	501.76	t
2290	1669	40	5	1822.02	t
2291	775	12	2	1554.90	t
2292	1223	44	2	1436.66	t
2293	613	47	4	1054.17	t
2294	1486	5	5	1403.23	t
2295	1839	22	3	2230.42	t
2296	871	12	2	1283.60	t
2297	1585	48	2	163.52	t
2298	1328	26	3	1732.42	t
2299	1339	45	5	2430.00	t
2300	111	21	5	2184.58	t
2301	626	36	3	382.71	t
2302	722	5	4	77.01	t
2303	1923	18	4	2414.58	t
2304	1113	23	3	2340.13	t
2305	591	13	4	995.59	t
2306	1665	42	1	185.18	t
2307	175	44	1	1282.72	t
2308	18	7	5	734.34	t
2309	731	25	2	1332.70	t
2310	47	34	5	780.60	t
2311	1809	11	1	1559.70	t
2312	1093	22	4	2095.63	t
2313	1479	30	2	2293.86	t
2314	439	27	3	917.13	t
2315	227	21	3	1360.52	t
2316	1698	36	4	1659.79	t
2317	206	22	3	370.44	t
2318	791	42	1	977.24	t
2319	770	11	5	1377.91	t
2320	384	37	4	1487.12	t
2321	504	39	4	670.69	t
2322	267	40	1	427.44	t
2323	688	30	4	143.18	t
2324	694	4	2	272.13	t
2325	1760	4	1	942.18	t
2326	905	7	4	888.14	t
2327	1243	31	2	1541.88	t
2328	350	10	3	1350.71	t
2329	1312	13	3	1782.40	t
2330	1630	16	2	2238.85	t
2331	214	4	5	910.89	t
2332	1726	23	3	249.52	t
2333	395	5	3	1752.10	t
2334	1332	14	5	1549.04	t
2335	97	20	4	264.46	t
2336	1769	40	3	70.08	t
2337	1235	49	4	1329.58	t
2338	1830	33	2	2246.31	t
2339	265	4	3	1382.86	t
2340	1276	5	2	2408.64	t
2341	1316	12	4	1341.13	t
2342	813	7	3	2209.21	t
2343	1943	47	4	2384.51	t
2344	1226	48	4	2367.70	t
2345	1073	19	4	1282.55	t
2346	661	12	2	372.03	t
2347	43	4	3	205.62	t
2348	334	5	2	1238.06	t
2349	999	42	3	557.27	t
2350	245	30	1	2124.94	t
2351	1421	18	1	1878.39	t
2352	1371	30	2	1902.85	t
2353	607	46	3	1376.02	t
2354	338	6	1	423.65	t
2355	1507	42	5	512.19	t
2356	894	48	2	835.17	t
2357	1022	48	4	2411.61	t
2358	27	24	2	1516.93	t
2359	95	24	2	1201.64	t
2360	1984	14	4	2477.74	t
2361	100	24	1	1807.55	t
2362	1529	16	2	507.99	t
2363	1185	28	2	1202.62	t
2364	648	11	3	1878.52	t
2365	1804	27	5	1223.07	t
2366	876	10	5	1785.92	t
2367	370	33	3	787.81	t
2368	157	46	2	1483.15	t
2369	630	3	3	815.76	t
2370	1329	16	5	218.81	t
2371	1129	14	5	2010.97	t
2372	1242	26	3	1251.77	t
2373	984	21	3	677.01	t
2374	2	4	3	1349.09	t
2375	1199	16	2	1130.42	t
2376	960	22	4	1720.16	t
2377	1232	3	3	729.65	t
2378	1957	50	5	82.69	t
2379	507	21	2	2368.41	t
2380	1214	37	3	528.33	t
2381	729	40	1	1679.94	t
2382	1866	22	1	969.70	t
2383	1865	15	4	1501.35	t
2384	1090	30	4	759.48	t
2385	720	39	3	1416.55	t
2386	1487	31	2	1846.21	t
2387	1795	46	2	2187.75	t
2388	230	46	4	1774.41	t
2389	1814	9	5	653.52	t
2390	1897	49	2	1561.86	t
2391	1245	35	5	1411.53	t
2392	1287	20	5	2201.50	t
2393	597	28	2	2444.41	t
2394	569	4	1	528.21	t
2395	211	37	1	1159.94	t
2396	1693	16	3	554.59	t
2397	1778	40	1	386.78	t
2398	363	34	2	1861.94	t
2399	515	42	1	1568.64	t
2400	733	7	4	549.94	t
2401	482	14	2	2345.90	t
2402	1851	6	2	232.40	t
2403	122	50	2	2284.49	t
2404	1458	38	4	2110.41	t
2405	943	37	3	2345.13	t
2406	88	19	3	408.61	t
2407	1285	10	3	2028.45	t
2408	1926	14	1	195.35	t
2409	71	28	2	2198.18	t
2410	390	12	4	1633.99	t
2411	1267	46	2	2084.68	t
2412	1890	21	3	568.92	t
2413	1710	3	2	1162.07	t
2414	452	35	1	1869.30	t
2415	652	10	3	2070.75	t
2416	669	18	4	2149.29	t
2417	1200	41	5	2163.93	t
2418	259	49	3	607.40	t
2419	713	31	3	809.58	t
2420	1810	42	1	744.04	t
2421	1448	31	3	940.66	t
2422	1122	9	5	1124.51	t
2423	458	15	1	49.91	t
2424	358	34	5	1002.29	t
2425	1415	26	4	2071.91	t
2426	838	42	2	282.96	t
2427	1417	12	5	2203.46	t
2428	1046	38	2	2422.35	t
2429	1143	2	4	492.86	t
2430	98	40	4	1158.73	t
2431	1813	29	2	571.86	t
2432	482	29	2	1756.99	t
2433	97	40	3	1171.36	t
2434	276	28	1	997.89	t
2435	534	14	4	2178.17	t
2436	1905	37	3	1496.68	t
2437	1622	36	3	2078.69	t
2438	808	26	4	1474.76	t
2439	1566	15	5	1084.97	t
2440	1023	6	2	173.36	t
2441	898	24	2	1351.17	t
2442	483	13	3	2428.18	t
2443	1297	19	2	2168.46	t
2444	1782	23	5	690.81	t
2445	1122	34	3	2199.78	t
2446	903	19	1	71.45	t
2447	1512	46	5	1789.43	t
2448	1167	29	4	1007.83	t
2449	1413	9	3	1705.04	t
2450	19	23	2	1113.41	t
2451	41	48	1	673.51	t
2452	1167	17	5	2034.93	t
2453	1882	22	3	2470.69	t
2454	775	10	3	52.73	t
2455	946	41	1	389.79	t
2456	639	44	3	2272.10	t
2457	1924	40	2	1270.75	t
2458	1236	19	1	1668.07	t
2459	1329	25	4	1757.13	t
2460	1086	25	3	362.80	t
2461	956	45	4	1604.24	t
2462	1817	21	2	1649.84	t
2463	1483	28	5	2023.48	t
2464	1341	46	3	2395.36	t
2465	1565	29	2	1068.87	t
2466	1089	19	3	2201.67	t
2467	669	11	3	2224.12	t
2468	775	5	4	2312.10	t
2469	712	9	5	592.33	t
2470	1901	17	2	1500.78	t
2471	1646	37	3	1339.06	t
2472	1687	2	5	794.56	t
2473	539	32	5	1242.72	t
2474	232	8	3	1524.19	t
2475	185	44	2	2131.93	t
2476	904	30	5	518.90	t
2477	889	7	1	2207.19	t
2478	177	40	4	578.17	t
2479	1707	36	3	1025.97	t
2480	4	4	5	2191.76	t
2481	1375	6	4	1996.51	t
2482	1413	7	3	2444.34	t
2483	1851	45	3	1372.56	t
2484	728	37	1	1125.50	t
2485	433	17	3	540.19	t
2486	66	13	4	1363.50	t
2487	342	45	1	455.00	t
2488	97	24	5	1881.69	t
2489	1048	45	3	380.73	t
2490	1989	40	3	928.73	t
2491	803	23	4	1932.71	t
2492	330	13	2	1768.42	t
2493	567	19	2	1747.95	t
2494	1120	13	3	1273.18	t
2495	1863	28	2	138.49	t
2496	1925	10	4	109.10	t
2497	1069	24	4	2450.36	t
2498	490	26	3	2151.29	t
2499	1427	26	1	2395.77	t
2500	47	42	3	728.54	t
2501	33	37	4	2337.88	t
2502	962	12	2	189.21	t
2503	82	20	2	1343.33	t
2504	436	18	3	2237.79	t
2505	69	17	4	258.99	t
2506	551	7	3	2032.80	t
2507	1987	48	4	582.70	t
2508	627	38	4	370.93	t
2509	796	18	1	1690.28	t
2510	589	39	2	1187.69	t
2511	1548	3	4	2496.83	t
2512	235	4	4	2238.62	t
2513	1773	43	3	1384.59	t
2514	637	27	4	2275.19	t
2515	487	34	4	1821.91	t
2516	262	15	2	1792.27	t
2517	1116	34	3	867.62	t
2518	1753	21	3	207.23	t
2519	311	20	1	127.83	t
2520	635	8	2	2118.47	t
2521	311	23	4	1683.77	t
2522	521	44	4	576.53	t
2523	729	1	5	1417.44	t
2524	1439	29	3	1348.37	t
2525	632	27	3	301.21	t
2526	1903	6	4	1542.56	t
2527	974	40	3	1161.48	t
2528	1733	17	3	1472.20	t
2529	56	21	4	23.50	t
2530	1925	12	4	2015.67	t
2531	287	42	2	1201.50	t
2532	289	4	2	469.93	t
2533	628	46	3	899.28	t
2534	1098	28	3	112.62	t
2535	634	42	2	1723.35	t
2536	1982	28	1	1477.14	t
2537	405	31	3	665.68	t
2538	1664	1	4	1078.32	t
2539	831	46	5	1743.06	t
2540	1688	31	2	628.71	t
2541	700	29	3	1095.14	t
2542	571	7	2	1630.34	t
2543	1870	43	4	1396.51	t
2544	294	7	3	1903.32	t
2545	1089	31	2	2468.59	t
2546	922	29	2	396.74	t
2547	903	13	3	1602.85	t
2548	89	19	4	2370.87	t
2549	1298	9	2	2464.45	t
2550	1770	9	2	1857.38	t
2551	980	22	3	2044.51	t
2552	718	48	2	80.15	t
2553	1052	36	3	1101.68	t
2554	552	9	4	1545.91	t
2555	1050	5	4	1893.14	t
2556	1198	7	4	1502.50	t
2557	149	6	4	1577.65	t
2558	1380	48	2	2010.15	t
2559	1085	34	5	699.32	t
2560	472	28	3	2364.69	t
2561	1113	44	4	1494.39	t
2562	815	4	2	296.69	t
2563	298	6	3	2416.50	t
2564	1080	10	4	2005.93	t
2565	1238	25	4	2323.78	t
2566	1598	19	3	2060.42	t
2567	767	49	2	1773.10	t
2568	890	17	4	494.37	t
2569	626	6	5	207.82	t
2570	908	26	4	2348.24	t
2571	1615	48	3	1883.68	t
2572	1198	33	4	1505.97	t
2573	1369	9	4	61.95	t
2574	1936	11	3	2296.10	t
2575	1579	48	4	308.24	t
2576	1876	49	2	1569.77	t
2577	788	27	2	99.36	t
2578	1900	31	4	1835.57	t
2579	1804	12	3	609.85	t
2580	1160	38	4	612.76	t
2581	1942	7	1	668.18	t
2582	157	12	4	1782.30	t
2583	1679	22	2	228.43	t
2584	413	49	3	410.28	t
2585	813	48	4	569.58	t
2586	469	30	2	1813.51	t
2587	420	5	4	549.91	t
2588	985	33	1	450.11	t
2589	340	9	2	1371.95	t
2590	1486	36	3	1225.43	t
2591	1008	9	1	1164.74	t
2592	1855	21	3	1671.29	t
2593	1161	36	1	728.46	t
2594	96	23	3	1980.80	t
2595	1105	3	4	1817.87	t
2596	71	27	5	1874.64	t
2597	881	6	4	1416.96	t
2598	528	4	1	1394.38	t
2599	285	39	2	1265.92	t
2600	1798	9	4	333.11	t
2601	1056	6	2	2075.17	t
2602	1694	25	1	870.66	t
2603	584	17	2	1649.95	t
2604	1682	5	5	196.63	t
2605	1466	15	4	586.06	t
2606	87	43	2	246.40	t
2607	548	3	3	1483.34	t
2608	765	10	3	266.29	t
2609	17	32	4	1610.38	t
2610	977	6	3	314.47	t
2611	254	40	5	277.83	t
2612	1638	37	2	56.42	t
2613	1086	30	4	1555.42	t
2614	687	41	5	2084.10	t
2615	283	5	4	1782.01	t
2616	1266	4	1	385.60	t
2617	140	48	1	435.16	t
2618	1495	4	3	776.01	t
2619	843	2	4	1244.61	t
2620	892	34	4	2083.94	t
2621	457	35	4	1153.61	t
2622	971	30	4	438.26	t
2623	141	40	5	44.73	t
2624	1517	46	2	1256.89	t
2625	68	24	4	1720.70	t
2626	1142	26	4	1790.68	t
2627	849	13	1	1966.10	t
2628	1761	11	3	2308.30	t
2629	438	18	2	545.76	t
2630	581	21	4	1427.89	t
2631	1281	40	3	1697.38	t
2632	1567	46	2	2075.54	t
2633	1644	32	2	769.24	t
2634	612	37	3	311.68	t
2635	1991	17	4	1098.11	t
2636	1632	16	4	279.16	t
2637	564	16	1	1513.46	t
2638	827	23	2	214.29	t
2639	1501	46	1	2169.87	t
2640	34	23	2	1054.79	t
2641	1219	12	3	929.09	t
2642	227	30	3	1084.47	t
2643	403	38	4	527.79	t
2644	134	43	2	1783.26	t
2645	1341	23	4	148.78	t
2646	241	35	1	2283.23	t
2647	1735	23	2	778.38	t
2648	1696	49	4	2241.42	t
2649	1507	49	4	1225.05	t
2650	886	4	2	340.35	t
2651	1453	12	5	307.77	t
2652	68	45	3	1849.65	t
2653	660	22	2	577.98	t
2654	191	48	2	26.10	t
2655	148	9	5	797.67	t
2656	613	19	2	668.89	t
2657	1368	12	3	1390.32	t
2658	1505	30	3	2177.72	t
2659	1173	15	5	1840.48	t
2660	1673	33	4	657.90	t
2661	816	23	3	1466.00	t
2662	1505	3	3	1639.02	t
2663	550	25	3	1274.43	t
2664	145	6	3	51.63	t
2665	1816	4	2	959.12	t
2666	1603	25	2	799.04	t
2667	1335	33	1	2364.64	t
2668	275	25	2	686.30	t
2669	1428	11	4	784.93	t
2670	1331	6	4	2278.90	t
2671	918	39	4	1312.44	t
2672	438	10	1	601.40	t
2673	560	41	4	1810.89	t
2674	794	2	5	1086.24	t
2675	1363	7	2	1312.47	t
2676	1435	26	4	703.87	t
2677	1543	1	3	433.32	t
2678	940	8	2	1701.13	t
2679	1571	45	2	2209.76	t
2680	28	10	5	401.59	t
2681	1877	3	3	2122.75	t
2682	1258	31	4	2094.23	t
2683	504	5	2	2487.92	t
2684	460	32	1	208.07	t
2685	1862	49	3	286.81	t
2686	1357	40	2	2377.38	t
2687	794	25	4	823.58	t
2688	1776	26	2	1143.90	t
2689	902	12	3	1723.33	t
2690	1437	19	1	429.31	t
2691	5	49	1	1191.35	t
2692	804	37	5	703.92	t
2693	632	4	3	465.85	t
2694	1419	5	3	1390.56	t
2695	1996	10	1	2183.35	t
2696	1511	34	3	1661.76	t
2697	213	48	4	416.68	t
2698	835	18	4	1087.28	t
2699	1326	49	3	2458.71	t
2700	1052	29	2	2296.78	t
2701	449	10	1	90.46	t
2702	824	24	4	1715.35	t
2703	378	3	4	1374.10	t
2704	1762	5	2	1144.62	t
2705	400	22	2	79.16	t
2706	857	14	5	965.60	t
2707	104	43	4	96.41	t
2708	1922	20	5	1339.38	t
2709	1897	42	4	1111.37	t
2710	1484	17	4	890.93	t
2711	986	16	3	2147.99	t
2712	1183	4	3	630.10	t
2713	830	16	2	687.78	t
2714	431	21	5	1106.25	t
2715	1002	49	4	1602.39	t
2716	523	19	3	163.38	t
2717	507	14	4	1580.10	t
2718	136	13	5	938.69	t
2719	1163	39	1	440.97	t
2720	122	45	4	1223.48	t
2721	689	13	4	1303.78	t
2722	346	40	4	2461.28	t
2723	468	38	4	372.58	t
2724	1440	42	2	164.09	t
2725	1633	20	1	1949.47	t
2726	1846	12	3	147.38	t
2727	1360	24	3	2034.98	t
2728	1379	20	4	471.35	t
2729	1293	18	3	2008.19	t
2730	1965	46	2	920.93	t
2731	1528	47	1	612.23	t
2732	1445	41	1	905.52	t
2733	475	35	1	1766.86	t
2734	946	39	2	1795.49	t
2735	662	41	4	2415.98	t
2736	1308	13	4	813.69	t
2737	1368	46	5	174.79	t
2738	787	38	2	770.10	t
2739	1181	6	4	1204.03	t
2740	759	43	2	2382.07	t
2741	974	8	2	2290.29	t
2742	43	5	4	1137.32	t
2743	821	11	2	1769.13	t
2744	747	30	2	2139.76	t
2745	209	8	2	727.99	t
2746	1056	45	3	2137.44	t
2747	507	38	4	1739.03	t
2748	699	47	5	2414.74	t
2749	858	36	3	405.51	t
2750	477	42	2	716.33	t
2751	1373	35	5	956.85	t
2752	101	25	2	1784.03	t
2753	1512	14	4	609.08	t
2754	471	30	4	412.88	t
2755	613	28	3	2091.99	t
2756	993	3	3	517.34	t
2757	687	5	2	2307.77	t
2758	522	7	4	1633.46	t
2759	309	4	3	2217.96	t
2760	392	14	5	81.72	t
2761	436	16	3	859.80	t
2762	19	44	3	646.16	t
2763	789	40	2	826.06	t
2764	1623	2	4	1005.71	t
2765	619	38	4	2367.80	t
2766	1357	14	3	106.99	t
2767	733	45	4	1633.20	t
2768	1259	34	4	2249.23	t
2769	1903	26	4	2071.82	t
2770	1327	8	3	702.06	t
2771	221	22	2	2489.95	t
2772	1318	18	3	2392.38	t
2773	1835	15	1	1133.96	t
2774	853	10	1	2112.03	t
2775	528	20	3	589.21	t
2776	141	19	5	2185.60	t
2777	1816	41	2	1778.52	t
2778	1297	10	5	1789.43	t
2779	656	19	2	1680.69	t
2780	1359	17	2	1454.82	t
2781	1720	15	4	365.06	t
2782	527	31	5	144.98	t
2783	1267	33	4	2029.08	t
2784	1469	47	2	2023.58	t
2785	641	30	3	2091.40	t
2786	245	12	2	1028.41	t
2787	1794	35	3	578.19	t
2788	1577	42	3	2299.86	t
2789	1459	4	3	2054.26	t
2790	1750	23	3	2254.05	t
2791	1827	13	4	862.75	t
2792	806	18	4	2477.79	t
2793	1632	3	2	562.26	t
2794	554	4	4	1408.20	t
2795	1975	14	3	897.53	t
2796	670	24	3	566.77	t
2797	878	9	1	2255.28	t
2798	966	21	2	2309.04	t
2799	1708	3	1	417.65	t
2800	527	16	2	997.45	t
2801	1494	50	4	1584.75	t
2802	1107	1	4	530.07	t
2803	1180	30	3	1713.09	t
2804	1422	31	3	2295.13	t
2805	1005	49	2	2008.73	t
2806	465	21	2	400.89	t
2807	1226	38	4	1428.81	t
2808	1256	48	1	1807.18	t
2809	1466	10	4	193.07	t
2810	485	1	3	1948.70	t
2811	1440	3	3	526.74	t
2812	565	1	4	1282.13	t
2813	1389	30	2	1243.24	t
2814	937	33	2	767.30	t
2815	1802	27	4	339.26	t
2816	1639	5	2	1791.87	t
2817	414	34	4	1361.77	t
2818	172	49	3	128.41	t
2819	565	31	3	1303.75	t
2820	493	15	4	1066.16	t
2821	1008	27	5	919.44	t
2822	909	40	4	1410.15	t
2823	630	48	4	2217.53	t
2824	634	42	2	1418.70	t
2825	464	7	3	2366.86	t
2826	607	28	5	475.81	t
2827	1931	31	2	1214.50	t
2828	587	35	3	58.28	t
2829	645	2	2	1007.93	t
2830	1539	21	2	276.82	t
2831	443	7	3	574.30	t
2832	1801	1	5	685.89	t
2833	1016	12	5	2112.55	t
2834	533	38	3	167.29	t
2835	43	20	4	1645.71	t
2836	966	28	3	1900.38	t
2837	1600	41	3	1735.97	t
2838	1780	11	2	692.51	t
2839	1605	6	3	865.60	t
2840	364	33	2	1397.34	t
2841	1931	29	2	2016.35	t
2842	1774	33	4	2433.26	t
2843	1860	11	2	61.69	t
2844	1396	49	4	2413.64	t
2845	1504	16	3	1101.62	t
2846	401	1	4	66.80	t
2847	820	49	5	1322.87	t
2848	1798	40	2	2225.54	t
2849	567	37	5	1346.18	t
2850	1289	40	5	1322.22	t
2851	1559	2	4	758.11	t
2852	622	20	4	822.09	t
2853	737	8	5	21.64	t
2854	375	32	5	2450.85	t
2855	380	7	2	953.00	t
2856	482	13	3	1108.40	t
2857	506	29	2	1598.47	t
2858	603	9	3	1577.95	t
2859	397	38	3	1263.14	t
2860	490	16	2	1943.44	t
2861	367	19	1	1328.52	t
2862	129	8	3	1292.32	t
2863	680	14	1	1591.60	t
2864	1432	14	1	902.15	t
2865	169	41	5	1864.30	t
2866	1712	18	3	116.97	t
2867	1405	24	1	933.50	t
2868	89	14	2	99.35	t
2869	361	44	3	1024.49	t
2870	1909	33	2	553.48	t
2871	411	26	4	1647.54	t
2872	1411	50	5	2107.30	t
2873	1592	36	1	967.43	t
2874	1639	22	2	1469.06	t
2875	701	14	5	1553.32	t
2876	1353	44	3	1498.73	t
2877	213	38	1	1550.55	t
2878	365	15	4	1637.97	t
2879	162	31	5	644.24	t
2880	460	38	4	1798.43	t
2881	1088	34	3	691.23	t
2882	707	41	3	972.69	t
2883	1498	23	3	387.07	t
2884	578	45	3	1921.69	t
2885	1720	3	1	99.66	t
2886	1519	26	2	2037.99	t
2887	1406	16	3	142.20	t
2888	1752	38	2	2281.09	t
2889	1279	46	2	817.35	t
2890	431	35	5	1671.80	t
2891	1640	38	1	1045.93	t
2892	329	18	4	1610.69	t
2893	1366	3	4	2333.41	t
2894	174	46	5	518.24	t
2895	1179	9	4	137.25	t
2896	731	16	3	1910.91	t
2897	1981	12	1	868.33	t
2898	1126	36	4	2467.09	t
2899	710	18	4	986.81	t
2900	267	48	4	2220.33	t
2901	1903	46	4	1609.48	t
2902	134	8	1	700.76	t
2903	43	31	4	641.57	t
2904	1385	8	2	2086.14	t
2905	456	28	2	1563.10	t
2906	1407	27	5	1536.26	t
2907	383	35	4	595.20	t
2908	693	5	2	805.44	t
2909	877	48	5	107.36	t
2910	609	8	1	567.80	t
2911	410	32	4	897.46	t
2912	1390	40	3	1565.95	t
2913	933	32	4	941.73	t
2914	512	18	2	2294.57	t
2915	1763	6	2	295.90	t
2916	1814	31	1	93.15	t
2917	1753	35	4	1799.68	t
2918	592	25	1	1106.85	t
2919	1753	30	1	363.92	t
2920	1207	18	5	1542.73	t
2921	1734	31	3	1736.99	t
2922	221	36	4	985.37	t
2923	1392	49	4	1937.70	t
2924	312	27	1	2414.30	t
2925	807	50	4	2199.04	t
2926	1140	12	5	2200.95	t
2927	1249	22	3	248.55	t
2928	694	2	3	2086.11	t
2929	1658	33	4	542.58	t
2930	1114	25	5	393.44	t
2931	966	17	2	1092.36	t
2932	85	21	3	856.69	t
2933	50	19	2	751.51	t
2934	1307	41	4	458.60	t
2935	949	9	4	1452.87	t
2936	1115	19	3	2084.67	t
2937	1069	14	5	551.55	t
2938	1033	33	4	228.06	t
2939	1448	18	3	1082.99	t
2940	1732	46	5	2108.05	t
2941	177	8	3	848.38	t
2942	1488	5	5	932.54	t
2943	1435	34	4	461.59	t
2944	488	24	4	714.60	t
2945	1692	38	3	943.82	t
2946	1776	12	4	1765.39	t
2947	73	6	3	437.22	t
2948	1435	33	5	1889.29	t
2949	104	6	4	1621.94	t
2950	1180	30	2	813.24	t
2951	1096	7	1	403.74	t
2952	957	9	4	2246.82	t
2953	57	49	2	2010.43	t
2954	397	16	2	1247.19	t
2955	1871	25	1	1735.18	t
2956	16	29	4	1682.39	t
2957	868	44	2	2478.07	t
2958	1455	34	5	323.94	t
2959	67	4	2	2235.27	t
2960	143	49	4	1593.88	t
2961	159	6	2	1753.64	t
2962	1074	35	3	1643.28	t
2963	899	32	2	408.23	t
2964	394	22	4	403.02	t
2965	81	16	3	2206.49	t
2966	339	19	4	1870.44	t
2967	1105	15	2	1180.06	t
2968	1346	43	4	892.45	t
2969	538	9	1	282.84	t
2970	737	37	3	1696.12	t
2971	808	13	3	1785.98	t
2972	1549	23	2	1156.50	t
2973	1137	48	2	1714.94	t
2974	1278	20	3	1439.29	t
2975	1416	41	4	1062.24	t
2976	1985	33	2	703.94	t
2977	1226	40	4	1667.95	t
2978	64	12	1	2193.26	t
2979	999	50	3	147.59	t
2980	908	43	2	1913.00	t
2981	245	48	2	1857.47	t
2982	1705	8	2	2299.59	t
2983	192	20	3	2294.79	t
2984	1653	46	2	1019.41	t
2985	1756	32	4	576.52	t
2986	1650	24	2	2154.75	t
2987	661	39	3	1577.40	t
2988	897	4	2	1056.67	t
2989	1458	2	5	1910.44	t
2990	1463	5	3	1915.91	t
2991	1722	50	2	1125.04	t
2992	750	9	4	1512.53	t
2993	594	27	1	2160.96	t
2994	707	43	2	2315.22	t
2995	774	45	2	665.01	t
2996	754	12	1	1178.15	t
2997	1157	16	4	2096.37	t
2998	1688	33	2	1565.73	t
2999	1487	44	3	1457.09	t
3000	624	12	3	1490.24	t
3001	776	31	2	115.89	t
3002	208	4	1	2260.21	t
3003	1998	10	2	2260.58	t
3004	1281	8	3	818.48	t
3005	727	45	2	631.12	t
3006	1939	2	2	1561.09	t
3007	149	5	3	333.03	t
3008	68	34	1	2301.22	t
3009	1960	23	3	168.97	t
3010	1108	26	5	1882.85	t
3011	858	47	4	424.47	t
3012	1379	10	3	375.53	t
3013	1578	44	2	509.88	t
3014	197	46	1	287.26	t
3015	1215	49	2	1614.43	t
3016	1587	12	2	677.90	t
3017	1020	37	5	966.59	t
3018	91	33	4	2030.37	t
3019	370	13	2	1169.46	t
3020	1315	49	2	1988.07	t
3021	337	50	2	1644.86	t
3022	1434	7	4	388.67	t
3023	653	8	4	680.01	t
3024	573	29	5	1294.75	t
3025	635	5	5	1450.13	t
3026	1437	8	3	1696.79	t
3027	1306	48	3	2245.78	t
3028	1316	43	4	1521.06	t
3029	248	43	3	1979.20	t
3030	290	12	4	1725.28	t
3031	1291	35	3	833.80	t
3032	1586	48	3	1612.78	t
3033	939	25	2	1277.45	t
3034	7	46	2	259.79	t
3035	1186	45	5	2232.36	t
3036	1580	18	5	2354.97	t
3037	1245	11	3	1736.73	t
3038	166	16	5	2011.84	t
3039	1686	40	2	454.92	t
3040	1989	11	2	2169.84	t
3041	246	34	5	1892.94	t
3042	446	9	4	998.91	t
3043	495	37	5	703.08	t
3044	484	45	4	289.81	t
3045	468	38	4	1369.92	t
3046	860	7	3	880.63	t
3047	1491	3	2	1328.99	t
3048	795	46	5	2381.02	t
3049	673	13	2	2487.50	t
3050	1524	25	4	1359.58	t
3051	1934	49	4	2241.42	t
3052	1690	39	3	1553.24	t
3053	199	18	1	1735.56	t
3054	1833	34	2	1905.75	t
3055	1427	13	1	2076.48	t
3056	1610	46	3	772.91	t
3057	1357	49	2	1100.71	t
3058	1652	30	4	2482.83	t
3059	1845	34	2	2480.71	t
3060	579	15	2	2188.85	t
3061	749	18	2	1602.45	t
3062	1667	2	2	2273.33	t
3063	1352	41	3	2032.03	t
3064	931	21	1	2410.98	t
3065	1207	46	4	1802.97	t
3066	217	41	5	984.98	t
3067	299	19	5	785.26	t
3068	159	16	5	669.87	t
3069	303	11	4	1090.01	t
3070	720	18	1	665.84	t
3071	526	46	4	1103.92	t
3072	467	29	5	1529.49	t
3073	1379	29	2	2315.95	t
3074	845	29	4	1463.07	t
3075	1993	26	2	511.76	t
3076	1863	11	4	1479.65	t
3077	1434	20	4	1652.42	t
3078	1432	43	4	365.49	t
3079	1549	15	2	2210.94	t
3080	1283	6	3	1617.45	t
3081	1622	34	2	2270.02	t
3082	996	41	2	899.50	t
3083	1586	26	1	1726.34	t
3084	1569	6	5	176.19	t
3085	1571	32	2	106.97	t
3086	1656	13	4	2285.98	t
3087	760	42	4	1163.22	t
3088	1679	45	3	1369.96	t
3089	505	3	3	1274.83	t
3090	1294	20	3	896.79	t
3091	1292	15	4	972.55	t
3092	1053	7	4	2479.03	t
3093	1944	35	4	1814.57	t
3094	651	27	4	845.10	t
3095	118	25	2	1292.65	t
3096	1397	41	5	1024.73	t
3097	983	22	4	979.47	t
3098	1209	8	2	1059.31	t
3099	1007	38	5	2312.76	t
3100	1906	43	3	1782.22	t
3101	519	23	3	2042.47	t
3102	1670	37	4	1728.48	t
3103	1679	50	4	2174.03	t
3104	840	10	4	630.52	t
3105	269	8	1	653.98	t
3106	1064	40	4	2246.31	t
3107	1521	5	2	427.97	t
3108	1932	44	4	1123.90	t
3109	1395	22	2	1378.35	t
3110	1318	50	4	1582.66	t
3111	748	29	4	2157.53	t
3112	1232	45	2	539.11	t
3113	1929	23	2	2461.54	t
3114	1425	17	5	717.45	t
3115	1165	44	2	949.86	t
3116	714	26	1	1426.26	t
3117	1782	42	4	1357.55	t
3118	1022	10	2	1179.73	t
3119	755	41	2	1787.01	t
3120	211	13	2	2133.29	t
3121	410	4	2	364.16	t
3122	1573	41	5	270.42	t
3123	1595	9	2	2091.88	t
3124	1570	4	3	2471.01	t
3125	1696	50	3	2380.06	t
3126	1185	7	3	764.40	t
3127	1497	31	2	278.27	t
3128	61	21	5	508.75	t
3129	680	42	1	644.53	t
3130	1980	45	2	578.53	t
3131	599	36	4	607.97	t
3132	1483	27	3	70.54	t
3133	1402	28	5	2459.60	t
3134	973	1	2	2286.08	t
3135	1824	2	3	1226.97	t
3136	612	48	5	2118.63	t
3137	746	16	5	541.15	t
3138	288	18	2	56.82	t
3139	40	42	3	2420.49	t
3140	572	41	4	108.98	t
3141	1019	41	2	2294.73	t
3142	409	6	3	791.89	t
3143	1976	11	3	700.48	t
3144	1687	28	3	801.67	t
3145	353	49	3	839.24	t
3146	1470	28	2	2039.62	t
3147	629	44	2	203.56	t
3148	137	4	2	161.71	t
3149	569	45	1	430.58	t
3150	990	15	2	1238.56	t
3151	1504	2	4	117.61	t
3152	285	14	1	2244.79	t
3153	1177	5	1	2237.74	t
3154	124	35	5	2026.01	t
3155	573	16	5	1780.27	t
3156	1047	26	3	156.72	t
3157	641	23	4	1443.91	t
3158	1492	32	2	248.66	t
3159	1021	50	1	1159.74	t
3160	1208	5	4	407.96	t
3161	1750	9	1	929.49	t
3162	236	6	2	2001.81	t
3163	1837	20	2	2173.07	t
3164	1769	29	2	1193.67	t
3165	240	29	5	48.30	t
3166	327	28	4	169.52	t
3167	1839	26	5	2027.03	t
3168	1538	29	4	1809.67	t
3169	759	36	4	1423.29	t
3170	397	38	2	1491.85	t
3171	559	21	3	692.89	t
3172	1281	21	3	58.41	t
3173	494	40	3	1833.84	t
3174	126	41	1	2402.68	t
3175	1877	16	4	1457.51	t
3176	946	2	4	2175.34	t
3177	1144	37	3	1439.94	t
3178	700	10	3	1757.32	t
3179	793	19	4	930.90	t
3180	211	7	5	1011.40	t
3181	1222	35	3	246.76	t
3182	48	34	4	203.88	t
3183	1400	11	1	242.37	t
3184	979	26	3	1543.82	t
3185	129	43	1	2184.28	t
3186	727	22	3	631.91	t
3187	1798	5	2	2375.77	t
3188	491	18	4	1374.68	t
3189	88	47	1	434.90	t
3190	310	29	3	2442.66	t
3191	1116	1	2	115.75	t
3192	1850	21	3	2385.56	t
3193	1932	23	3	1727.34	t
3194	1545	40	4	892.85	t
3195	583	4	4	1264.52	t
3196	534	40	1	406.15	t
3197	1802	11	3	1885.26	t
3198	305	32	2	678.34	t
3199	1462	23	2	448.59	t
3200	87	8	2	1047.29	t
3201	924	2	5	688.56	t
3202	588	17	5	1864.98	t
3203	1430	10	3	650.77	t
3204	1461	24	1	1141.06	t
3205	326	33	4	1517.11	t
3206	548	8	4	388.20	t
3207	296	3	5	1558.75	t
3208	1669	45	3	1490.30	t
3209	1059	35	1	2061.16	t
3210	1525	21	3	563.37	t
3211	416	15	3	2043.31	t
3212	741	12	3	1002.55	t
3213	1016	28	4	2353.58	t
3214	213	27	5	619.57	t
3215	726	15	4	1919.27	t
3216	1161	6	2	1789.62	t
3217	1836	47	4	1595.90	t
3218	1760	9	1	204.76	t
3219	1211	4	5	484.30	t
3220	1712	38	3	509.96	t
3221	661	45	1	1759.06	t
3222	505	24	5	1903.48	t
3223	1891	12	1	849.89	t
3224	1090	20	4	2440.22	t
3225	1663	47	5	1234.43	t
3226	117	9	4	826.39	t
3227	976	44	3	433.54	t
3228	622	49	2	957.57	t
3229	762	17	1	95.44	t
3230	974	47	2	236.64	t
3231	1836	43	2	2492.66	t
3232	1976	15	3	2110.02	t
3233	1641	50	2	1614.08	t
3234	178	30	3	1475.56	t
3235	971	48	4	2204.90	t
3236	26	7	2	1143.97	t
3237	1297	23	5	302.53	t
3238	1018	17	1	621.40	t
3239	474	9	3	392.40	t
3240	1730	22	2	1548.13	t
3241	323	44	1	1639.77	t
3242	1377	12	5	1346.61	t
3243	418	17	2	1588.85	t
3244	1412	23	1	1599.04	t
3245	251	27	3	1868.53	t
3246	960	12	2	2417.29	t
3247	1098	5	4	1965.17	t
3248	1731	10	4	1134.07	t
3249	1611	37	4	1040.99	t
3250	905	14	4	506.99	t
3251	931	19	1	1627.10	t
3252	1345	14	4	1810.95	t
3253	1702	19	2	2188.49	t
3254	622	15	4	1334.46	t
3255	824	46	2	1624.30	t
3256	190	49	1	2072.15	t
3257	762	3	4	204.66	t
3258	1953	28	1	1326.47	t
3259	1774	34	1	2349.42	t
3260	1590	10	1	1136.75	t
3261	1094	46	5	1268.23	t
3262	1695	44	5	484.96	t
3263	673	12	4	2183.21	t
3264	626	9	4	1774.19	t
3265	1109	42	4	1852.34	t
3266	152	43	5	863.81	t
3267	1816	29	2	91.99	t
3268	1533	19	5	1253.55	t
3269	1901	7	3	1174.84	t
3270	106	45	3	481.37	t
3271	1481	34	3	2200.32	t
3272	1921	40	4	38.61	t
3273	545	5	3	1729.30	t
3274	836	13	4	2004.48	t
3275	892	44	2	30.49	t
3276	1642	46	3	733.49	t
3277	268	14	3	2276.09	t
3278	1649	23	3	46.88	t
3279	883	36	4	2449.00	t
3280	1312	25	3	1900.58	t
3281	270	11	4	2333.18	t
3282	853	34	2	1542.33	t
3283	404	29	4	393.92	t
3284	274	16	5	1561.02	t
3285	321	10	3	712.43	t
3286	1920	41	3	1368.29	t
3287	652	45	5	2192.57	t
3288	784	39	2	1459.46	t
3289	1590	33	2	1036.55	t
3290	1806	32	5	275.15	t
3291	40	45	2	1105.86	t
3292	1114	27	2	1120.93	t
3293	1762	12	2	2296.96	t
3294	1941	49	4	1094.83	t
3295	1156	21	4	463.10	t
3296	1394	28	1	1151.07	t
3297	788	4	3	1281.86	t
3298	525	21	5	1987.33	t
3299	1983	7	3	491.16	t
3300	1981	35	1	103.23	t
3301	934	31	3	1115.40	t
3302	1475	37	5	1561.52	t
3303	1570	18	2	366.88	t
3304	889	3	2	1122.50	t
3305	880	36	4	1723.28	t
3306	238	7	3	399.79	t
3307	162	28	3	829.65	t
3308	1382	31	2	924.22	t
3309	1580	11	1	819.65	t
3310	624	2	3	1948.12	t
3311	620	1	5	620.88	t
3312	535	3	3	430.66	t
3313	1125	43	5	2385.82	t
3314	883	6	3	911.82	t
3315	1399	32	3	1682.33	t
3316	1211	38	5	357.73	t
3317	484	23	2	2304.51	t
3318	816	36	2	651.04	t
3319	198	21	4	1491.65	t
3320	732	16	1	31.84	t
3321	216	39	4	1160.55	t
3322	1993	9	3	1761.29	t
3323	526	19	2	2396.94	t
3324	209	20	3	2147.83	t
3325	1483	10	4	1732.75	t
3326	1671	39	3	735.81	t
3327	1135	2	2	659.81	t
3328	483	27	1	723.82	t
3329	374	18	5	2295.85	t
3330	975	15	3	664.79	t
3331	328	37	4	1063.73	t
3332	1677	35	2	1482.12	t
3333	347	44	5	1081.18	t
3334	463	19	4	558.13	t
3335	1276	34	5	921.57	t
3336	705	26	3	151.74	t
3337	592	9	2	485.82	t
3338	708	41	4	1334.34	t
3339	1370	24	5	1882.52	t
3340	400	27	4	556.48	t
3341	1791	36	1	1141.66	t
3342	1736	7	2	733.59	t
3343	1821	46	3	374.08	t
3344	318	3	2	905.48	t
3345	1818	46	3	2175.40	t
3346	497	10	2	160.65	t
3347	1550	43	5	698.48	t
3348	1801	10	3	1196.14	t
3349	1622	50	3	1110.37	t
3350	1542	10	4	1299.75	t
3351	1534	45	2	740.03	t
3352	1719	6	4	802.82	t
3353	1499	8	1	1617.25	t
3354	1201	9	2	1986.92	t
3355	1040	39	3	526.03	t
3356	105	49	4	559.35	t
3357	649	49	2	93.70	t
3358	1854	42	5	227.57	t
3359	1854	21	2	963.53	t
3360	1303	4	4	1027.06	t
3361	426	4	3	530.21	t
3362	653	10	4	1563.32	t
3363	623	32	1	1583.22	t
3364	257	7	4	1326.81	t
3365	291	8	5	217.63	t
3366	174	33	3	460.85	t
3367	579	49	4	1236.01	t
3368	1290	50	3	539.48	t
3369	1494	40	1	2428.11	t
3370	1316	4	4	921.88	t
3371	1599	24	2	772.69	t
3372	1082	40	4	43.78	t
3373	1619	14	3	1622.97	t
3374	1895	47	5	1105.52	t
3375	1126	16	4	2234.14	t
3376	644	22	3	1454.52	t
3377	1359	13	1	75.25	t
3378	1652	49	2	2118.58	t
3379	697	12	3	1583.62	t
3380	1056	5	4	1747.13	t
3381	774	34	1	94.98	t
3382	1829	29	4	783.28	t
3383	190	41	4	2492.26	t
3384	36	10	2	2273.76	t
3385	801	17	5	2329.81	t
3386	1054	45	5	1703.98	t
3387	1009	4	2	187.60	t
3388	106	18	4	734.31	t
3389	473	19	3	1095.10	t
3390	491	49	2	482.10	t
3391	1398	40	4	759.83	t
3392	1657	36	4	312.52	t
3393	671	33	4	2005.26	t
3394	428	2	4	2407.78	t
3395	883	26	2	894.46	t
3396	1986	6	4	1339.49	t
3397	166	42	5	287.75	t
3398	341	22	4	331.07	t
3399	1859	16	5	1135.95	t
3400	1418	46	3	191.07	t
3401	1021	27	5	729.31	t
3402	1250	26	5	2242.12	t
3403	1172	8	1	2070.95	t
3404	470	3	3	659.21	t
3405	115	7	4	1177.65	t
3406	1399	28	3	2046.20	t
3407	996	22	4	620.53	t
3408	1610	25	5	943.28	t
3409	766	8	4	323.76	t
3410	1878	12	2	885.62	t
3411	1535	40	4	1157.59	t
3412	949	31	4	1568.44	t
3413	266	16	5	434.94	t
3414	659	45	2	1383.62	t
3415	1655	20	3	1286.57	t
3416	373	35	3	294.67	t
3417	1696	12	3	1912.68	t
3418	150	12	2	1106.50	t
3419	781	30	4	1353.43	t
3420	1345	13	4	2471.54	t
3421	1487	40	4	1578.82	t
3422	808	28	2	559.99	t
3423	350	11	2	2260.69	t
3424	1534	37	2	1374.23	t
3425	1307	45	2	276.42	t
3426	1401	36	2	1356.64	t
3427	652	10	5	909.90	t
3428	1405	16	1	2109.75	t
3429	898	17	5	1537.66	t
3430	334	5	2	2027.08	t
3431	1678	14	4	1814.88	t
3432	1111	6	1	884.76	t
3433	832	4	2	841.69	t
3434	703	26	4	632.89	t
3435	297	5	3	2324.62	t
3436	1587	19	1	1569.34	t
3437	1834	5	4	1488.33	t
3438	1182	44	1	1447.20	t
3439	549	28	3	1395.46	t
3440	1932	4	4	2055.16	t
3441	1236	50	3	718.63	t
3442	334	4	3	285.29	t
3443	1218	50	2	321.48	t
3444	1661	4	2	565.63	t
3445	1311	8	2	430.36	t
3446	382	6	2	2486.56	t
3447	1493	22	3	1416.89	t
3448	1108	25	1	1823.94	t
3449	1764	41	4	1162.49	t
3450	1852	5	2	1466.51	t
3451	1274	18	3	1179.54	t
3452	1227	32	1	1608.57	t
3453	255	5	4	760.49	t
3454	1007	21	4	2080.53	t
3455	731	32	1	1776.19	t
3456	668	9	4	2032.92	t
3457	443	42	4	1877.85	t
3458	510	48	2	1673.22	t
3459	891	31	2	2057.48	t
3460	286	32	3	1231.84	t
3461	827	13	3	2020.95	t
3462	1377	20	2	2412.60	t
3463	1434	3	4	340.46	t
3464	254	19	4	197.85	t
3465	1587	19	4	886.52	t
3466	1004	37	3	2378.60	t
3467	948	20	2	634.79	t
3468	859	48	1	22.26	t
3469	289	27	2	89.20	t
3470	698	31	4	2458.17	t
3471	1671	40	3	2217.25	t
3472	1619	22	4	891.70	t
3473	143	16	3	1966.05	t
3474	1416	13	5	1228.16	t
3475	1832	25	2	1886.32	t
3476	726	18	5	504.95	t
3477	155	2	2	29.73	t
3478	1184	11	4	1607.73	t
3479	1930	20	2	1812.11	t
3480	1907	43	2	749.73	t
3481	1054	19	3	1830.48	t
3482	1560	50	5	2354.99	t
3483	804	22	3	176.68	t
3484	1837	24	4	788.63	t
3485	253	49	4	1432.11	t
3486	400	32	2	2187.70	t
3487	196	18	4	2243.09	t
3488	1059	24	2	377.48	t
3489	296	24	2	284.52	t
3490	1637	15	1	816.13	t
3491	891	8	3	824.09	t
3492	1304	44	3	1858.22	t
3493	1708	12	1	1087.47	t
3494	158	41	2	1209.22	t
3495	710	14	4	1944.96	t
3496	1787	26	3	1039.24	t
3497	630	28	4	1751.65	t
3498	1072	23	3	857.11	t
3499	788	40	3	838.09	t
3500	1193	2	2	1158.09	t
3501	1725	15	3	1166.93	t
3502	1688	42	3	1617.68	t
3503	1153	38	2	799.01	t
3504	760	17	5	1806.54	t
3505	1483	10	2	1362.69	t
3506	845	26	2	961.47	t
3507	452	21	2	782.58	t
3508	1377	10	3	90.85	t
3509	916	42	2	344.81	t
3510	1611	21	2	2221.33	t
3511	784	28	1	1161.86	t
3512	110	8	3	1365.04	t
3513	538	43	4	1835.49	t
3514	457	45	1	1716.85	t
3515	1598	22	1	1280.86	t
3516	705	1	3	296.81	t
3517	318	11	4	2176.35	t
3518	266	23	4	282.01	t
3519	564	44	4	122.37	t
3520	1493	30	2	460.66	t
3521	943	41	2	1648.99	t
3522	844	11	1	389.05	t
3523	1784	24	3	1405.72	t
3524	312	41	1	1339.99	t
3525	1372	3	4	999.22	t
3526	1492	48	2	569.95	t
3527	730	37	1	861.68	t
3528	1836	32	4	310.18	t
3529	891	5	3	1839.30	t
3530	689	3	3	1306.35	t
3531	648	40	4	247.17	t
3532	572	45	3	536.34	t
3533	369	21	2	2342.31	t
3534	1085	35	5	2087.61	t
3535	797	5	2	113.16	t
3536	144	13	3	993.91	t
3537	372	14	4	2390.97	t
3538	1945	25	2	1044.12	t
3539	1062	42	3	346.07	t
3540	1067	10	4	1012.47	t
3541	715	15	4	737.27	t
3542	733	48	2	2043.73	t
3543	738	38	1	2483.75	t
3544	1135	45	3	261.92	t
3545	1272	27	4	1618.13	t
3546	291	15	4	2415.16	t
3547	1719	40	5	2397.45	t
3548	452	37	2	2152.57	t
3549	784	30	4	1319.01	t
3550	265	33	3	429.61	t
3551	1022	2	4	1428.62	t
3552	1817	8	2	2071.37	t
3553	1078	34	2	1914.41	t
3554	1897	39	3	2232.97	t
3555	1903	36	3	607.48	t
3556	155	4	4	1750.47	t
3557	1928	43	4	1028.12	t
3558	1053	40	3	926.19	t
3559	752	29	1	1870.49	t
3560	97	17	3	1856.70	t
3561	1885	30	3	1573.58	t
3562	572	33	2	25.37	t
3563	1364	5	2	1088.11	t
3564	1013	7	5	897.06	t
3565	835	12	2	1152.31	t
3566	210	14	2	279.89	t
3567	1432	3	2	2277.60	t
3568	675	35	3	205.23	t
3569	257	19	4	712.16	t
3570	1729	24	1	1207.36	t
3571	920	11	4	37.92	t
3572	1112	2	5	319.73	t
3573	1871	35	3	2093.98	t
3574	868	11	2	2342.06	t
3575	421	12	3	776.87	t
3576	465	16	4	253.87	t
3577	1165	32	3	1392.17	t
3578	809	30	2	898.44	t
3579	1288	48	4	1950.26	t
3580	83	49	2	1712.86	t
3581	412	28	4	335.40	t
3582	1826	28	1	2397.57	t
3583	57	44	2	1878.84	t
3584	719	18	4	1694.48	t
3585	1470	45	2	234.24	t
3586	164	15	2	2144.82	t
3587	1881	46	4	613.14	t
3588	1516	16	3	1069.79	t
3589	887	8	3	542.24	t
3590	942	41	2	1650.15	t
3591	1259	39	4	1751.96	t
3592	525	33	2	1153.64	t
3593	1763	37	3	1299.71	t
3594	992	46	2	278.01	t
3595	1732	39	2	602.47	t
3596	317	8	4	1818.16	t
3597	956	30	3	2087.33	t
3598	1164	45	5	2147.27	t
3599	1458	10	3	1874.72	t
3600	1262	35	4	86.15	t
3601	1588	23	2	1246.03	t
3602	726	49	4	1292.13	t
3603	1035	6	3	1162.77	t
3604	312	48	2	930.59	t
3605	352	22	5	1539.23	t
3606	1573	14	2	1472.75	t
3607	107	49	5	678.38	t
3608	1540	3	3	1473.68	t
3609	38	19	1	1273.75	t
3610	514	42	3	1313.24	t
3611	1995	32	4	771.75	t
3612	1727	40	2	2055.46	t
3613	13	20	2	231.63	t
3614	548	2	2	1558.67	t
3615	35	36	4	1098.05	t
3616	1535	25	3	505.28	t
3617	1453	46	4	26.30	t
3618	1553	27	1	1025.77	t
3619	1073	5	4	1312.71	t
3620	19	50	2	1699.88	t
3621	1092	8	4	35.08	t
3622	237	2	2	1346.25	t
3623	1733	49	2	1821.20	t
3624	1461	9	4	53.36	t
3625	62	40	3	516.36	t
3626	945	24	1	1575.80	t
3627	486	33	2	1987.19	t
3628	954	26	4	140.99	t
3629	1361	35	2	2378.07	t
3630	1438	42	4	314.82	t
3631	1569	20	3	1222.22	t
3632	1643	46	2	668.54	t
3633	1657	10	1	1373.73	t
3634	1692	48	3	531.50	t
3635	1220	32	2	1660.57	t
3636	1833	37	4	147.92	t
3637	1889	40	2	1986.26	t
3638	918	46	1	1607.09	t
3639	1606	44	4	1594.07	t
3640	285	46	1	53.58	t
3641	1630	34	4	1165.17	t
3642	457	20	3	2129.83	t
3643	330	36	2	1018.00	t
3644	1054	13	4	1754.69	t
3645	929	30	2	314.68	t
3646	1608	14	2	1903.29	t
3647	1508	4	5	2300.41	t
3648	272	12	5	551.13	t
3649	374	13	5	1549.03	t
3650	473	30	4	1080.88	t
3651	1570	34	4	2122.83	t
3652	55	9	3	2127.07	t
3653	532	5	3	2111.83	t
3654	121	41	2	2316.77	t
3655	815	34	1	2110.02	t
3656	1412	46	5	2177.40	t
3657	1124	50	4	547.17	t
3658	652	21	5	1894.31	t
3659	1758	11	4	1362.59	t
3660	1567	15	3	2472.94	t
3661	375	16	1	436.48	t
3662	190	38	5	1398.35	t
3663	1842	35	5	1270.01	t
3664	1507	25	3	1425.04	t
3665	682	15	1	976.96	t
3666	638	10	5	660.91	t
3667	467	11	3	492.57	t
3668	736	50	2	2193.75	t
3669	1261	27	1	1711.88	t
3670	919	23	1	2484.63	t
3671	208	39	4	1761.13	t
3672	461	26	3	858.74	t
3673	1214	39	3	2258.30	t
3674	1491	5	3	1728.61	t
3675	1780	49	4	2096.60	t
3676	1961	45	2	582.29	t
3677	353	40	3	1012.64	t
3678	715	35	2	1627.65	t
3679	1020	31	4	2071.27	t
3680	625	32	3	466.44	t
3681	1523	39	3	211.36	t
3682	1302	31	2	762.51	t
3683	1137	45	3	45.83	t
3684	875	30	4	1513.82	t
3685	1664	12	2	1543.20	t
3686	602	34	2	2083.27	t
3687	506	7	2	2017.12	t
3688	748	12	5	774.96	t
3689	1997	6	2	1928.37	t
3690	1892	19	4	1176.98	t
3691	1331	34	4	967.66	t
3692	1298	22	4	2294.52	t
3693	1793	5	2	2308.15	t
3694	146	15	5	747.96	t
3695	264	7	4	1318.51	t
3696	1916	31	4	1809.72	t
3697	1898	49	3	1074.58	t
3698	833	33	2	670.08	t
3699	822	14	3	644.40	t
3700	600	20	1	553.01	t
3701	1511	6	2	1340.84	t
3702	3	33	4	269.38	t
3703	1926	4	3	364.73	t
3704	521	1	3	2245.26	t
3705	735	2	5	1291.86	t
3706	1535	35	4	1622.76	t
3707	204	19	4	2040.58	t
3708	214	27	1	2359.65	t
3709	286	38	2	215.85	t
3710	1366	44	1	1354.58	t
3711	833	35	2	26.72	t
3712	974	28	3	149.95	t
3713	1829	48	3	43.02	t
3714	1950	5	4	967.50	t
3715	1296	47	4	2052.39	t
3716	271	42	1	1546.18	t
3717	1736	45	5	2002.00	t
3718	1435	48	1	2184.05	t
3719	1553	2	4	1052.74	t
3720	1809	26	4	1276.87	t
3721	1337	6	5	1081.70	t
3722	909	42	1	413.89	t
3723	910	27	1	2223.58	t
3724	304	21	1	253.09	t
3725	1492	19	4	230.24	t
3726	903	40	4	2053.07	t
3727	726	19	1	1336.91	t
3728	718	29	1	1739.78	t
3729	664	31	1	565.13	t
3730	393	2	3	126.13	t
3731	881	13	4	1248.99	t
3732	1733	48	3	531.65	t
3733	1262	46	2	2126.60	t
3734	740	48	3	847.48	t
3735	376	41	5	1922.39	t
3736	1971	33	2	2414.47	t
3737	195	19	2	725.07	t
3738	179	40	5	1998.57	t
3739	899	38	3	1829.09	t
3740	124	38	5	2010.91	t
3741	62	31	3	765.21	t
3742	1331	26	3	2431.92	t
3743	275	43	5	2448.80	t
3744	656	5	5	2378.80	t
3745	1467	43	4	700.19	t
3746	1332	32	3	2228.80	t
3747	1135	19	2	954.93	t
3748	1282	46	4	634.11	t
3749	582	21	2	334.88	t
3750	467	3	3	1254.91	t
3751	1349	4	2	1073.83	t
3752	150	44	2	2302.39	t
3753	82	25	3	1097.68	t
3754	1403	31	3	908.90	t
3755	1912	34	3	2270.51	t
3756	696	10	5	2192.50	t
3757	1170	26	2	1794.79	t
3758	155	48	2	185.33	t
3759	1245	27	5	1112.64	t
3760	1020	33	4	2148.18	t
3761	974	27	3	2388.49	t
3762	647	4	4	58.94	t
3763	817	47	1	998.22	t
3764	1580	28	2	408.57	t
3765	1854	3	2	1107.38	t
3766	352	50	3	1667.71	t
3767	14	6	2	592.88	t
3768	1188	10	3	895.90	t
3769	1280	10	3	2463.50	t
3770	1823	35	2	2323.84	t
3771	1451	5	4	289.83	t
3772	1590	48	4	1518.35	t
3773	915	45	2	361.34	t
3774	579	14	4	2024.29	t
3775	190	44	2	2015.91	t
3776	1123	16	3	1519.26	t
3777	1826	50	2	664.86	t
3778	1910	10	3	1240.89	t
3779	623	13	5	243.22	t
3780	1488	21	3	1727.00	t
3781	853	32	2	20.28	t
3782	1606	5	5	1954.01	t
3783	1530	42	4	979.58	t
3784	911	6	4	252.78	t
3785	144	11	4	1139.68	t
3786	1372	27	2	966.92	t
3787	774	5	1	2159.86	t
3788	1761	26	2	720.43	t
3789	1308	33	4	677.15	t
3790	267	38	3	517.54	t
3791	205	30	3	739.26	t
3792	354	15	4	259.36	t
3793	989	32	4	2328.95	t
3794	1700	15	2	828.45	t
3795	37	6	2	299.82	t
3796	1261	5	5	1306.58	t
3797	709	43	3	1515.13	t
3798	607	2	3	892.52	t
3799	1147	6	4	1649.67	t
3800	830	24	2	1186.62	t
3801	1284	50	3	998.45	t
3802	159	37	4	1587.89	t
3803	1527	30	2	2070.74	t
3804	1560	46	5	162.99	t
3805	1152	47	2	1971.99	t
3806	692	44	3	391.29	t
3807	1285	8	4	1431.61	t
3808	1640	38	2	2265.59	t
3809	205	20	4	739.60	t
3810	212	19	5	141.11	t
3811	750	16	4	875.84	t
3812	599	49	3	2283.97	t
3813	625	10	4	1259.05	t
3814	485	41	4	1637.63	t
3815	1871	7	3	1708.46	t
3816	460	6	5	2142.91	t
3817	1522	35	2	1147.56	t
3818	634	12	4	510.69	t
3819	985	8	4	49.96	t
3820	1796	38	2	477.30	t
3821	1904	47	1	949.10	t
3822	1623	2	4	1620.00	t
3823	51	37	1	1986.40	t
3824	266	40	3	2112.66	t
3825	1996	31	2	220.45	t
3826	51	31	4	68.37	t
3827	1375	31	2	1196.57	t
3828	932	27	4	1175.82	t
3829	170	43	5	1440.76	t
3830	847	9	3	414.02	t
3831	1284	35	4	749.11	t
3832	318	20	3	2465.04	t
3833	1676	5	3	616.08	t
3834	1532	20	3	1488.81	t
3835	1650	8	3	576.96	t
3836	418	15	4	663.07	t
3837	1555	7	2	1690.51	t
3838	617	23	2	2013.28	t
3839	259	7	1	1715.56	t
3840	519	23	4	1671.90	t
3841	711	13	1	2247.02	t
3842	1883	2	2	2283.55	t
3843	500	1	1	434.49	t
3844	903	19	4	86.62	t
3845	776	7	3	280.97	t
3846	1717	7	4	2006.73	t
3847	350	27	3	2048.41	t
3848	819	2	2	1940.25	t
3849	1259	41	3	2089.07	t
3850	1067	23	5	238.08	t
3851	1643	23	3	934.87	t
3852	1903	23	1	1979.44	t
3853	890	3	4	1267.82	t
3854	155	49	3	1829.14	t
3855	1863	44	2	262.97	t
3856	1352	46	2	421.36	t
3857	92	44	4	841.01	t
3858	1066	14	2	592.38	t
3859	765	17	3	1395.08	t
3860	207	20	2	1010.46	t
3861	1964	38	2	2172.89	t
3862	1935	20	5	1226.98	t
3863	1036	45	2	1318.98	t
3864	1730	2	4	1937.90	t
3865	1014	10	3	1990.47	t
3866	327	27	1	2262.83	t
3867	1275	30	3	742.72	t
3868	44	14	2	909.60	t
3869	264	46	3	2139.58	t
3870	1815	47	1	424.06	t
3871	271	9	4	2302.49	t
3872	87	15	4	603.05	t
3873	1095	29	2	69.17	t
3874	1797	42	2	2227.82	t
3875	986	36	2	523.30	t
3876	1905	33	4	281.50	t
3877	1687	8	3	2495.44	t
3878	856	30	5	1921.77	t
3879	1457	45	4	343.55	t
3880	491	22	1	647.10	t
3881	1355	37	1	1719.64	t
3882	875	3	1	2126.39	t
3883	145	46	1	164.93	t
3884	897	30	2	1204.48	t
3885	917	14	3	2214.87	t
3886	779	2	5	1568.52	t
3887	41	25	3	1033.61	t
3888	173	7	2	1152.55	t
3889	1032	27	2	900.47	t
3890	1145	8	2	937.84	t
3891	1774	19	3	2110.80	t
3892	1852	16	4	1966.19	t
3893	1614	17	3	1098.96	t
3894	844	7	5	1549.73	t
3895	15	46	2	1289.26	t
3896	1381	29	3	2047.29	t
3897	628	42	2	1341.92	t
3898	1929	37	2	912.02	t
3899	1115	21	3	495.69	t
3900	181	37	3	2098.74	t
3901	1038	22	2	1833.98	t
3902	534	39	2	93.90	t
3903	1819	28	4	2493.63	t
3904	1375	21	1	2022.67	t
3905	245	29	4	1501.73	t
3906	1916	30	2	1485.18	t
3907	597	8	2	1091.12	t
3908	1924	45	5	1619.81	t
3909	1165	30	2	872.33	t
3910	918	49	2	1412.26	t
3911	809	17	2	2368.97	t
3912	941	6	4	301.29	t
3913	530	2	2	725.04	t
3914	1680	41	3	1668.59	t
3915	1289	23	2	749.94	t
3916	1418	20	4	1517.80	t
3917	1145	47	3	254.97	t
3918	1944	31	4	1183.89	t
3919	451	38	4	1119.89	t
3920	858	19	4	1510.63	t
3921	103	26	4	1414.10	t
3922	201	11	5	1404.72	t
3923	137	27	2	2370.41	t
3924	420	49	4	308.54	t
3925	723	22	2	702.05	t
3926	1773	36	2	146.52	t
3927	127	3	3	2474.51	t
3928	1799	15	2	2339.17	t
3929	1731	34	2	2469.59	t
3930	262	37	2	411.07	t
3931	804	6	2	2402.90	t
3932	1696	27	2	1145.98	t
3933	702	43	1	261.82	t
3934	1043	48	1	2313.12	t
3935	1121	48	1	603.23	t
3936	22	30	2	1951.00	t
3937	1207	34	4	1576.21	t
3938	655	47	3	49.00	t
3939	1782	7	4	1472.04	t
3940	1672	27	3	271.00	t
3941	138	32	2	554.77	t
3942	1809	15	3	350.39	t
3943	564	23	4	204.02	t
3944	1528	41	2	2467.76	t
3945	1396	7	3	2077.59	t
3946	645	9	4	2228.71	t
3947	887	29	2	338.48	t
3948	670	21	2	1756.57	t
3949	1594	18	3	1924.50	t
3950	21	44	1	320.84	t
3951	696	8	2	984.15	t
3952	562	38	5	2078.86	t
3953	1335	35	1	1571.12	t
3954	775	37	2	1422.32	t
3955	831	10	3	132.13	t
3956	1858	38	4	1413.11	t
3957	1103	13	2	2124.05	t
3958	140	12	5	68.65	t
3959	1565	4	4	368.91	t
3960	1277	32	3	1587.11	t
3961	1285	40	2	22.97	t
3962	1619	23	3	1330.78	t
3963	1456	10	5	390.18	t
3964	669	13	4	819.92	t
3965	787	6	3	1308.32	t
3966	925	21	5	2340.25	t
3967	1389	8	2	1135.10	t
3968	333	42	1	177.06	t
3969	679	18	5	255.29	t
3970	1864	5	2	1334.46	t
3971	1601	19	2	140.33	t
3972	654	19	4	185.18	t
3973	1110	23	4	2263.94	t
3974	1599	40	5	243.22	t
3975	659	15	1	1395.96	t
3976	1052	9	3	1678.55	t
3977	967	11	2	1446.92	t
3978	744	37	3	1642.52	t
3979	1535	18	3	2392.15	t
3980	1664	9	1	1623.86	t
3981	1164	8	3	466.71	t
3982	1104	15	4	1810.32	t
3983	1693	38	5	1179.56	t
3984	1852	23	3	1192.63	t
3985	1514	32	4	369.32	t
3986	1100	19	1	2442.46	t
3987	232	3	2	2199.64	t
3988	1418	15	2	2257.49	t
3989	1913	28	4	1136.32	t
3990	1077	30	3	1848.92	t
3991	891	17	2	1398.05	t
3992	626	23	4	1053.09	t
3993	709	29	3	524.59	t
3994	59	27	2	1592.31	t
3995	277	13	3	1968.77	t
3996	684	35	3	940.34	t
3997	686	19	1	775.83	t
3998	1254	33	2	456.28	t
3999	1886	12	3	1707.82	t
4000	860	24	5	1119.40	t
4001	2002	31	5	35.00	f
4002	2002	50	1	120.00	f
4003	2002	50	1	120.00	f
4004	2002	5	5	80.00	t
4005	2002	39	1	80.00	t
4006	2003	50	2	120.00	t
4007	2004	16	1	60.00	t
4008	2004	50	1	120.00	t
4009	2004	50	1	120.00	t
4010	2005	50	1	120.00	f
4011	2005	50	1	120.00	f
4012	2005	5	1	80.00	f
4013	2005	5	1	80.00	f
4014	2005	5	1	80.00	t
4015	2005	40	1	200.00	t
4016	2006	34	1	250.00	t
4017	2007	44	1	300.00	f
4018	2007	44	1	300.00	f
4019	2007	5	1	80.00	f
4020	2007	44	1	300.00	f
4021	2007	5	1	80.00	f
4023	2007	44	1	300.00	t
4024	2007	39	1	80.00	t
4022	2007	44	1	300.00	f
4025	2008	24	1	100.00	t
4026	2009	30	1	30.00	t
4027	2010	51	1	350.00	t
4028	2010	33	1	200.00	t
4029	2011	7	1	300.00	t
4030	2011	33	1	200.00	t
4031	2012	12	1	250.00	f
4032	2012	20	1	90.00	f
4033	2012	12	1	250.00	f
4034	2012	20	1	90.00	f
4035	2012	12	1	250.00	f
4036	2012	20	1	90.00	f
4037	2012	12	1	250.00	f
4038	2012	20	1	90.00	f
4039	2012	17	1	45.00	f
4044	2013	47	1	200.00	t
4042	2013	14	1	120.00	f
4043	2013	47	1	200.00	f
4045	2012	12	1	250.00	t
4046	2012	20	1	90.00	t
4047	2012	15	1	40.00	t
4040	2012	12	1	250.00	f
4041	2012	20	1	90.00	f
4048	2014	18	1	20.00	t
4049	2015	33	1	200.00	t
4051	2016	6	1	1000.00	t
4050	2016	6	1	1000.00	f
4053	2018	14	1	120.00	f
4054	2017	21	1	150.00	t
4055	2017	22	1	600.00	t
4052	2017	21	1	150.00	f
4058	2019	33	1	200.00	t
4056	2019	33	1	200.00	f
4057	2019	11	1	45.00	f
4059	2018	14	1	120.00	t
4060	2018	15	1	40.00	t
4061	2020	6	1	1000.00	t
4062	2021	9	1	20.00	t
4063	2021	19	1	50.00	t
4064	2022	26	1	150.00	t
4065	2022	36	1	150.00	t
4066	2023	46	1	600.00	t
4067	2024	38	1	500.00	t
4068	2025	51	1	350.00	t
4069	2026	15	1	40.00	t
4070	2027	18	1	20.00	t
4072	2028	6	1	1000.00	t
4073	2028	21	1	150.00	t
4071	2028	6	1	1000.00	f
4074	2029	26	1	150.00	t
4075	2030	33	1	200.00	t
4076	2031	17	1	45.00	t
4077	2032	7	1	300.00	t
4078	2033	26	1	150.00	t
4079	2034	7	1	300.00	t
4080	2035	34	1	250.00	t
4081	2036	11	1	45.00	t
4082	2037	33	1	200.00	t
\.


--
-- Data for Name: facturas; Type: TABLE DATA; Schema: public; Owner: erp_user
--

COPY public.facturas (facturaid, ventaid, numerofactura, fechaemision, xmlfactura, creadoporusuarioid, activo) FROM stdin;
1	1	FAC-000001	2024-10-22 01:24:38.069028	\N	3	t
2	2	FAC-000002	2025-05-07 11:54:02.280093	\N	6	t
3	3	FAC-000003	2024-12-08 13:44:03.782775	\N	7	t
4	4	FAC-000004	2024-08-09 06:25:26.890937	\N	5	t
5	5	FAC-000005	2025-06-11 07:40:23.418473	\N	8	t
6	6	FAC-000006	2024-07-27 04:41:22.485605	\N	6	t
7	7	FAC-000007	2024-08-07 17:49:12.249349	\N	9	t
8	8	FAC-000008	2024-08-27 09:25:24.218211	\N	7	t
9	9	FAC-000009	2025-02-10 09:23:04.341216	\N	6	t
10	10	FAC-000010	2024-12-21 15:27:06.190483	\N	3	t
11	11	FAC-000011	2025-04-28 00:13:56.153278	\N	9	t
12	12	FAC-000012	2024-09-30 03:49:16.823596	\N	9	t
13	13	FAC-000013	2024-09-19 09:37:34.431233	\N	6	t
14	14	FAC-000014	2024-07-22 06:28:56.033664	\N	8	t
15	15	FAC-000015	2025-02-12 02:31:46.157647	\N	7	t
16	16	FAC-000016	2025-04-07 23:22:18.964497	\N	5	t
17	17	FAC-000017	2024-09-16 17:31:13.81861	\N	5	t
18	18	FAC-000018	2025-05-23 08:21:00.892579	\N	8	t
19	19	FAC-000019	2024-12-06 14:45:50.265109	\N	8	t
20	20	FAC-000020	2025-02-04 03:10:18.555808	\N	3	t
21	21	FAC-000021	2024-08-14 08:29:30.680831	\N	6	t
22	22	FAC-000022	2025-04-11 21:07:48.712224	\N	9	t
23	23	FAC-000023	2025-01-10 16:56:58.41632	\N	5	t
24	24	FAC-000024	2024-11-07 12:12:58.835839	\N	3	t
25	25	FAC-000025	2025-06-08 10:01:02.681266	\N	2	t
26	26	FAC-000026	2025-01-14 16:55:09.853847	\N	5	t
27	27	FAC-000027	2024-09-07 06:56:33.751016	\N	9	t
28	28	FAC-000028	2024-11-28 16:02:44.786223	\N	4	t
29	29	FAC-000029	2025-02-05 01:10:02.568059	\N	6	t
30	30	FAC-000030	2025-05-04 02:55:55.204029	\N	8	t
31	31	FAC-000031	2024-08-26 02:26:06.901653	\N	8	t
32	32	FAC-000032	2024-11-22 06:00:40.161255	\N	1	t
33	33	FAC-000033	2024-10-05 12:40:58.369488	\N	7	t
34	34	FAC-000034	2024-08-19 23:22:44.402727	\N	6	t
35	35	FAC-000035	2024-11-16 03:04:05.850434	\N	7	t
36	36	FAC-000036	2024-12-26 19:58:13.35038	\N	7	t
37	37	FAC-000037	2024-07-10 01:16:30.435653	\N	7	t
38	38	FAC-000038	2025-04-01 05:46:18.061187	\N	4	t
39	39	FAC-000039	2025-03-04 11:32:59.375384	\N	7	t
40	40	FAC-000040	2024-11-12 16:55:19.040428	\N	2	t
41	41	FAC-000041	2025-04-05 15:50:23.497701	\N	3	t
42	42	FAC-000042	2024-09-05 11:25:29.310213	\N	3	t
43	43	FAC-000043	2025-04-21 15:53:39.430603	\N	3	t
44	44	FAC-000044	2025-01-24 21:15:33.3895	\N	1	t
45	45	FAC-000045	2025-06-05 19:17:04.944672	\N	10	t
46	46	FAC-000046	2024-08-20 21:30:45.198263	\N	6	t
47	47	FAC-000047	2025-02-07 14:25:10.048721	\N	2	t
48	48	FAC-000048	2024-08-31 06:51:40.654376	\N	4	t
49	49	FAC-000049	2025-03-20 00:54:16.199965	\N	4	t
50	50	FAC-000050	2024-08-25 05:04:08.349083	\N	10	t
51	51	FAC-000051	2024-10-18 09:48:50.616652	\N	6	t
52	52	FAC-000052	2025-04-27 15:26:00.412434	\N	8	t
53	53	FAC-000053	2025-06-04 02:55:43.9948	\N	9	t
54	54	FAC-000054	2025-03-07 09:18:29.273104	\N	5	t
55	55	FAC-000055	2024-06-20 05:03:02.447538	\N	4	t
56	56	FAC-000056	2024-08-31 09:20:31.533823	\N	7	t
57	57	FAC-000057	2024-11-15 06:36:38.156192	\N	8	t
58	58	FAC-000058	2024-07-17 20:50:25.734275	\N	2	t
59	59	FAC-000059	2024-08-22 07:49:20.48509	\N	2	t
60	60	FAC-000060	2025-04-11 12:54:55.677497	\N	2	t
61	61	FAC-000061	2025-05-24 11:25:03.720012	\N	9	t
62	62	FAC-000062	2025-05-15 11:04:57.845466	\N	5	t
63	63	FAC-000063	2024-09-02 02:15:56.1114	\N	1	t
64	64	FAC-000064	2025-05-08 19:27:10.479602	\N	1	t
65	65	FAC-000065	2025-01-26 14:41:35.191917	\N	4	t
66	66	FAC-000066	2024-12-20 12:49:58.475156	\N	10	t
67	67	FAC-000067	2024-11-20 02:55:36.753641	\N	2	t
68	68	FAC-000068	2025-02-21 18:15:23.811676	\N	3	t
69	69	FAC-000069	2024-08-17 04:38:58.18644	\N	6	t
70	70	FAC-000070	2025-04-12 23:21:41.166757	\N	6	t
71	71	FAC-000071	2024-12-01 11:17:49.719509	\N	3	t
72	72	FAC-000072	2025-02-18 19:07:52.269492	\N	2	t
73	73	FAC-000073	2025-01-28 16:49:03.498345	\N	8	t
74	74	FAC-000074	2025-03-28 10:44:01.185891	\N	8	t
75	75	FAC-000075	2025-03-28 20:21:13.511128	\N	4	t
76	76	FAC-000076	2024-11-27 20:18:04.068113	\N	5	t
77	77	FAC-000077	2025-04-21 20:45:37.48267	\N	3	t
78	78	FAC-000078	2024-11-14 21:30:31.454707	\N	8	t
79	79	FAC-000079	2024-08-15 09:02:12.980273	\N	1	t
80	80	FAC-000080	2024-08-03 06:06:11.061152	\N	3	t
81	81	FAC-000081	2024-10-31 09:11:24.222474	\N	10	t
82	82	FAC-000082	2024-11-20 23:00:16.822292	\N	8	t
83	83	FAC-000083	2024-12-08 06:43:34.035926	\N	9	t
84	84	FAC-000084	2025-04-15 10:08:04.057696	\N	8	t
85	85	FAC-000085	2025-01-17 17:40:11.751796	\N	6	t
86	86	FAC-000086	2025-05-21 04:42:08.654658	\N	9	t
87	87	FAC-000087	2024-10-11 04:32:32.308309	\N	2	t
88	88	FAC-000088	2024-12-01 14:38:07.750399	\N	2	t
89	89	FAC-000089	2024-07-11 12:24:52.308748	\N	6	t
90	90	FAC-000090	2025-02-03 01:28:55.435968	\N	3	t
91	91	FAC-000091	2024-11-16 23:40:03.990536	\N	5	t
92	92	FAC-000092	2024-12-28 02:57:41.915086	\N	10	t
93	93	FAC-000093	2025-05-02 01:07:37.829804	\N	8	t
94	94	FAC-000094	2024-10-07 11:41:03.685724	\N	2	t
95	95	FAC-000095	2025-06-10 13:35:59.255167	\N	5	t
96	96	FAC-000096	2025-02-07 14:51:49.458025	\N	4	t
97	97	FAC-000097	2024-06-22 16:01:51.928668	\N	4	t
98	98	FAC-000098	2024-10-19 17:34:32.708914	\N	5	t
99	99	FAC-000099	2025-06-07 09:46:24.881154	\N	4	t
100	100	FAC-000100	2025-01-09 16:42:59.394224	\N	3	t
101	101	FAC-000101	2025-06-08 05:58:56.915714	\N	7	t
102	102	FAC-000102	2024-11-02 20:12:51.709855	\N	2	t
103	103	FAC-000103	2024-10-04 11:18:57.801846	\N	3	t
104	104	FAC-000104	2024-07-10 08:39:25.562199	\N	3	t
105	105	FAC-000105	2025-05-05 08:13:40.636177	\N	1	t
106	106	FAC-000106	2024-06-27 03:53:54.294991	\N	2	t
107	107	FAC-000107	2025-05-22 19:23:30.673326	\N	3	t
108	108	FAC-000108	2024-10-18 22:17:49.986058	\N	9	t
109	109	FAC-000109	2024-07-23 11:36:50.544079	\N	6	t
110	110	FAC-000110	2024-12-22 15:31:50.928486	\N	9	t
111	111	FAC-000111	2025-02-27 03:17:57.385619	\N	5	t
112	112	FAC-000112	2025-05-29 12:25:31.252621	\N	4	t
113	113	FAC-000113	2024-09-07 17:30:10.341387	\N	9	t
114	114	FAC-000114	2024-08-18 13:10:58.915161	\N	7	t
115	115	FAC-000115	2025-03-29 17:37:16.359342	\N	1	t
116	116	FAC-000116	2025-03-24 01:33:08.811424	\N	4	t
117	117	FAC-000117	2024-09-21 21:13:44.178926	\N	8	t
118	118	FAC-000118	2024-11-08 09:28:39.534308	\N	9	t
119	119	FAC-000119	2024-08-19 19:47:24.954631	\N	2	t
120	120	FAC-000120	2025-02-22 09:48:16.047071	\N	9	t
121	121	FAC-000121	2024-10-10 20:51:38.185013	\N	10	t
122	122	FAC-000122	2024-12-05 09:12:14.50805	\N	8	t
123	123	FAC-000123	2024-07-10 17:22:48.653762	\N	8	t
124	124	FAC-000124	2025-03-12 04:28:49.315107	\N	3	t
125	125	FAC-000125	2025-02-13 04:50:47.117042	\N	5	t
126	126	FAC-000126	2024-11-26 05:38:08.742028	\N	8	t
127	127	FAC-000127	2024-06-25 09:18:54.808434	\N	1	t
128	128	FAC-000128	2025-04-09 10:48:42.127627	\N	3	t
129	129	FAC-000129	2024-07-10 14:36:17.028378	\N	6	t
130	130	FAC-000130	2024-07-21 10:31:25.649127	\N	6	t
131	131	FAC-000131	2024-09-15 20:41:29.211508	\N	4	t
132	132	FAC-000132	2025-02-01 19:34:27.566603	\N	7	t
133	133	FAC-000133	2024-12-20 13:25:43.525985	\N	2	t
134	134	FAC-000134	2024-10-11 02:13:45.166173	\N	8	t
135	135	FAC-000135	2024-06-24 02:44:35.126114	\N	2	t
136	136	FAC-000136	2025-01-13 01:01:20.469237	\N	10	t
137	137	FAC-000137	2025-03-11 11:17:24.953732	\N	5	t
138	138	FAC-000138	2024-12-15 01:01:27.212123	\N	9	t
139	139	FAC-000139	2025-04-10 02:03:58.45374	\N	5	t
140	140	FAC-000140	2024-11-08 03:50:05.006368	\N	5	t
141	141	FAC-000141	2025-01-14 10:20:25.080094	\N	7	t
142	142	FAC-000142	2024-11-11 04:48:43.042172	\N	9	t
143	143	FAC-000143	2025-03-27 04:24:16.552493	\N	8	t
144	144	FAC-000144	2024-06-27 13:09:32.109905	\N	9	t
145	145	FAC-000145	2024-11-20 22:22:10.292134	\N	3	t
146	146	FAC-000146	2025-06-08 18:44:43.248257	\N	1	t
147	147	FAC-000147	2024-07-30 05:22:12.312986	\N	8	t
148	148	FAC-000148	2024-08-16 16:42:51.420877	\N	6	t
149	149	FAC-000149	2024-08-29 03:52:28.628484	\N	1	t
150	150	FAC-000150	2025-02-09 21:40:16.639511	\N	3	t
151	151	FAC-000151	2024-08-01 12:03:41.884275	\N	5	t
152	152	FAC-000152	2024-07-05 06:02:52.404961	\N	2	t
153	153	FAC-000153	2024-08-22 21:56:35.023792	\N	5	t
154	154	FAC-000154	2024-08-07 13:28:24.037395	\N	8	t
155	155	FAC-000155	2025-02-27 17:50:04.123343	\N	3	t
156	156	FAC-000156	2024-11-05 15:57:08.420987	\N	9	t
157	157	FAC-000157	2024-10-16 22:01:21.167082	\N	6	t
158	158	FAC-000158	2025-05-06 08:06:22.560916	\N	1	t
159	159	FAC-000159	2024-10-04 04:42:52.884499	\N	1	t
160	160	FAC-000160	2025-06-02 22:52:26.853225	\N	1	t
161	161	FAC-000161	2024-06-22 06:48:36.625867	\N	2	t
162	162	FAC-000162	2025-02-19 06:40:57.725218	\N	2	t
163	163	FAC-000163	2025-04-12 15:20:01.272668	\N	9	t
164	164	FAC-000164	2024-09-19 23:43:16.194872	\N	8	t
165	165	FAC-000165	2024-12-22 03:34:23.632134	\N	9	t
166	166	FAC-000166	2025-05-29 08:59:45.329243	\N	5	t
167	167	FAC-000167	2025-03-16 15:51:03.110279	\N	2	t
168	168	FAC-000168	2025-03-03 00:44:08.770402	\N	8	t
169	169	FAC-000169	2024-10-17 23:22:57.139919	\N	10	t
170	170	FAC-000170	2024-10-07 05:12:03.364991	\N	7	t
171	171	FAC-000171	2024-07-30 20:04:10.454221	\N	8	t
172	172	FAC-000172	2025-05-27 22:27:09.075399	\N	2	t
173	173	FAC-000173	2025-05-07 19:01:02.461161	\N	2	t
174	174	FAC-000174	2024-07-08 11:44:22.609224	\N	3	t
175	175	FAC-000175	2024-08-23 14:54:04.332603	\N	8	t
176	176	FAC-000176	2025-05-25 12:34:52.712164	\N	4	t
177	177	FAC-000177	2025-01-05 02:57:43.864003	\N	1	t
178	178	FAC-000178	2024-08-03 20:56:03.817983	\N	5	t
179	179	FAC-000179	2024-12-28 09:27:33.141259	\N	8	t
180	180	FAC-000180	2025-03-14 14:44:43.115328	\N	9	t
181	181	FAC-000181	2025-01-19 22:27:11.135593	\N	1	t
182	182	FAC-000182	2025-04-21 09:40:24.835541	\N	6	t
183	183	FAC-000183	2025-06-02 08:10:05.884777	\N	3	t
184	184	FAC-000184	2024-11-07 04:41:18.026316	\N	8	t
185	185	FAC-000185	2024-11-19 11:04:58.574533	\N	7	t
186	186	FAC-000186	2025-05-27 22:29:54.80587	\N	4	t
187	187	FAC-000187	2024-09-12 09:00:28.033859	\N	8	t
188	188	FAC-000188	2025-04-03 09:24:26.653493	\N	4	t
189	189	FAC-000189	2025-06-13 16:14:52.393582	\N	2	t
190	190	FAC-000190	2024-10-29 13:57:08.556443	\N	7	t
191	191	FAC-000191	2025-02-01 19:04:17.742236	\N	6	t
192	192	FAC-000192	2025-06-04 18:59:42.696486	\N	8	t
193	193	FAC-000193	2025-06-10 19:46:09.649024	\N	8	t
194	194	FAC-000194	2024-07-10 23:21:08.641878	\N	5	t
195	195	FAC-000195	2025-05-02 06:58:35.607183	\N	1	t
196	196	FAC-000196	2024-12-28 22:42:12.311564	\N	8	t
197	197	FAC-000197	2024-07-08 13:37:26.292084	\N	6	t
198	198	FAC-000198	2024-09-19 06:54:42.661777	\N	3	t
199	199	FAC-000199	2024-06-25 05:07:29.941689	\N	7	t
200	200	FAC-000200	2024-08-09 00:45:36.406473	\N	8	t
201	201	FAC-000201	2025-05-04 02:27:05.380306	\N	4	t
202	202	FAC-000202	2025-01-14 22:55:37.99433	\N	3	t
203	203	FAC-000203	2024-12-15 11:24:17.827269	\N	2	t
204	204	FAC-000204	2024-09-25 16:59:21.47458	\N	5	t
205	205	FAC-000205	2025-01-04 23:46:39.558289	\N	4	t
206	206	FAC-000206	2024-08-17 15:06:26.742452	\N	2	t
207	207	FAC-000207	2024-09-16 15:04:39.574911	\N	4	t
208	208	FAC-000208	2024-06-20 04:40:23.096177	\N	4	t
209	209	FAC-000209	2024-12-19 05:21:45.53193	\N	7	t
210	210	FAC-000210	2024-12-26 22:46:18.802099	\N	7	t
211	211	FAC-000211	2024-10-30 03:34:53.292809	\N	4	t
212	212	FAC-000212	2024-12-08 21:44:18.520615	\N	9	t
213	213	FAC-000213	2024-07-13 02:58:00.166674	\N	10	t
214	214	FAC-000214	2024-08-09 00:19:23.478214	\N	9	t
215	215	FAC-000215	2025-03-25 23:59:26.089749	\N	7	t
216	216	FAC-000216	2025-01-06 11:28:37.65197	\N	2	t
217	217	FAC-000217	2025-04-01 00:26:42.002721	\N	2	t
218	218	FAC-000218	2024-09-17 05:27:20.903079	\N	7	t
219	219	FAC-000219	2024-11-10 20:39:08.492549	\N	6	t
220	220	FAC-000220	2024-12-09 05:13:47.697811	\N	10	t
221	221	FAC-000221	2024-08-06 12:41:34.907822	\N	1	t
222	222	FAC-000222	2024-12-15 00:19:18.736552	\N	8	t
223	223	FAC-000223	2025-05-23 15:11:55.34519	\N	4	t
224	224	FAC-000224	2024-12-20 00:47:31.688788	\N	7	t
225	225	FAC-000225	2024-08-22 10:16:05.07805	\N	4	t
226	226	FAC-000226	2025-02-05 19:11:46.306149	\N	1	t
227	227	FAC-000227	2024-09-16 18:05:02.795048	\N	6	t
228	228	FAC-000228	2024-11-18 20:16:51.515267	\N	1	t
229	229	FAC-000229	2024-10-20 08:23:03.056405	\N	3	t
230	230	FAC-000230	2025-04-04 08:36:48.820269	\N	7	t
231	231	FAC-000231	2024-08-03 07:13:22.119695	\N	10	t
232	232	FAC-000232	2025-03-15 13:39:02.776455	\N	10	t
233	233	FAC-000233	2025-06-01 08:51:48.029413	\N	4	t
234	234	FAC-000234	2024-08-06 12:53:56.666096	\N	6	t
235	235	FAC-000235	2024-11-02 20:03:24.193463	\N	7	t
236	236	FAC-000236	2024-07-05 05:08:15.279798	\N	2	t
237	237	FAC-000237	2024-12-24 09:46:36.6023	\N	9	t
238	238	FAC-000238	2025-03-07 11:50:01.505697	\N	7	t
239	239	FAC-000239	2024-07-18 18:51:41.710221	\N	3	t
240	240	FAC-000240	2025-04-18 02:36:43.359354	\N	1	t
241	241	FAC-000241	2024-09-24 09:13:56.5905	\N	4	t
242	242	FAC-000242	2025-02-08 14:24:44.399331	\N	6	t
243	243	FAC-000243	2025-03-22 17:58:33.096818	\N	9	t
244	244	FAC-000244	2024-07-28 20:33:50.478679	\N	6	t
245	245	FAC-000245	2024-09-17 22:28:36.574908	\N	8	t
246	246	FAC-000246	2025-05-12 18:23:12.315656	\N	9	t
247	247	FAC-000247	2024-07-06 20:14:38.349282	\N	4	t
248	248	FAC-000248	2025-01-19 17:55:22.903342	\N	5	t
249	249	FAC-000249	2025-05-08 19:00:57.767271	\N	8	t
250	250	FAC-000250	2025-02-27 10:30:12.35493	\N	4	t
251	251	FAC-000251	2025-04-17 10:25:18.781479	\N	9	t
252	252	FAC-000252	2024-12-06 01:07:50.390422	\N	1	t
253	253	FAC-000253	2025-05-10 02:42:12.122837	\N	5	t
254	254	FAC-000254	2024-08-15 11:37:21.202322	\N	6	t
255	255	FAC-000255	2025-05-06 05:13:10.493817	\N	7	t
256	256	FAC-000256	2025-01-02 06:59:26.136857	\N	8	t
257	257	FAC-000257	2024-10-15 09:30:38.326024	\N	4	t
258	258	FAC-000258	2024-10-08 16:54:10.993358	\N	8	t
259	259	FAC-000259	2025-03-10 21:56:11.512755	\N	3	t
260	260	FAC-000260	2025-01-11 00:06:52.999171	\N	1	t
261	261	FAC-000261	2025-01-13 20:10:00.317767	\N	10	t
262	262	FAC-000262	2025-02-20 00:27:28.022376	\N	4	t
263	263	FAC-000263	2025-03-17 01:44:54.551534	\N	7	t
264	264	FAC-000264	2025-02-12 19:49:23.42701	\N	3	t
265	265	FAC-000265	2024-09-19 05:44:40.818518	\N	4	t
266	266	FAC-000266	2024-12-18 11:43:49.956443	\N	7	t
267	267	FAC-000267	2024-12-31 02:10:42.952456	\N	9	t
268	268	FAC-000268	2025-02-11 10:06:10.496953	\N	3	t
269	269	FAC-000269	2025-05-17 04:56:29.514645	\N	4	t
270	270	FAC-000270	2025-03-12 19:10:04.476437	\N	7	t
271	271	FAC-000271	2024-07-11 10:46:59.78503	\N	8	t
272	272	FAC-000272	2025-05-14 17:24:29.188613	\N	6	t
273	273	FAC-000273	2024-11-27 01:13:17.795406	\N	6	t
274	274	FAC-000274	2024-08-16 22:01:26.267453	\N	9	t
275	275	FAC-000275	2025-02-27 09:44:23.469252	\N	2	t
276	276	FAC-000276	2025-02-07 21:55:20.84371	\N	7	t
277	277	FAC-000277	2025-02-28 14:20:07.465663	\N	1	t
278	278	FAC-000278	2024-12-22 15:26:10.294068	\N	4	t
279	279	FAC-000279	2025-01-12 07:29:17.05373	\N	7	t
280	280	FAC-000280	2024-07-21 16:59:09.671926	\N	1	t
281	281	FAC-000281	2025-01-05 10:26:48.872544	\N	9	t
282	282	FAC-000282	2025-03-15 01:31:27.530514	\N	7	t
283	283	FAC-000283	2024-10-26 00:56:31.580408	\N	9	t
284	284	FAC-000284	2024-08-19 16:12:31.662164	\N	9	t
285	285	FAC-000285	2024-08-02 21:10:30.295159	\N	3	t
286	286	FAC-000286	2025-05-23 16:44:01.81562	\N	5	t
287	287	FAC-000287	2024-07-08 00:20:47.450865	\N	9	t
288	288	FAC-000288	2024-08-03 22:02:56.982838	\N	9	t
289	289	FAC-000289	2024-07-09 01:24:19.875325	\N	6	t
290	290	FAC-000290	2024-12-13 08:49:28.261706	\N	9	t
291	291	FAC-000291	2024-12-01 03:48:46.812144	\N	4	t
292	292	FAC-000292	2024-11-14 09:49:04.726954	\N	6	t
293	293	FAC-000293	2024-07-25 10:18:38.930085	\N	10	t
294	294	FAC-000294	2024-11-15 03:43:16.736719	\N	5	t
295	295	FAC-000295	2024-09-01 14:58:26.157828	\N	6	t
296	296	FAC-000296	2024-11-12 09:56:42.082897	\N	9	t
297	297	FAC-000297	2024-08-04 16:53:43.328025	\N	3	t
298	298	FAC-000298	2024-12-28 05:43:53.190824	\N	6	t
299	299	FAC-000299	2025-02-02 04:49:50.963233	\N	7	t
300	300	FAC-000300	2024-09-27 13:27:06.578663	\N	9	t
301	301	FAC-000301	2024-11-04 15:52:31.405077	\N	5	t
302	302	FAC-000302	2024-10-19 07:41:25.545334	\N	5	t
303	303	FAC-000303	2025-05-12 05:26:18.884905	\N	7	t
304	304	FAC-000304	2025-01-14 08:10:17.992268	\N	7	t
305	305	FAC-000305	2025-01-24 16:42:15.238683	\N	1	t
306	306	FAC-000306	2025-02-20 22:32:10.054534	\N	7	t
307	307	FAC-000307	2025-05-15 07:41:34.730901	\N	2	t
308	308	FAC-000308	2024-10-19 00:46:41.037727	\N	7	t
309	309	FAC-000309	2024-08-19 11:43:50.359468	\N	5	t
310	310	FAC-000310	2024-08-26 01:02:42.87603	\N	4	t
311	311	FAC-000311	2024-11-23 22:16:46.203345	\N	4	t
312	312	FAC-000312	2025-01-07 19:57:46.89449	\N	6	t
313	313	FAC-000313	2024-12-29 14:45:14.41455	\N	3	t
314	314	FAC-000314	2024-09-20 15:43:29.632694	\N	6	t
315	315	FAC-000315	2024-12-15 00:55:41.202223	\N	9	t
316	316	FAC-000316	2024-09-10 18:36:46.147356	\N	5	t
317	317	FAC-000317	2024-07-17 20:27:23.966388	\N	2	t
318	318	FAC-000318	2025-01-31 14:13:48.645505	\N	9	t
319	319	FAC-000319	2025-03-18 14:28:46.440953	\N	2	t
320	320	FAC-000320	2024-10-03 17:06:43.393289	\N	2	t
321	321	FAC-000321	2025-05-23 20:35:17.722371	\N	8	t
322	322	FAC-000322	2025-04-19 12:28:23.046761	\N	7	t
323	323	FAC-000323	2025-04-12 21:35:26.107591	\N	7	t
324	324	FAC-000324	2025-01-22 11:21:07.667168	\N	3	t
325	325	FAC-000325	2024-10-24 11:51:02.565824	\N	9	t
326	326	FAC-000326	2025-02-23 18:40:22.976042	\N	7	t
327	327	FAC-000327	2024-10-19 02:04:08.666164	\N	4	t
328	328	FAC-000328	2024-07-08 11:28:52.03979	\N	7	t
329	329	FAC-000329	2024-06-29 10:49:04.63924	\N	3	t
330	330	FAC-000330	2024-06-17 18:17:39.887064	\N	6	t
331	331	FAC-000331	2025-03-19 17:35:02.472688	\N	10	t
332	332	FAC-000332	2024-07-15 23:14:45.394591	\N	7	t
333	333	FAC-000333	2025-05-08 18:21:17.9597	\N	3	t
334	334	FAC-000334	2025-06-07 21:22:49.1857	\N	6	t
335	335	FAC-000335	2025-02-20 07:59:06.880985	\N	3	t
336	336	FAC-000336	2025-05-24 07:48:41.465381	\N	1	t
337	337	FAC-000337	2024-10-23 03:50:00.884953	\N	2	t
338	338	FAC-000338	2025-04-12 20:51:25.410246	\N	2	t
339	339	FAC-000339	2024-10-18 08:20:14.459883	\N	6	t
340	340	FAC-000340	2024-07-29 10:41:01.850345	\N	6	t
341	341	FAC-000341	2025-04-02 20:14:58.265653	\N	10	t
342	342	FAC-000342	2025-04-12 21:06:22.495846	\N	3	t
343	343	FAC-000343	2025-03-24 14:15:57.158203	\N	6	t
344	344	FAC-000344	2024-07-09 16:45:53.8324	\N	5	t
345	345	FAC-000345	2024-07-18 01:58:57.49504	\N	5	t
346	346	FAC-000346	2024-12-09 23:22:48.735615	\N	7	t
347	347	FAC-000347	2024-11-30 18:39:23.277732	\N	9	t
348	348	FAC-000348	2024-07-29 04:20:43.015296	\N	1	t
349	349	FAC-000349	2025-01-06 08:27:50.183847	\N	6	t
350	350	FAC-000350	2024-08-24 02:09:30.976879	\N	3	t
351	351	FAC-000351	2025-05-22 09:58:50.629136	\N	9	t
352	352	FAC-000352	2024-08-04 07:13:55.686974	\N	3	t
353	353	FAC-000353	2025-04-01 01:25:21.105092	\N	2	t
354	354	FAC-000354	2024-12-02 23:55:06.16551	\N	6	t
355	355	FAC-000355	2024-11-03 04:14:33.365246	\N	7	t
356	356	FAC-000356	2024-10-27 05:25:33.840627	\N	9	t
357	357	FAC-000357	2025-03-16 01:30:03.531267	\N	8	t
358	358	FAC-000358	2024-11-23 10:31:45.360889	\N	8	t
359	359	FAC-000359	2024-08-19 00:10:42.004516	\N	7	t
360	360	FAC-000360	2024-09-22 03:30:41.005469	\N	2	t
361	361	FAC-000361	2024-06-15 04:21:27.590976	\N	8	t
362	362	FAC-000362	2025-01-25 17:56:51.196333	\N	5	t
363	363	FAC-000363	2024-11-22 00:41:27.423931	\N	5	t
364	364	FAC-000364	2024-10-30 19:54:05.505961	\N	6	t
365	365	FAC-000365	2024-08-13 15:01:44.334384	\N	4	t
366	366	FAC-000366	2025-03-31 15:01:37.992485	\N	10	t
367	367	FAC-000367	2025-04-09 17:03:10.710455	\N	4	t
368	368	FAC-000368	2024-08-04 06:08:06.221688	\N	7	t
369	369	FAC-000369	2025-02-17 02:24:01.521278	\N	4	t
370	370	FAC-000370	2024-11-16 21:05:03.537456	\N	8	t
371	371	FAC-000371	2025-03-06 15:11:41.679933	\N	2	t
372	372	FAC-000372	2025-05-01 01:47:19.564812	\N	6	t
373	373	FAC-000373	2024-07-29 23:39:21.436157	\N	2	t
374	374	FAC-000374	2025-06-08 05:21:15.658701	\N	8	t
375	375	FAC-000375	2024-09-24 16:57:40.457254	\N	8	t
376	376	FAC-000376	2025-02-10 12:43:19.142094	\N	3	t
377	377	FAC-000377	2025-05-24 11:37:28.804801	\N	6	t
378	378	FAC-000378	2025-01-12 10:39:30.499069	\N	8	t
379	379	FAC-000379	2025-05-02 20:59:39.277236	\N	9	t
380	380	FAC-000380	2024-09-09 17:01:13.472663	\N	3	t
381	381	FAC-000381	2025-04-16 13:18:25.671268	\N	8	t
382	382	FAC-000382	2024-10-09 21:20:17.478711	\N	9	t
383	383	FAC-000383	2025-01-10 00:13:42.302845	\N	8	t
384	384	FAC-000384	2024-12-24 12:25:42.229758	\N	6	t
385	385	FAC-000385	2025-05-06 15:45:10.794467	\N	5	t
386	386	FAC-000386	2025-01-02 14:41:08.865974	\N	2	t
387	387	FAC-000387	2024-10-26 21:56:53.178081	\N	2	t
388	388	FAC-000388	2024-11-21 04:59:06.060783	\N	5	t
389	389	FAC-000389	2025-02-22 11:01:22.44974	\N	9	t
390	390	FAC-000390	2024-12-11 06:30:09.069002	\N	7	t
391	391	FAC-000391	2025-05-17 04:49:15.513067	\N	2	t
392	392	FAC-000392	2025-06-05 18:43:00.892966	\N	7	t
393	393	FAC-000393	2025-06-04 03:30:10.069902	\N	5	t
394	394	FAC-000394	2025-04-19 22:48:07.67426	\N	10	t
395	395	FAC-000395	2024-10-29 21:06:10.788855	\N	5	t
396	396	FAC-000396	2024-09-14 05:35:49.066823	\N	6	t
397	397	FAC-000397	2025-03-29 07:43:15.037904	\N	2	t
398	398	FAC-000398	2024-07-29 07:45:28.457788	\N	2	t
399	399	FAC-000399	2024-07-13 04:15:38.919317	\N	9	t
400	400	FAC-000400	2024-11-05 01:11:22.960719	\N	3	t
401	401	FAC-000401	2024-07-06 21:47:11.61699	\N	4	t
402	402	FAC-000402	2024-09-17 12:54:00.471344	\N	10	t
403	403	FAC-000403	2025-01-26 14:37:13.743749	\N	8	t
404	404	FAC-000404	2024-09-11 00:48:07.275218	\N	4	t
405	405	FAC-000405	2025-01-14 16:10:07.094017	\N	4	t
406	406	FAC-000406	2024-12-05 20:24:38.175715	\N	4	t
407	407	FAC-000407	2024-12-27 17:13:29.53636	\N	4	t
408	408	FAC-000408	2025-01-23 06:44:06.781574	\N	5	t
409	409	FAC-000409	2025-04-15 12:56:17.839316	\N	8	t
410	410	FAC-000410	2024-12-10 11:55:44.231523	\N	4	t
411	411	FAC-000411	2024-12-07 05:35:24.757919	\N	2	t
412	412	FAC-000412	2024-09-29 09:23:24.369469	\N	2	t
413	413	FAC-000413	2024-11-05 11:57:39.872113	\N	3	t
414	414	FAC-000414	2024-09-10 21:00:20.747576	\N	1	t
415	415	FAC-000415	2024-12-06 01:58:38.634878	\N	6	t
416	416	FAC-000416	2025-02-06 10:26:10.399138	\N	4	t
417	417	FAC-000417	2024-09-21 07:42:06.465365	\N	4	t
418	418	FAC-000418	2024-10-10 03:08:14.084892	\N	7	t
419	419	FAC-000419	2024-12-04 21:30:19.833446	\N	3	t
420	420	FAC-000420	2024-10-19 17:42:33.055173	\N	4	t
421	421	FAC-000421	2024-08-04 22:01:59.445788	\N	7	t
422	422	FAC-000422	2025-05-30 13:11:05.060605	\N	4	t
423	423	FAC-000423	2024-07-12 07:21:46.537923	\N	2	t
424	424	FAC-000424	2025-02-20 08:46:21.646991	\N	4	t
425	425	FAC-000425	2025-02-01 01:53:46.971347	\N	7	t
426	426	FAC-000426	2025-03-16 15:32:11.705786	\N	9	t
427	427	FAC-000427	2025-01-07 08:40:39.612624	\N	3	t
428	428	FAC-000428	2024-07-10 08:15:45.659471	\N	4	t
429	429	FAC-000429	2024-09-23 18:14:37.507033	\N	7	t
430	430	FAC-000430	2024-09-14 00:00:16.950284	\N	4	t
431	431	FAC-000431	2025-01-05 14:48:21.903902	\N	9	t
432	432	FAC-000432	2024-12-07 00:51:16.320039	\N	8	t
433	433	FAC-000433	2025-04-17 15:41:23.10086	\N	3	t
434	434	FAC-000434	2024-06-28 01:48:36.575047	\N	9	t
435	435	FAC-000435	2025-04-04 07:03:46.779366	\N	8	t
436	436	FAC-000436	2024-10-16 05:26:09.728798	\N	1	t
437	437	FAC-000437	2025-04-25 12:11:35.590435	\N	3	t
438	438	FAC-000438	2024-06-24 15:42:31.360195	\N	6	t
439	439	FAC-000439	2025-05-10 12:24:48.666901	\N	6	t
440	440	FAC-000440	2024-12-30 20:19:35.826663	\N	9	t
441	441	FAC-000441	2024-11-28 03:59:26.795702	\N	6	t
442	442	FAC-000442	2024-06-14 02:47:27.070535	\N	5	t
443	443	FAC-000443	2025-03-21 21:30:51.774943	\N	6	t
444	444	FAC-000444	2025-05-18 09:23:15.473387	\N	7	t
445	445	FAC-000445	2025-04-15 23:02:33.349654	\N	4	t
446	446	FAC-000446	2024-09-24 10:58:12.974964	\N	9	t
447	447	FAC-000447	2025-02-16 03:18:18.783227	\N	6	t
448	448	FAC-000448	2025-06-06 06:37:24.415272	\N	8	t
449	449	FAC-000449	2024-09-06 22:22:57.598698	\N	4	t
450	450	FAC-000450	2025-03-12 04:44:15.494469	\N	6	t
451	451	FAC-000451	2024-12-02 19:45:40.123173	\N	9	t
452	452	FAC-000452	2024-09-30 13:49:58.991668	\N	8	t
453	453	FAC-000453	2024-09-11 08:35:50.540735	\N	5	t
454	454	FAC-000454	2025-02-23 14:40:05.462208	\N	9	t
455	455	FAC-000455	2024-12-08 19:30:21.597241	\N	4	t
456	456	FAC-000456	2024-10-08 09:46:57.642949	\N	2	t
457	457	FAC-000457	2025-02-04 12:25:56.13271	\N	1	t
458	458	FAC-000458	2024-07-27 18:22:18.28396	\N	3	t
459	459	FAC-000459	2024-12-28 09:19:08.777883	\N	8	t
460	460	FAC-000460	2024-08-15 05:35:47.819194	\N	3	t
461	461	FAC-000461	2025-04-21 05:37:39.808657	\N	8	t
462	462	FAC-000462	2024-09-03 02:47:30.492729	\N	8	t
463	463	FAC-000463	2024-11-21 16:58:07.15825	\N	6	t
464	464	FAC-000464	2025-03-03 02:56:19.576924	\N	6	t
465	465	FAC-000465	2025-01-20 21:33:57.722358	\N	10	t
466	466	FAC-000466	2024-11-15 23:51:21.950763	\N	7	t
467	467	FAC-000467	2024-07-28 01:26:18.476607	\N	9	t
468	468	FAC-000468	2024-09-14 04:46:18.742159	\N	2	t
469	469	FAC-000469	2024-10-31 04:48:14.044486	\N	3	t
470	470	FAC-000470	2025-01-07 18:54:01.707041	\N	6	t
471	471	FAC-000471	2024-07-15 07:39:48.882539	\N	9	t
472	472	FAC-000472	2025-01-07 15:45:58.001711	\N	10	t
473	473	FAC-000473	2025-05-14 20:59:53.161336	\N	9	t
474	474	FAC-000474	2024-12-29 23:52:44.511521	\N	5	t
475	475	FAC-000475	2025-03-23 12:56:15.284416	\N	8	t
476	476	FAC-000476	2024-10-20 11:19:56.800343	\N	10	t
477	477	FAC-000477	2024-08-07 10:09:57.92629	\N	10	t
478	478	FAC-000478	2024-11-30 05:38:37.918097	\N	4	t
479	479	FAC-000479	2024-12-05 10:07:50.229252	\N	4	t
480	480	FAC-000480	2025-04-15 02:51:47.769014	\N	6	t
481	481	FAC-000481	2025-04-08 08:34:25.835245	\N	5	t
482	482	FAC-000482	2024-11-29 15:14:36.02839	\N	5	t
483	483	FAC-000483	2024-06-27 10:51:49.797845	\N	6	t
484	484	FAC-000484	2025-01-01 02:20:26.64526	\N	1	t
485	485	FAC-000485	2024-08-11 09:29:59.813243	\N	5	t
486	486	FAC-000486	2025-06-10 04:38:38.304246	\N	10	t
487	487	FAC-000487	2024-11-10 16:59:54.690964	\N	7	t
488	488	FAC-000488	2024-09-14 07:26:00.360024	\N	10	t
489	489	FAC-000489	2024-09-28 23:11:44.67223	\N	6	t
490	490	FAC-000490	2024-11-04 11:08:46.683016	\N	6	t
491	491	FAC-000491	2025-04-19 04:15:04.380744	\N	6	t
492	492	FAC-000492	2025-02-13 05:16:29.977869	\N	7	t
493	493	FAC-000493	2025-05-25 21:23:32.283074	\N	8	t
494	494	FAC-000494	2024-07-02 17:10:34.491805	\N	5	t
495	495	FAC-000495	2024-07-30 01:23:10.253051	\N	1	t
496	496	FAC-000496	2024-07-29 21:27:18.286868	\N	4	t
497	497	FAC-000497	2024-11-09 13:20:31.502211	\N	3	t
498	498	FAC-000498	2024-07-22 20:49:06.580043	\N	8	t
499	499	FAC-000499	2025-01-28 13:08:17.682113	\N	8	t
500	500	FAC-000500	2024-12-16 15:50:35.591933	\N	9	t
501	501	FAC-000501	2025-04-17 10:07:29.889492	\N	2	t
502	502	FAC-000502	2024-07-04 00:09:19.378701	\N	2	t
503	503	FAC-000503	2024-10-02 06:36:44.38881	\N	4	t
504	504	FAC-000504	2025-01-10 16:25:08.698888	\N	2	t
505	505	FAC-000505	2024-12-16 21:12:35.058677	\N	10	t
506	506	FAC-000506	2025-05-08 19:20:19.227598	\N	8	t
507	507	FAC-000507	2024-12-28 15:43:32.123155	\N	4	t
508	508	FAC-000508	2025-03-04 02:17:38.529995	\N	8	t
509	509	FAC-000509	2024-07-29 10:42:10.625621	\N	5	t
510	510	FAC-000510	2024-11-14 22:36:42.531075	\N	5	t
511	511	FAC-000511	2025-02-19 11:06:37.184834	\N	3	t
512	512	FAC-000512	2025-04-08 11:11:25.371081	\N	3	t
513	513	FAC-000513	2024-10-20 22:46:31.628925	\N	1	t
514	514	FAC-000514	2025-02-22 22:34:45.576354	\N	5	t
515	515	FAC-000515	2024-08-25 21:56:32.707864	\N	7	t
516	516	FAC-000516	2024-07-20 01:45:27.923021	\N	7	t
517	517	FAC-000517	2025-03-15 09:37:51.834054	\N	7	t
518	518	FAC-000518	2025-03-20 22:20:27.185845	\N	5	t
519	519	FAC-000519	2025-02-05 15:26:43.959187	\N	8	t
520	520	FAC-000520	2024-09-27 10:55:49.161172	\N	4	t
521	521	FAC-000521	2025-01-09 00:21:52.833971	\N	4	t
522	522	FAC-000522	2024-12-22 09:41:55.695006	\N	2	t
523	523	FAC-000523	2024-07-03 07:03:46.515686	\N	8	t
524	524	FAC-000524	2024-07-25 00:32:57.834306	\N	1	t
525	525	FAC-000525	2025-02-21 09:32:33.75986	\N	5	t
526	526	FAC-000526	2024-11-21 00:00:28.5054	\N	8	t
527	527	FAC-000527	2025-05-23 20:34:44.812775	\N	3	t
528	528	FAC-000528	2024-07-07 18:40:50.229362	\N	6	t
529	529	FAC-000529	2024-06-30 07:22:19.504167	\N	5	t
530	530	FAC-000530	2024-10-12 20:54:36.401408	\N	9	t
531	531	FAC-000531	2025-03-26 17:47:52.761853	\N	9	t
532	532	FAC-000532	2025-01-16 14:54:32.576618	\N	2	t
533	533	FAC-000533	2024-06-25 18:22:46.573253	\N	9	t
534	534	FAC-000534	2025-04-16 12:46:00.007647	\N	3	t
535	535	FAC-000535	2024-07-15 17:51:10.997291	\N	8	t
536	536	FAC-000536	2025-01-22 07:25:46.192746	\N	9	t
537	537	FAC-000537	2025-05-16 01:21:42.012592	\N	3	t
538	538	FAC-000538	2025-03-26 22:35:09.417855	\N	10	t
539	539	FAC-000539	2024-10-10 04:34:34.792045	\N	2	t
540	540	FAC-000540	2024-08-31 17:13:03.809121	\N	4	t
541	541	FAC-000541	2024-10-16 17:02:22.966778	\N	8	t
542	542	FAC-000542	2024-08-23 16:31:24.660763	\N	2	t
543	543	FAC-000543	2024-11-24 06:14:24.415552	\N	7	t
544	544	FAC-000544	2024-12-15 02:56:02.969336	\N	3	t
545	545	FAC-000545	2024-11-14 00:00:18.237262	\N	6	t
546	546	FAC-000546	2024-11-09 16:28:20.494662	\N	7	t
547	547	FAC-000547	2024-10-04 04:05:46.768001	\N	3	t
548	548	FAC-000548	2024-10-29 23:12:57.391325	\N	1	t
549	549	FAC-000549	2025-02-28 12:11:57.873677	\N	2	t
550	550	FAC-000550	2025-02-10 13:32:46.511732	\N	10	t
551	551	FAC-000551	2024-10-07 02:44:54.221681	\N	8	t
552	552	FAC-000552	2025-06-02 22:29:38.551416	\N	8	t
553	553	FAC-000553	2025-04-17 01:15:58.984036	\N	8	t
554	554	FAC-000554	2025-06-12 14:31:48.29327	\N	3	t
555	555	FAC-000555	2024-11-25 19:20:49.699118	\N	4	t
556	556	FAC-000556	2025-01-07 12:49:28.020685	\N	8	t
557	557	FAC-000557	2025-05-05 13:12:54.294466	\N	4	t
558	558	FAC-000558	2024-11-15 03:53:43.150329	\N	8	t
559	559	FAC-000559	2024-09-01 18:53:03.769342	\N	5	t
560	560	FAC-000560	2024-06-16 08:27:41.199109	\N	5	t
561	561	FAC-000561	2025-06-01 16:34:12.783292	\N	2	t
562	562	FAC-000562	2025-03-09 09:50:51.906752	\N	4	t
563	563	FAC-000563	2024-10-11 01:14:09.506612	\N	7	t
564	564	FAC-000564	2024-09-12 02:47:25.794446	\N	1	t
565	565	FAC-000565	2024-07-08 02:30:10.134787	\N	9	t
566	566	FAC-000566	2024-07-28 04:24:00.140889	\N	8	t
567	567	FAC-000567	2024-11-02 23:03:13.159037	\N	3	t
568	568	FAC-000568	2024-08-19 15:25:11.963855	\N	7	t
569	569	FAC-000569	2025-05-30 17:16:26.944897	\N	4	t
570	570	FAC-000570	2024-08-26 09:59:27.177435	\N	6	t
571	571	FAC-000571	2025-03-09 09:59:32.996636	\N	3	t
572	572	FAC-000572	2024-12-12 09:53:46.095513	\N	3	t
573	573	FAC-000573	2025-01-10 11:27:45.682774	\N	4	t
574	574	FAC-000574	2024-12-03 23:05:12.182035	\N	9	t
575	575	FAC-000575	2025-02-04 12:44:40.688613	\N	4	t
576	576	FAC-000576	2024-08-21 21:48:01.133582	\N	6	t
577	577	FAC-000577	2025-01-25 20:05:33.21563	\N	5	t
578	578	FAC-000578	2024-11-20 06:05:38.692007	\N	8	t
579	579	FAC-000579	2025-03-27 03:32:33.975925	\N	8	t
580	580	FAC-000580	2025-02-25 13:15:53.512989	\N	5	t
581	581	FAC-000581	2025-02-01 13:25:28.754245	\N	10	t
582	582	FAC-000582	2025-06-01 15:57:06.679725	\N	3	t
583	583	FAC-000583	2024-07-09 18:27:58.274045	\N	4	t
584	584	FAC-000584	2024-12-04 21:42:42.728073	\N	1	t
585	585	FAC-000585	2024-08-24 11:21:29.755666	\N	5	t
586	586	FAC-000586	2025-03-28 20:55:59.703279	\N	1	t
587	587	FAC-000587	2025-04-14 04:29:27.675426	\N	2	t
588	588	FAC-000588	2025-03-08 21:52:59.719729	\N	8	t
589	589	FAC-000589	2024-09-27 14:34:12.220326	\N	2	t
590	590	FAC-000590	2024-08-15 13:02:48.135016	\N	1	t
591	591	FAC-000591	2024-11-24 04:39:28.239129	\N	1	t
592	592	FAC-000592	2025-02-27 12:34:51.710067	\N	3	t
593	593	FAC-000593	2024-09-18 14:58:55.118626	\N	9	t
594	594	FAC-000594	2024-06-23 03:07:26.853197	\N	2	t
595	595	FAC-000595	2024-07-13 17:49:23.881537	\N	5	t
596	596	FAC-000596	2025-01-07 11:02:58.018933	\N	5	t
597	597	FAC-000597	2024-09-02 21:22:38.195006	\N	8	t
598	598	FAC-000598	2024-07-16 03:07:53.765865	\N	6	t
599	599	FAC-000599	2025-03-11 14:12:46.065599	\N	5	t
600	600	FAC-000600	2025-03-30 21:07:03.662513	\N	7	t
601	601	FAC-000601	2025-02-26 04:17:38.522959	\N	8	t
602	602	FAC-000602	2024-06-18 18:08:01.213716	\N	6	t
603	603	FAC-000603	2025-01-01 07:50:28.187526	\N	7	t
604	604	FAC-000604	2024-11-08 20:44:39.914646	\N	2	t
605	605	FAC-000605	2025-01-22 09:28:20.292808	\N	5	t
606	606	FAC-000606	2024-06-18 08:54:47.658245	\N	5	t
607	607	FAC-000607	2024-07-09 04:58:58.72225	\N	10	t
608	608	FAC-000608	2024-12-12 13:31:25.649164	\N	1	t
609	609	FAC-000609	2024-11-14 04:08:27.571045	\N	9	t
610	610	FAC-000610	2025-02-18 18:18:11.484787	\N	7	t
611	611	FAC-000611	2025-01-11 08:56:48.685019	\N	2	t
612	612	FAC-000612	2025-05-09 11:13:27.555028	\N	7	t
613	613	FAC-000613	2024-07-01 16:33:54.925746	\N	7	t
614	614	FAC-000614	2025-01-30 12:48:57.549487	\N	4	t
615	615	FAC-000615	2024-10-23 04:48:44.523155	\N	7	t
616	616	FAC-000616	2024-11-09 17:27:00.270486	\N	2	t
617	617	FAC-000617	2024-12-02 12:57:58.151959	\N	10	t
618	618	FAC-000618	2025-01-23 19:21:36.277656	\N	8	t
619	619	FAC-000619	2025-04-05 16:05:29.295319	\N	8	t
620	620	FAC-000620	2024-11-27 09:15:10.361566	\N	6	t
621	621	FAC-000621	2025-05-25 12:47:03.998601	\N	9	t
622	622	FAC-000622	2025-05-28 22:42:59.050896	\N	7	t
623	623	FAC-000623	2024-07-08 16:57:55.178516	\N	6	t
624	624	FAC-000624	2025-05-31 10:19:18.138349	\N	5	t
625	625	FAC-000625	2025-02-01 02:43:15.542052	\N	10	t
626	626	FAC-000626	2025-03-22 12:34:59.629764	\N	6	t
627	627	FAC-000627	2024-07-24 22:12:13.500637	\N	10	t
628	628	FAC-000628	2024-09-29 08:58:48.057858	\N	6	t
629	629	FAC-000629	2024-12-21 12:56:02.502908	\N	1	t
630	630	FAC-000630	2024-10-03 15:33:18.58379	\N	3	t
631	631	FAC-000631	2024-06-22 09:42:45.749853	\N	6	t
632	632	FAC-000632	2025-01-08 02:50:51.050083	\N	7	t
633	633	FAC-000633	2024-12-18 22:26:10.709754	\N	7	t
634	634	FAC-000634	2024-09-28 02:21:48.869064	\N	2	t
635	635	FAC-000635	2024-12-18 22:41:50.48512	\N	9	t
636	636	FAC-000636	2025-02-19 22:13:50.087829	\N	5	t
637	637	FAC-000637	2024-10-19 13:21:01.743298	\N	3	t
638	638	FAC-000638	2025-03-02 01:07:08.954593	\N	4	t
639	639	FAC-000639	2024-09-23 09:57:13.777768	\N	7	t
640	640	FAC-000640	2025-05-07 13:46:21.368042	\N	5	t
641	641	FAC-000641	2024-06-24 16:10:40.97823	\N	2	t
642	642	FAC-000642	2024-12-11 02:17:23.285993	\N	4	t
643	643	FAC-000643	2025-01-27 09:13:39.241469	\N	7	t
644	644	FAC-000644	2024-08-02 12:01:24.279936	\N	8	t
645	645	FAC-000645	2024-08-18 17:14:32.907696	\N	3	t
646	646	FAC-000646	2024-10-05 07:02:25.944674	\N	4	t
647	647	FAC-000647	2025-06-07 22:55:37.149245	\N	6	t
648	648	FAC-000648	2024-12-14 18:27:19.145245	\N	2	t
649	649	FAC-000649	2025-01-31 09:08:47.081785	\N	7	t
650	650	FAC-000650	2024-09-30 20:54:17.383158	\N	4	t
651	651	FAC-000651	2025-01-06 06:18:22.245596	\N	8	t
652	652	FAC-000652	2025-01-09 03:14:46.469475	\N	5	t
653	653	FAC-000653	2024-08-25 20:49:03.576056	\N	3	t
654	654	FAC-000654	2024-07-13 09:22:52.722592	\N	3	t
655	655	FAC-000655	2024-09-03 18:40:24.658545	\N	5	t
656	656	FAC-000656	2024-09-18 03:24:02.421424	\N	6	t
657	657	FAC-000657	2024-11-29 02:49:50.583703	\N	6	t
658	658	FAC-000658	2024-09-28 11:26:24.386166	\N	6	t
659	659	FAC-000659	2024-11-29 05:04:22.860628	\N	5	t
660	660	FAC-000660	2025-04-17 19:52:23.754699	\N	4	t
661	661	FAC-000661	2024-09-01 02:45:10.403143	\N	9	t
662	662	FAC-000662	2025-03-10 01:09:30.223826	\N	4	t
663	663	FAC-000663	2025-03-25 23:57:17.226302	\N	2	t
664	664	FAC-000664	2024-08-31 01:10:34.180341	\N	5	t
665	665	FAC-000665	2025-03-02 04:48:21.159341	\N	5	t
666	666	FAC-000666	2025-04-29 15:18:07.597908	\N	6	t
667	667	FAC-000667	2025-06-02 12:43:00.462415	\N	9	t
668	668	FAC-000668	2024-11-28 22:00:16.510878	\N	3	t
669	669	FAC-000669	2025-04-21 14:25:43.605053	\N	5	t
670	670	FAC-000670	2025-05-23 03:03:40.001219	\N	7	t
671	671	FAC-000671	2025-05-14 08:19:10.995025	\N	9	t
672	672	FAC-000672	2025-05-03 19:03:44.161285	\N	3	t
673	673	FAC-000673	2024-11-06 07:50:24.64322	\N	5	t
674	674	FAC-000674	2024-09-11 01:32:50.510007	\N	3	t
675	675	FAC-000675	2024-09-06 16:38:33.587967	\N	5	t
676	676	FAC-000676	2024-11-11 06:13:48.232411	\N	8	t
677	677	FAC-000677	2024-09-28 08:20:35.382602	\N	2	t
678	678	FAC-000678	2024-06-14 19:19:02.348498	\N	9	t
679	679	FAC-000679	2024-12-13 02:28:47.050435	\N	10	t
680	680	FAC-000680	2025-02-20 08:09:02.175717	\N	7	t
681	681	FAC-000681	2025-05-03 16:30:44.262211	\N	9	t
682	682	FAC-000682	2025-06-04 05:17:32.869613	\N	3	t
683	683	FAC-000683	2024-10-01 05:00:49.039948	\N	8	t
684	684	FAC-000684	2024-09-28 14:46:27.528543	\N	3	t
685	685	FAC-000685	2025-01-12 21:43:35.165477	\N	8	t
686	686	FAC-000686	2025-05-23 05:00:20.914175	\N	3	t
687	687	FAC-000687	2025-01-03 05:54:23.722126	\N	9	t
688	688	FAC-000688	2024-10-23 02:13:25.779817	\N	4	t
689	689	FAC-000689	2024-10-21 07:59:53.204974	\N	6	t
690	690	FAC-000690	2025-02-04 00:39:59.902258	\N	5	t
691	691	FAC-000691	2024-12-14 04:03:37.695589	\N	8	t
692	692	FAC-000692	2025-03-11 01:36:26.725792	\N	3	t
693	693	FAC-000693	2025-01-23 21:49:14.28235	\N	2	t
694	694	FAC-000694	2024-11-21 04:12:22.355112	\N	1	t
695	695	FAC-000695	2025-02-11 11:45:00.562109	\N	2	t
696	696	FAC-000696	2024-11-30 01:40:32.911417	\N	8	t
697	697	FAC-000697	2024-10-06 00:45:46.291186	\N	7	t
698	698	FAC-000698	2025-03-26 07:36:22.699265	\N	6	t
699	699	FAC-000699	2024-11-28 05:25:32.832257	\N	4	t
700	700	FAC-000700	2025-02-07 07:39:46.436154	\N	6	t
701	701	FAC-000701	2024-08-05 20:24:34.702874	\N	9	t
702	702	FAC-000702	2024-07-18 23:59:17.090835	\N	5	t
703	703	FAC-000703	2024-07-23 06:47:53.622434	\N	9	t
704	704	FAC-000704	2025-01-09 15:08:50.565079	\N	5	t
705	705	FAC-000705	2025-05-03 01:32:20.386954	\N	7	t
706	706	FAC-000706	2024-09-18 15:51:33.389502	\N	6	t
707	707	FAC-000707	2025-05-27 00:07:56.857101	\N	3	t
708	708	FAC-000708	2024-12-26 11:55:44.681358	\N	5	t
709	709	FAC-000709	2024-08-09 16:23:36.54947	\N	10	t
710	710	FAC-000710	2024-10-14 11:19:19.970748	\N	6	t
711	711	FAC-000711	2024-07-27 11:45:23.663265	\N	2	t
712	712	FAC-000712	2025-06-10 12:46:30.714375	\N	7	t
713	713	FAC-000713	2025-01-11 06:33:27.227271	\N	5	t
714	714	FAC-000714	2024-10-21 10:41:50.052503	\N	7	t
715	715	FAC-000715	2024-10-06 08:22:11.219084	\N	9	t
716	716	FAC-000716	2024-11-08 12:04:23.340577	\N	8	t
717	717	FAC-000717	2025-02-18 12:01:37.855047	\N	4	t
718	718	FAC-000718	2025-01-12 17:36:53.875266	\N	4	t
719	719	FAC-000719	2025-03-03 00:48:53.468075	\N	7	t
720	720	FAC-000720	2025-01-15 08:29:44.1226	\N	4	t
721	721	FAC-000721	2024-07-07 00:03:37.207734	\N	6	t
722	722	FAC-000722	2025-03-05 16:42:16.39389	\N	9	t
723	723	FAC-000723	2024-10-17 02:29:11.141728	\N	8	t
724	724	FAC-000724	2024-10-19 10:16:14.716032	\N	3	t
725	725	FAC-000725	2024-12-13 12:06:59.33408	\N	2	t
726	726	FAC-000726	2024-09-26 18:06:38.93978	\N	1	t
727	727	FAC-000727	2024-12-26 14:52:31.500414	\N	4	t
728	728	FAC-000728	2024-07-29 20:44:14.614763	\N	9	t
729	729	FAC-000729	2024-09-05 01:18:22.551132	\N	3	t
730	730	FAC-000730	2025-01-06 22:11:51.348024	\N	3	t
731	731	FAC-000731	2025-02-27 01:09:55.442321	\N	4	t
732	732	FAC-000732	2024-07-12 18:41:27.323773	\N	8	t
733	733	FAC-000733	2024-07-21 07:47:11.189722	\N	10	t
734	734	FAC-000734	2025-05-15 00:10:21.118246	\N	10	t
735	735	FAC-000735	2025-06-08 17:00:54.015095	\N	6	t
736	736	FAC-000736	2025-05-17 15:47:37.147061	\N	7	t
737	737	FAC-000737	2025-01-15 08:49:04.259857	\N	2	t
738	738	FAC-000738	2025-03-26 01:24:46.44164	\N	7	t
739	739	FAC-000739	2024-11-24 22:59:07.075107	\N	5	t
740	740	FAC-000740	2024-08-21 19:10:25.202352	\N	4	t
741	741	FAC-000741	2024-07-20 18:05:29.336048	\N	5	t
742	742	FAC-000742	2024-07-23 02:21:20.746697	\N	5	t
743	743	FAC-000743	2025-06-01 12:19:36.485003	\N	5	t
744	744	FAC-000744	2024-10-22 04:35:31.315619	\N	5	t
745	745	FAC-000745	2025-02-06 04:02:27.444844	\N	5	t
746	746	FAC-000746	2025-04-02 05:44:12.599892	\N	5	t
747	747	FAC-000747	2025-06-12 14:29:30.088685	\N	4	t
748	748	FAC-000748	2025-03-29 19:13:09.520041	\N	9	t
749	749	FAC-000749	2024-06-24 08:54:49.805061	\N	8	t
750	750	FAC-000750	2024-12-08 05:32:25.429349	\N	6	t
751	751	FAC-000751	2024-07-13 04:04:38.218159	\N	9	t
752	752	FAC-000752	2025-01-12 02:44:24.874475	\N	2	t
753	753	FAC-000753	2025-03-01 20:54:55.26304	\N	9	t
754	754	FAC-000754	2025-04-14 15:09:14.988399	\N	6	t
755	755	FAC-000755	2024-06-26 23:37:50.67789	\N	8	t
756	756	FAC-000756	2024-11-06 10:29:33.039005	\N	6	t
757	757	FAC-000757	2025-01-30 04:43:30.093101	\N	5	t
758	758	FAC-000758	2024-07-03 07:04:13.070365	\N	3	t
759	759	FAC-000759	2024-07-26 14:01:32.925716	\N	2	t
760	760	FAC-000760	2025-03-06 15:57:40.787708	\N	8	t
761	761	FAC-000761	2025-01-31 03:58:37.740348	\N	5	t
762	762	FAC-000762	2025-01-26 05:08:30.792522	\N	3	t
763	763	FAC-000763	2025-03-09 22:36:51.775524	\N	5	t
764	764	FAC-000764	2025-04-16 02:55:09.083778	\N	6	t
765	765	FAC-000765	2024-08-28 17:24:07.097179	\N	6	t
766	766	FAC-000766	2024-06-16 21:09:26.007899	\N	6	t
767	767	FAC-000767	2025-05-12 17:50:57.982162	\N	3	t
768	768	FAC-000768	2025-01-14 15:26:05.457989	\N	8	t
769	769	FAC-000769	2024-10-25 15:11:46.336571	\N	8	t
770	770	FAC-000770	2024-10-03 13:22:39.812783	\N	10	t
771	771	FAC-000771	2024-07-23 20:05:10.562733	\N	4	t
772	772	FAC-000772	2025-03-12 04:45:19.628086	\N	3	t
773	773	FAC-000773	2024-07-07 13:57:43.809482	\N	2	t
774	774	FAC-000774	2024-07-30 17:57:44.683457	\N	8	t
775	775	FAC-000775	2024-08-21 05:26:27.36098	\N	8	t
776	776	FAC-000776	2024-12-29 12:15:09.203358	\N	2	t
777	777	FAC-000777	2024-07-31 01:48:13.701368	\N	10	t
778	778	FAC-000778	2025-05-22 18:15:20.241125	\N	3	t
779	779	FAC-000779	2024-07-26 06:46:56.701654	\N	5	t
780	780	FAC-000780	2025-02-01 20:56:59.532981	\N	4	t
781	781	FAC-000781	2024-08-13 16:19:04.692786	\N	4	t
782	782	FAC-000782	2025-02-06 14:37:36.789816	\N	7	t
783	783	FAC-000783	2025-05-16 14:20:59.371516	\N	7	t
784	784	FAC-000784	2025-03-12 15:17:16.031276	\N	7	t
785	785	FAC-000785	2024-12-07 19:37:14.310613	\N	1	t
786	786	FAC-000786	2025-06-03 12:08:59.758678	\N	4	t
787	787	FAC-000787	2024-10-27 18:51:31.524591	\N	8	t
788	788	FAC-000788	2024-07-28 15:10:18.780096	\N	7	t
789	789	FAC-000789	2024-08-02 10:54:47.452626	\N	9	t
790	790	FAC-000790	2025-04-27 16:43:11.440794	\N	3	t
791	791	FAC-000791	2025-05-16 19:43:23.561061	\N	2	t
792	792	FAC-000792	2024-10-24 01:30:35.857103	\N	10	t
793	793	FAC-000793	2024-10-14 01:18:42.111316	\N	9	t
794	794	FAC-000794	2025-01-17 14:24:50.915787	\N	1	t
795	795	FAC-000795	2024-12-01 09:15:34.816731	\N	2	t
796	796	FAC-000796	2025-02-24 20:31:19.040529	\N	6	t
797	797	FAC-000797	2024-09-11 16:28:53.960897	\N	6	t
798	798	FAC-000798	2024-06-24 23:41:14.624863	\N	2	t
799	799	FAC-000799	2025-04-10 04:48:33.78225	\N	6	t
800	800	FAC-000800	2024-07-05 20:17:28.86588	\N	7	t
801	801	FAC-000801	2025-05-05 12:29:43.972968	\N	3	t
802	802	FAC-000802	2025-01-12 07:24:15.191116	\N	2	t
803	803	FAC-000803	2024-07-22 19:59:20.972529	\N	9	t
804	804	FAC-000804	2025-03-25 19:01:20.047421	\N	7	t
805	805	FAC-000805	2025-05-30 14:32:16.281957	\N	1	t
806	806	FAC-000806	2024-09-27 04:48:37.400136	\N	3	t
807	807	FAC-000807	2024-12-15 02:13:57.646462	\N	4	t
808	808	FAC-000808	2024-08-25 01:21:53.117348	\N	5	t
809	809	FAC-000809	2024-07-31 18:40:31.304815	\N	8	t
810	810	FAC-000810	2025-05-09 03:13:07.911683	\N	3	t
811	811	FAC-000811	2024-11-13 19:18:35.711075	\N	3	t
812	812	FAC-000812	2025-01-22 01:51:25.201995	\N	5	t
813	813	FAC-000813	2024-12-14 08:02:39.827291	\N	6	t
814	814	FAC-000814	2025-04-30 00:03:58.92788	\N	5	t
815	815	FAC-000815	2024-08-16 00:58:51.894141	\N	10	t
816	816	FAC-000816	2024-10-23 14:30:33.259391	\N	4	t
817	817	FAC-000817	2024-09-09 05:09:26.998159	\N	2	t
818	818	FAC-000818	2025-01-05 08:16:31.739835	\N	9	t
819	819	FAC-000819	2025-04-17 19:12:33.622788	\N	2	t
820	820	FAC-000820	2025-05-31 19:03:33.942121	\N	2	t
821	821	FAC-000821	2025-02-28 09:24:56.629433	\N	4	t
822	822	FAC-000822	2025-04-15 12:14:23.815123	\N	9	t
823	823	FAC-000823	2024-11-29 22:29:48.36347	\N	9	t
824	824	FAC-000824	2024-09-26 05:54:48.100257	\N	5	t
825	825	FAC-000825	2025-04-17 17:41:18.267292	\N	1	t
826	826	FAC-000826	2024-12-24 11:19:09.925487	\N	1	t
827	827	FAC-000827	2024-09-16 15:27:07.345674	\N	5	t
828	828	FAC-000828	2024-11-15 07:28:48.999225	\N	3	t
829	829	FAC-000829	2024-09-28 01:33:23.436454	\N	7	t
830	830	FAC-000830	2025-01-18 18:50:58.670615	\N	5	t
831	831	FAC-000831	2024-06-17 09:03:20.623997	\N	4	t
832	832	FAC-000832	2025-02-02 08:46:27.89273	\N	7	t
833	833	FAC-000833	2024-09-18 23:35:09.839498	\N	9	t
834	834	FAC-000834	2024-11-13 06:27:40.215049	\N	3	t
835	835	FAC-000835	2024-07-08 05:55:21.315481	\N	10	t
836	836	FAC-000836	2025-02-15 01:40:41.18674	\N	10	t
837	837	FAC-000837	2025-06-12 02:57:52.38182	\N	6	t
838	838	FAC-000838	2025-01-04 17:20:08.7482	\N	1	t
839	839	FAC-000839	2024-12-02 03:03:12.137166	\N	6	t
840	840	FAC-000840	2025-05-03 13:24:26.031785	\N	8	t
841	841	FAC-000841	2024-12-09 02:34:08.656206	\N	7	t
842	842	FAC-000842	2025-03-31 09:28:53.161823	\N	10	t
843	843	FAC-000843	2024-07-16 12:18:34.371353	\N	2	t
844	844	FAC-000844	2025-01-17 08:50:39.706549	\N	4	t
845	845	FAC-000845	2024-08-18 23:20:16.174001	\N	10	t
846	846	FAC-000846	2024-10-19 21:38:16.454641	\N	7	t
847	847	FAC-000847	2025-03-22 02:36:30.310379	\N	4	t
848	848	FAC-000848	2024-08-06 03:38:09.692835	\N	5	t
849	849	FAC-000849	2025-05-02 13:51:54.274788	\N	9	t
850	850	FAC-000850	2024-07-16 13:31:43.002713	\N	6	t
851	851	FAC-000851	2024-08-08 22:01:26.828881	\N	2	t
852	852	FAC-000852	2025-01-03 22:41:35.784237	\N	4	t
853	853	FAC-000853	2025-01-22 17:52:48.093639	\N	6	t
854	854	FAC-000854	2025-03-16 19:22:01.958389	\N	1	t
855	855	FAC-000855	2025-04-26 00:43:00.28376	\N	5	t
856	856	FAC-000856	2025-03-06 12:16:35.004799	\N	5	t
857	857	FAC-000857	2024-08-18 17:16:17.538739	\N	3	t
858	858	FAC-000858	2025-05-11 14:16:55.447879	\N	10	t
859	859	FAC-000859	2024-08-10 18:43:38.524274	\N	5	t
860	860	FAC-000860	2024-09-27 03:04:24.681906	\N	9	t
861	861	FAC-000861	2025-05-27 00:31:13.552359	\N	7	t
862	862	FAC-000862	2025-06-09 09:43:30.188823	\N	9	t
863	863	FAC-000863	2024-11-06 13:40:13.787704	\N	2	t
864	864	FAC-000864	2024-11-07 00:44:25.471377	\N	5	t
865	865	FAC-000865	2025-04-03 08:18:23.95541	\N	4	t
866	866	FAC-000866	2025-01-19 13:30:17.063065	\N	2	t
867	867	FAC-000867	2025-06-13 13:39:16.013764	\N	3	t
868	868	FAC-000868	2024-06-21 11:55:55.272408	\N	1	t
869	869	FAC-000869	2025-04-20 16:39:17.315384	\N	10	t
870	870	FAC-000870	2024-09-09 09:34:55.16902	\N	4	t
871	871	FAC-000871	2025-03-24 16:17:16.946393	\N	6	t
872	872	FAC-000872	2024-09-12 02:10:37.572442	\N	9	t
873	873	FAC-000873	2024-07-08 14:29:19.784977	\N	8	t
874	874	FAC-000874	2024-09-13 23:52:21.577678	\N	5	t
875	875	FAC-000875	2025-02-08 14:09:26.325501	\N	8	t
876	876	FAC-000876	2025-02-02 02:13:20.711258	\N	6	t
877	877	FAC-000877	2025-06-02 12:10:07.002999	\N	5	t
878	878	FAC-000878	2024-12-31 04:07:37.706631	\N	10	t
879	879	FAC-000879	2024-09-19 07:56:08.930961	\N	9	t
880	880	FAC-000880	2024-10-12 01:25:56.274002	\N	5	t
881	881	FAC-000881	2025-04-04 07:09:49.577677	\N	5	t
882	882	FAC-000882	2024-09-01 16:34:40.327148	\N	1	t
883	883	FAC-000883	2025-03-09 11:39:28.756977	\N	6	t
884	884	FAC-000884	2025-03-08 19:10:44.437496	\N	8	t
885	885	FAC-000885	2025-05-30 11:54:26.065268	\N	8	t
886	886	FAC-000886	2025-04-01 23:34:49.358291	\N	4	t
887	887	FAC-000887	2024-10-29 22:50:14.266608	\N	3	t
888	888	FAC-000888	2025-01-27 21:14:54.44681	\N	7	t
889	889	FAC-000889	2025-06-06 16:17:09.511856	\N	8	t
890	890	FAC-000890	2025-04-27 05:54:26.02702	\N	2	t
891	891	FAC-000891	2024-06-24 07:06:21.670649	\N	5	t
892	892	FAC-000892	2024-12-26 07:46:16.187923	\N	1	t
893	893	FAC-000893	2025-04-16 12:40:41.703261	\N	7	t
894	894	FAC-000894	2025-03-17 12:44:03.2399	\N	10	t
895	895	FAC-000895	2025-01-19 21:16:16.946013	\N	10	t
896	896	FAC-000896	2025-03-14 11:38:46.11685	\N	5	t
897	897	FAC-000897	2025-03-07 15:58:00.29646	\N	8	t
898	898	FAC-000898	2025-01-28 21:21:11.014862	\N	4	t
899	899	FAC-000899	2024-12-15 00:32:54.942373	\N	1	t
900	900	FAC-000900	2024-08-17 19:05:55.194271	\N	8	t
901	901	FAC-000901	2024-06-18 01:22:32.416183	\N	9	t
902	902	FAC-000902	2024-10-26 17:02:25.191277	\N	2	t
903	903	FAC-000903	2025-04-29 02:03:02.315203	\N	7	t
904	904	FAC-000904	2024-10-01 18:50:40.625867	\N	7	t
905	905	FAC-000905	2024-08-10 14:05:02.400695	\N	9	t
906	906	FAC-000906	2025-04-23 22:26:19.516188	\N	3	t
907	907	FAC-000907	2024-08-03 19:55:12.337376	\N	4	t
908	908	FAC-000908	2025-02-26 09:06:22.230489	\N	7	t
909	909	FAC-000909	2025-01-08 13:52:08.688269	\N	1	t
910	910	FAC-000910	2024-09-01 10:32:12.964199	\N	3	t
911	911	FAC-000911	2025-01-20 11:56:20.716243	\N	2	t
912	912	FAC-000912	2024-11-26 08:37:52.412902	\N	8	t
913	913	FAC-000913	2025-03-31 03:11:14.764762	\N	4	t
914	914	FAC-000914	2024-09-12 16:43:05.777134	\N	9	t
915	915	FAC-000915	2024-11-09 02:46:02.30467	\N	2	t
916	916	FAC-000916	2025-05-11 21:35:00.504671	\N	8	t
917	917	FAC-000917	2024-09-14 11:23:15.758012	\N	7	t
918	918	FAC-000918	2025-05-06 06:00:00.208409	\N	7	t
919	919	FAC-000919	2025-02-07 04:26:21.186373	\N	9	t
920	920	FAC-000920	2024-08-16 11:35:08.614171	\N	9	t
921	921	FAC-000921	2024-06-23 09:23:10.010879	\N	7	t
922	922	FAC-000922	2025-01-02 15:33:17.098689	\N	5	t
923	923	FAC-000923	2025-04-27 19:55:31.967074	\N	5	t
924	924	FAC-000924	2024-11-16 21:17:44.344905	\N	1	t
925	925	FAC-000925	2025-05-11 03:40:50.628835	\N	9	t
926	926	FAC-000926	2024-09-22 20:16:16.133805	\N	6	t
927	927	FAC-000927	2025-04-23 13:09:29.363791	\N	3	t
928	928	FAC-000928	2025-05-23 10:57:28.401727	\N	7	t
929	929	FAC-000929	2025-02-23 18:18:20.23467	\N	3	t
930	930	FAC-000930	2024-12-29 22:47:23.545002	\N	8	t
931	931	FAC-000931	2024-09-13 17:12:17.106402	\N	4	t
932	932	FAC-000932	2025-04-12 02:27:11.271925	\N	2	t
933	933	FAC-000933	2025-05-23 06:26:03.854972	\N	1	t
934	934	FAC-000934	2025-04-11 15:27:59.822084	\N	5	t
935	935	FAC-000935	2025-01-22 22:53:47.937782	\N	3	t
936	936	FAC-000936	2024-07-13 11:34:05.594794	\N	5	t
937	937	FAC-000937	2025-01-18 16:56:44.576015	\N	1	t
938	938	FAC-000938	2025-02-01 01:04:56.345502	\N	1	t
939	939	FAC-000939	2025-04-05 21:50:27.474779	\N	2	t
940	940	FAC-000940	2024-09-01 02:13:34.128054	\N	6	t
941	941	FAC-000941	2024-07-08 16:54:02.976946	\N	10	t
942	942	FAC-000942	2025-02-27 13:10:45.014508	\N	8	t
943	943	FAC-000943	2025-01-18 17:23:29.605151	\N	7	t
944	944	FAC-000944	2025-01-16 08:08:46.251405	\N	1	t
945	945	FAC-000945	2024-11-10 13:50:19.532175	\N	5	t
946	946	FAC-000946	2025-05-02 21:26:33.334021	\N	6	t
947	947	FAC-000947	2025-04-27 20:33:38.195175	\N	6	t
948	948	FAC-000948	2024-11-03 11:47:13.033553	\N	5	t
949	949	FAC-000949	2024-12-03 01:55:45.355681	\N	8	t
950	950	FAC-000950	2024-10-24 15:45:51.872267	\N	3	t
951	951	FAC-000951	2024-07-19 02:39:09.125496	\N	9	t
952	952	FAC-000952	2024-10-15 18:00:11.149426	\N	1	t
953	953	FAC-000953	2024-07-01 15:49:24.420296	\N	7	t
954	954	FAC-000954	2024-10-15 15:33:27.788316	\N	5	t
955	955	FAC-000955	2024-08-21 12:48:59.658281	\N	7	t
956	956	FAC-000956	2024-09-26 11:26:40.258812	\N	4	t
957	957	FAC-000957	2025-06-01 19:58:25.718291	\N	6	t
958	958	FAC-000958	2024-08-05 04:37:42.537905	\N	9	t
959	959	FAC-000959	2024-07-02 10:46:00.63781	\N	3	t
960	960	FAC-000960	2024-09-08 17:44:25.891874	\N	3	t
961	961	FAC-000961	2024-10-06 06:46:00.034511	\N	9	t
962	962	FAC-000962	2025-04-28 05:47:05.584898	\N	9	t
963	963	FAC-000963	2024-11-08 16:27:19.951403	\N	4	t
964	964	FAC-000964	2025-01-19 21:39:04.453716	\N	2	t
965	965	FAC-000965	2024-09-19 05:20:59.446459	\N	6	t
966	966	FAC-000966	2024-11-20 09:10:03.748083	\N	8	t
967	967	FAC-000967	2025-03-17 16:21:14.6554	\N	8	t
968	968	FAC-000968	2024-06-18 07:50:26.819737	\N	6	t
969	969	FAC-000969	2024-08-25 18:39:36.575038	\N	2	t
970	970	FAC-000970	2024-12-09 11:45:32.205961	\N	10	t
971	971	FAC-000971	2025-02-19 18:06:56.68109	\N	9	t
972	972	FAC-000972	2024-10-30 14:40:45.410147	\N	5	t
973	973	FAC-000973	2025-01-01 17:44:48.502915	\N	7	t
974	974	FAC-000974	2024-06-25 04:21:10.878774	\N	7	t
975	975	FAC-000975	2024-12-20 19:16:06.075777	\N	10	t
976	976	FAC-000976	2024-09-27 16:12:28.066615	\N	2	t
977	977	FAC-000977	2024-12-06 02:05:57.108677	\N	6	t
978	978	FAC-000978	2024-10-16 00:28:30.882048	\N	6	t
979	979	FAC-000979	2024-09-07 01:04:06.79614	\N	3	t
980	980	FAC-000980	2024-06-23 21:23:18.061199	\N	6	t
981	981	FAC-000981	2025-04-23 07:20:32.092872	\N	8	t
982	982	FAC-000982	2025-03-14 15:03:40.497858	\N	4	t
983	983	FAC-000983	2025-03-31 06:42:50.261694	\N	3	t
984	984	FAC-000984	2025-02-09 14:06:18.438315	\N	8	t
985	985	FAC-000985	2024-06-29 21:14:54.670474	\N	8	t
986	986	FAC-000986	2025-05-31 02:16:03.525314	\N	6	t
987	987	FAC-000987	2025-05-05 16:27:34.111749	\N	2	t
988	988	FAC-000988	2024-09-06 20:12:43.758877	\N	6	t
989	989	FAC-000989	2024-07-11 05:12:14.183157	\N	5	t
990	990	FAC-000990	2025-01-15 04:12:56.934352	\N	3	t
991	991	FAC-000991	2024-08-12 18:03:19.324194	\N	8	t
992	992	FAC-000992	2024-07-12 02:42:01.982442	\N	8	t
993	993	FAC-000993	2025-03-04 14:13:52.180414	\N	4	t
994	994	FAC-000994	2024-10-03 04:40:37.934587	\N	10	t
995	995	FAC-000995	2024-08-31 15:38:34.74578	\N	2	t
996	996	FAC-000996	2024-11-07 03:05:37.182496	\N	1	t
997	997	FAC-000997	2024-09-06 00:51:50.497932	\N	4	t
998	998	FAC-000998	2024-12-12 18:07:45.587061	\N	7	t
999	999	FAC-000999	2025-01-28 08:30:21.213131	\N	2	t
1000	1000	FAC-001000	2025-05-27 05:42:25.163856	\N	7	t
1001	1001	FAC-001001	2024-12-30 14:38:00.595968	\N	3	t
1002	1002	FAC-001002	2024-11-20 18:59:33.4707	\N	2	t
1003	1003	FAC-001003	2025-03-03 22:10:00.710931	\N	10	t
1004	1004	FAC-001004	2025-02-25 13:52:07.653661	\N	3	t
1005	1005	FAC-001005	2025-06-11 00:28:52.457784	\N	5	t
1006	1006	FAC-001006	2024-10-31 08:53:32.552254	\N	4	t
1007	1007	FAC-001007	2025-04-07 01:09:43.383278	\N	8	t
1008	1008	FAC-001008	2024-09-30 18:11:45.883141	\N	8	t
1009	1009	FAC-001009	2024-09-11 21:31:06.204156	\N	5	t
1010	1010	FAC-001010	2025-04-29 02:49:54.394396	\N	4	t
1011	1011	FAC-001011	2025-03-24 00:26:27.667744	\N	10	t
1012	1012	FAC-001012	2024-06-25 02:01:58.976004	\N	8	t
1013	1013	FAC-001013	2024-09-11 08:57:32.940064	\N	3	t
1014	1014	FAC-001014	2024-07-30 05:30:16.143439	\N	7	t
1015	1015	FAC-001015	2024-12-23 23:54:51.219084	\N	9	t
1016	1016	FAC-001016	2024-10-03 08:05:51.391758	\N	1	t
1017	1017	FAC-001017	2024-12-28 13:47:25.671121	\N	2	t
1018	1018	FAC-001018	2024-09-16 12:39:06.146099	\N	2	t
1019	1019	FAC-001019	2025-04-14 04:37:01.452452	\N	6	t
1020	1020	FAC-001020	2025-04-14 01:11:48.819172	\N	5	t
1021	1021	FAC-001021	2025-01-02 03:44:56.439023	\N	1	t
1022	1022	FAC-001022	2025-02-05 23:46:17.411026	\N	3	t
1023	1023	FAC-001023	2025-01-16 10:32:57.787247	\N	4	t
1024	1024	FAC-001024	2025-04-14 06:58:13.339288	\N	8	t
1025	1025	FAC-001025	2025-03-29 10:50:17.102498	\N	2	t
1026	1026	FAC-001026	2024-10-02 16:04:26.894677	\N	2	t
1027	1027	FAC-001027	2025-05-06 12:13:26.233673	\N	2	t
1028	1028	FAC-001028	2025-01-08 00:06:24.305235	\N	7	t
1029	1029	FAC-001029	2024-10-07 10:46:19.937445	\N	6	t
1030	1030	FAC-001030	2025-04-29 07:14:24.310938	\N	5	t
1031	1031	FAC-001031	2024-10-27 06:53:11.601186	\N	9	t
1032	1032	FAC-001032	2024-12-19 00:27:25.506121	\N	10	t
1033	1033	FAC-001033	2024-10-28 04:09:30.481282	\N	8	t
1034	1034	FAC-001034	2024-11-25 22:28:56.60552	\N	5	t
1035	1035	FAC-001035	2024-09-14 15:43:09.80009	\N	7	t
1036	1036	FAC-001036	2025-03-23 19:57:17.650763	\N	3	t
1037	1037	FAC-001037	2024-09-22 20:30:07.635579	\N	6	t
1038	1038	FAC-001038	2024-07-24 12:40:49.576675	\N	3	t
1039	1039	FAC-001039	2024-08-22 19:46:18.699242	\N	4	t
1040	1040	FAC-001040	2024-12-12 23:53:02.891022	\N	7	t
1041	1041	FAC-001041	2024-07-16 14:26:22.810708	\N	2	t
1042	1042	FAC-001042	2025-01-16 21:01:42.234235	\N	1	t
1043	1043	FAC-001043	2025-02-22 18:21:45.548658	\N	5	t
1044	1044	FAC-001044	2025-05-30 10:58:37.078531	\N	10	t
1045	1045	FAC-001045	2025-02-16 21:02:40.27736	\N	8	t
1046	1046	FAC-001046	2024-09-07 23:10:31.594218	\N	9	t
1047	1047	FAC-001047	2025-05-27 22:30:37.721006	\N	4	t
1048	1048	FAC-001048	2024-08-30 07:06:52.357366	\N	4	t
1049	1049	FAC-001049	2024-07-26 17:11:13.891938	\N	3	t
1050	1050	FAC-001050	2024-11-30 02:43:00.348326	\N	5	t
1051	1051	FAC-001051	2024-12-24 09:43:01.913104	\N	2	t
1052	1052	FAC-001052	2024-11-06 09:07:45.053591	\N	5	t
1053	1053	FAC-001053	2025-05-11 13:30:53.811368	\N	4	t
1054	1054	FAC-001054	2025-01-30 03:18:03.924692	\N	1	t
1055	1055	FAC-001055	2024-06-24 00:33:23.44695	\N	6	t
1056	1056	FAC-001056	2024-11-17 13:02:51.398162	\N	9	t
1057	1057	FAC-001057	2024-10-24 23:51:22.705441	\N	4	t
1058	1058	FAC-001058	2024-12-18 22:06:53.814328	\N	8	t
1059	1059	FAC-001059	2024-09-20 21:31:49.19151	\N	8	t
1060	1060	FAC-001060	2024-07-09 19:57:32.441269	\N	8	t
1061	1061	FAC-001061	2025-05-15 02:50:39.568623	\N	1	t
1062	1062	FAC-001062	2024-09-07 17:25:39.506316	\N	3	t
1063	1063	FAC-001063	2024-07-27 06:46:03.472771	\N	2	t
1064	1064	FAC-001064	2024-11-07 05:45:15.107414	\N	7	t
1065	1065	FAC-001065	2024-09-30 19:09:12.947428	\N	8	t
1066	1066	FAC-001066	2025-03-06 02:17:54.206735	\N	5	t
1067	1067	FAC-001067	2025-05-06 02:37:23.130877	\N	10	t
1068	1068	FAC-001068	2025-01-12 20:38:51.192633	\N	9	t
1069	1069	FAC-001069	2025-05-15 00:15:06.902139	\N	2	t
1070	1070	FAC-001070	2024-08-07 22:12:46.618583	\N	2	t
1071	1071	FAC-001071	2025-05-24 17:24:03.145171	\N	9	t
1072	1072	FAC-001072	2025-06-06 12:18:08.95174	\N	3	t
1073	1073	FAC-001073	2025-01-13 01:15:31.834038	\N	3	t
1074	1074	FAC-001074	2024-06-27 01:09:50.614547	\N	7	t
1075	1075	FAC-001075	2024-11-23 08:25:25.642795	\N	4	t
1076	1076	FAC-001076	2024-11-15 13:17:27.04053	\N	3	t
1077	1077	FAC-001077	2024-07-17 19:12:00.663968	\N	7	t
1078	1078	FAC-001078	2024-11-05 15:25:42.569691	\N	10	t
1079	1079	FAC-001079	2025-01-15 06:00:16.332351	\N	10	t
1080	1080	FAC-001080	2024-06-19 07:21:24.385196	\N	9	t
1081	1081	FAC-001081	2025-06-06 07:11:08.047489	\N	5	t
1082	1082	FAC-001082	2024-09-11 00:54:01.18067	\N	4	t
1083	1083	FAC-001083	2025-06-01 01:04:16.962388	\N	8	t
1084	1084	FAC-001084	2024-10-29 00:46:29.981691	\N	4	t
1085	1085	FAC-001085	2024-09-03 15:29:22.825646	\N	4	t
1086	1086	FAC-001086	2024-08-18 22:03:00.671496	\N	5	t
1087	1087	FAC-001087	2025-02-11 04:05:19.376235	\N	4	t
1088	1088	FAC-001088	2024-07-09 11:36:37.056377	\N	5	t
1089	1089	FAC-001089	2024-07-24 16:25:52.257342	\N	9	t
1090	1090	FAC-001090	2025-04-24 01:03:54.863339	\N	3	t
1091	1091	FAC-001091	2024-12-31 17:47:52.940023	\N	8	t
1092	1092	FAC-001092	2024-07-07 14:05:15.687702	\N	2	t
1093	1093	FAC-001093	2024-11-25 10:34:58.768624	\N	4	t
1094	1094	FAC-001094	2024-09-24 08:08:15.061733	\N	5	t
1095	1095	FAC-001095	2025-03-27 00:18:54.481375	\N	1	t
1096	1096	FAC-001096	2024-07-16 05:28:15.53257	\N	5	t
1097	1097	FAC-001097	2024-08-05 15:25:39.361671	\N	8	t
1098	1098	FAC-001098	2024-09-19 15:45:13.868837	\N	5	t
1099	1099	FAC-001099	2025-01-19 14:48:03.434153	\N	1	t
1100	1100	FAC-001100	2024-07-13 20:53:01.4125	\N	6	t
1101	1101	FAC-001101	2024-10-30 22:59:14.131385	\N	7	t
1102	1102	FAC-001102	2025-03-21 00:16:18.004177	\N	7	t
1103	1103	FAC-001103	2025-02-17 04:38:31.809992	\N	7	t
1104	1104	FAC-001104	2024-08-29 05:00:18.576065	\N	3	t
1105	1105	FAC-001105	2024-11-28 10:27:03.548502	\N	6	t
1106	1106	FAC-001106	2024-10-03 05:16:52.828713	\N	6	t
1107	1107	FAC-001107	2024-08-01 04:26:08.18889	\N	1	t
1108	1108	FAC-001108	2024-08-30 19:28:59.906877	\N	5	t
1109	1109	FAC-001109	2025-06-08 03:00:44.659475	\N	6	t
1110	1110	FAC-001110	2024-10-17 23:41:39.453222	\N	3	t
1111	1111	FAC-001111	2025-01-08 21:21:20.386534	\N	2	t
1112	1112	FAC-001112	2025-04-17 17:10:02.726262	\N	10	t
1113	1113	FAC-001113	2024-07-22 20:07:04.286243	\N	5	t
1114	1114	FAC-001114	2024-06-30 21:34:31.055213	\N	5	t
1115	1115	FAC-001115	2024-10-17 18:11:30.9162	\N	3	t
1116	1116	FAC-001116	2025-05-12 05:26:09.487458	\N	3	t
1117	1117	FAC-001117	2024-08-11 03:47:49.813201	\N	8	t
1118	1118	FAC-001118	2024-09-23 21:29:15.636639	\N	4	t
1119	1119	FAC-001119	2025-04-23 00:19:37.279644	\N	8	t
1120	1120	FAC-001120	2025-01-12 04:03:58.558302	\N	7	t
1121	1121	FAC-001121	2025-05-27 12:05:15.348518	\N	6	t
1122	1122	FAC-001122	2024-06-21 11:45:53.56727	\N	2	t
1123	1123	FAC-001123	2024-11-15 15:51:34.722143	\N	9	t
1124	1124	FAC-001124	2025-02-25 21:35:08.774467	\N	7	t
1125	1125	FAC-001125	2024-11-08 17:55:43.22369	\N	3	t
1126	1126	FAC-001126	2025-03-21 06:09:56.601995	\N	4	t
1127	1127	FAC-001127	2024-06-23 12:48:26.348651	\N	5	t
1128	1128	FAC-001128	2024-12-16 06:59:30.103451	\N	4	t
1129	1129	FAC-001129	2025-05-20 20:39:22.820742	\N	6	t
1130	1130	FAC-001130	2024-06-25 01:06:21.190749	\N	2	t
1131	1131	FAC-001131	2025-03-10 11:04:25.542595	\N	7	t
1132	1132	FAC-001132	2025-03-03 07:14:23.795287	\N	6	t
1133	1133	FAC-001133	2024-10-05 22:02:30.976339	\N	6	t
1134	1134	FAC-001134	2025-01-22 15:37:17.417859	\N	10	t
1135	1135	FAC-001135	2025-05-09 02:15:53.891656	\N	5	t
1136	1136	FAC-001136	2024-08-15 20:25:48.112573	\N	4	t
1137	1137	FAC-001137	2025-05-25 12:22:35.435384	\N	5	t
1138	1138	FAC-001138	2024-09-19 03:21:07.81708	\N	4	t
1139	1139	FAC-001139	2024-06-29 21:29:16.36263	\N	7	t
1140	1140	FAC-001140	2024-10-11 19:16:05.118433	\N	6	t
1141	1141	FAC-001141	2024-09-06 17:32:53.422124	\N	8	t
1142	1142	FAC-001142	2025-04-08 03:24:39.078912	\N	8	t
1143	1143	FAC-001143	2024-07-21 04:26:56.437638	\N	2	t
1144	1144	FAC-001144	2024-10-13 00:10:48.447244	\N	4	t
1145	1145	FAC-001145	2024-10-14 12:30:14.774574	\N	1	t
1146	1146	FAC-001146	2025-01-22 03:03:07.383703	\N	6	t
1147	1147	FAC-001147	2024-12-30 17:55:55.743098	\N	8	t
1148	1148	FAC-001148	2025-02-07 20:36:09.454383	\N	7	t
1149	1149	FAC-001149	2024-06-20 09:54:01.955079	\N	6	t
1150	1150	FAC-001150	2025-03-16 14:27:25.21542	\N	10	t
1151	1151	FAC-001151	2024-11-04 10:28:42.646325	\N	7	t
1152	1152	FAC-001152	2024-07-30 08:44:58.509502	\N	7	t
1153	1153	FAC-001153	2024-10-08 21:02:50.239826	\N	3	t
1154	1154	FAC-001154	2024-10-30 22:39:35.02582	\N	7	t
1155	1155	FAC-001155	2025-04-30 02:15:31.571923	\N	5	t
1156	1156	FAC-001156	2025-02-21 22:50:15.626829	\N	1	t
1157	1157	FAC-001157	2024-11-18 21:45:03.278994	\N	3	t
1158	1158	FAC-001158	2024-09-30 11:04:17.616783	\N	4	t
1159	1159	FAC-001159	2024-10-23 23:43:43.897297	\N	8	t
1160	1160	FAC-001160	2024-11-09 16:47:19.026016	\N	4	t
1161	1161	FAC-001161	2025-04-01 04:33:25.852453	\N	6	t
1162	1162	FAC-001162	2024-06-17 22:19:40.634325	\N	1	t
1163	1163	FAC-001163	2025-05-31 14:50:56.777168	\N	3	t
1164	1164	FAC-001164	2024-07-01 08:07:53.528472	\N	5	t
1165	1165	FAC-001165	2025-04-14 10:54:10.342179	\N	9	t
1166	1166	FAC-001166	2025-02-03 00:38:31.126553	\N	9	t
1167	1167	FAC-001167	2025-06-07 04:33:02.020718	\N	9	t
1168	1168	FAC-001168	2024-07-13 17:19:38.623042	\N	3	t
1169	1169	FAC-001169	2025-03-01 10:52:19.877104	\N	9	t
1170	1170	FAC-001170	2024-07-14 05:02:52.492133	\N	1	t
1171	1171	FAC-001171	2024-08-29 11:37:24.455253	\N	4	t
1172	1172	FAC-001172	2024-10-19 02:01:38.357962	\N	5	t
1173	1173	FAC-001173	2025-01-09 10:44:54.099931	\N	5	t
1174	1174	FAC-001174	2024-12-16 02:50:58.601355	\N	8	t
1175	1175	FAC-001175	2024-11-10 16:49:42.290048	\N	5	t
1176	1176	FAC-001176	2025-05-04 21:54:48.06593	\N	7	t
1177	1177	FAC-001177	2025-06-12 04:13:27.868716	\N	2	t
1178	1178	FAC-001178	2025-05-27 22:39:05.254813	\N	10	t
1179	1179	FAC-001179	2024-10-09 08:40:57.637825	\N	4	t
1180	1180	FAC-001180	2025-04-21 00:04:10.19894	\N	6	t
1181	1181	FAC-001181	2024-10-09 11:14:50.479501	\N	3	t
1182	1182	FAC-001182	2024-12-25 05:02:19.019624	\N	10	t
1183	1183	FAC-001183	2024-12-24 17:02:17.49158	\N	3	t
1184	1184	FAC-001184	2025-03-09 08:34:21.230196	\N	8	t
1185	1185	FAC-001185	2025-04-21 22:15:25.256804	\N	4	t
1186	1186	FAC-001186	2025-05-12 20:16:18.259612	\N	7	t
1187	1187	FAC-001187	2024-12-02 23:47:12.647021	\N	4	t
1188	1188	FAC-001188	2024-07-26 14:55:36.82073	\N	8	t
1189	1189	FAC-001189	2025-03-29 19:47:20.121434	\N	5	t
1190	1190	FAC-001190	2025-01-13 07:50:47.293382	\N	7	t
1191	1191	FAC-001191	2024-10-15 13:35:47.525959	\N	4	t
1192	1192	FAC-001192	2024-12-19 19:34:44.344386	\N	5	t
1193	1193	FAC-001193	2024-08-01 00:46:30.283116	\N	9	t
1194	1194	FAC-001194	2024-11-05 17:26:43.964013	\N	9	t
1195	1195	FAC-001195	2024-07-11 17:06:13.17592	\N	8	t
1196	1196	FAC-001196	2025-01-24 00:42:45.056958	\N	6	t
1197	1197	FAC-001197	2025-03-10 18:52:56.696639	\N	3	t
1198	1198	FAC-001198	2025-03-02 10:25:01.484031	\N	4	t
1199	1199	FAC-001199	2024-09-06 12:51:57.98033	\N	3	t
1200	1200	FAC-001200	2025-01-29 19:52:19.49634	\N	9	t
1201	1201	FAC-001201	2024-11-28 00:03:26.430522	\N	2	t
1202	1202	FAC-001202	2025-02-11 11:53:49.538173	\N	8	t
1203	1203	FAC-001203	2024-12-24 21:19:42.222684	\N	10	t
1204	1204	FAC-001204	2024-06-29 08:39:22.735134	\N	8	t
1205	1205	FAC-001205	2025-04-23 07:20:46.547427	\N	3	t
1206	1206	FAC-001206	2024-08-27 13:21:40.148881	\N	5	t
1207	1207	FAC-001207	2025-01-21 05:30:23.012008	\N	10	t
1208	1208	FAC-001208	2024-12-17 10:12:21.017958	\N	6	t
1209	1209	FAC-001209	2025-06-12 06:11:50.838896	\N	8	t
1210	1210	FAC-001210	2025-02-04 03:04:00.663794	\N	10	t
1211	1211	FAC-001211	2025-01-18 15:07:11.313818	\N	4	t
1212	1212	FAC-001212	2024-12-11 03:25:22.827939	\N	1	t
1213	1213	FAC-001213	2024-11-05 16:33:49.35184	\N	6	t
1214	1214	FAC-001214	2024-07-29 23:18:20.432779	\N	8	t
1215	1215	FAC-001215	2025-05-02 19:57:15.238793	\N	7	t
1216	1216	FAC-001216	2025-03-13 11:02:40.387335	\N	3	t
1217	1217	FAC-001217	2024-06-27 16:51:01.014417	\N	3	t
1218	1218	FAC-001218	2024-07-24 21:39:36.960115	\N	5	t
1219	1219	FAC-001219	2024-09-11 03:23:21.147279	\N	9	t
1220	1220	FAC-001220	2025-02-02 01:09:51.002197	\N	3	t
1221	1221	FAC-001221	2025-02-22 00:14:47.683139	\N	7	t
1222	1222	FAC-001222	2024-06-23 01:45:43.18929	\N	4	t
1223	1223	FAC-001223	2024-10-08 02:23:44.156032	\N	10	t
1224	1224	FAC-001224	2024-11-26 22:06:44.527118	\N	8	t
1225	1225	FAC-001225	2024-06-17 12:50:22.819438	\N	7	t
1226	1226	FAC-001226	2024-08-21 03:10:52.747612	\N	3	t
1227	1227	FAC-001227	2024-12-18 22:41:11.638439	\N	3	t
1228	1228	FAC-001228	2024-06-14 18:27:39.168682	\N	6	t
1229	1229	FAC-001229	2024-08-29 17:16:49.767194	\N	3	t
1230	1230	FAC-001230	2024-11-14 02:49:38.75128	\N	4	t
1231	1231	FAC-001231	2024-10-09 02:08:43.19074	\N	5	t
1232	1232	FAC-001232	2024-07-02 12:29:22.860247	\N	4	t
1233	1233	FAC-001233	2024-07-21 22:11:15.307208	\N	2	t
1234	1234	FAC-001234	2024-10-16 23:24:40.001107	\N	8	t
1235	1235	FAC-001235	2025-04-28 12:25:39.144959	\N	4	t
1236	1236	FAC-001236	2024-11-21 11:34:13.530462	\N	4	t
1237	1237	FAC-001237	2024-08-10 08:45:49.33803	\N	9	t
1238	1238	FAC-001238	2024-08-07 09:59:25.303285	\N	2	t
1239	1239	FAC-001239	2025-05-02 00:10:58.851798	\N	7	t
1240	1240	FAC-001240	2024-07-29 15:34:27.172191	\N	5	t
1241	1241	FAC-001241	2025-01-06 15:30:14.616306	\N	6	t
1242	1242	FAC-001242	2025-06-01 17:31:06.885357	\N	2	t
1243	1243	FAC-001243	2024-09-08 17:20:35.664737	\N	5	t
1244	1244	FAC-001244	2024-07-10 04:42:57.644505	\N	6	t
1245	1245	FAC-001245	2025-06-02 03:28:02.169661	\N	3	t
1246	1246	FAC-001246	2024-12-28 00:42:48.889094	\N	5	t
1247	1247	FAC-001247	2025-04-07 10:55:43.766302	\N	2	t
1248	1248	FAC-001248	2024-10-16 11:30:36.515273	\N	1	t
1249	1249	FAC-001249	2025-01-21 18:49:06.295325	\N	2	t
1250	1250	FAC-001250	2024-10-29 05:15:03.493578	\N	5	t
1251	1251	FAC-001251	2024-07-22 10:47:00.060311	\N	8	t
1252	1252	FAC-001252	2025-04-07 11:35:04.576654	\N	7	t
1253	1253	FAC-001253	2024-09-13 03:44:28.044968	\N	3	t
1254	1254	FAC-001254	2024-06-18 20:07:54.944373	\N	4	t
1255	1255	FAC-001255	2024-07-04 16:56:53.417922	\N	3	t
1256	1256	FAC-001256	2024-12-22 19:49:01.873271	\N	8	t
1257	1257	FAC-001257	2025-01-03 19:42:49.310421	\N	4	t
1258	1258	FAC-001258	2024-09-26 04:47:03.59622	\N	10	t
1259	1259	FAC-001259	2024-12-08 22:13:44.250508	\N	9	t
1260	1260	FAC-001260	2025-04-08 18:21:54.59146	\N	6	t
1261	1261	FAC-001261	2024-10-16 23:44:01.825088	\N	4	t
1262	1262	FAC-001262	2024-09-17 06:57:10.721966	\N	6	t
1263	1263	FAC-001263	2025-06-03 15:53:51.377573	\N	9	t
1264	1264	FAC-001264	2025-02-22 09:39:51.257988	\N	2	t
1265	1265	FAC-001265	2025-03-04 01:11:35.536254	\N	4	t
1266	1266	FAC-001266	2024-12-22 13:42:27.793222	\N	7	t
1267	1267	FAC-001267	2024-06-27 07:55:13.766399	\N	3	t
1268	1268	FAC-001268	2024-11-28 14:48:17.296974	\N	5	t
1269	1269	FAC-001269	2025-02-02 10:12:24.937957	\N	3	t
1270	1270	FAC-001270	2024-07-23 03:13:51.966617	\N	3	t
1271	1271	FAC-001271	2024-06-22 19:23:34.75385	\N	7	t
1272	1272	FAC-001272	2025-02-12 08:52:20.895539	\N	2	t
1273	1273	FAC-001273	2024-06-27 00:33:54.547025	\N	6	t
1274	1274	FAC-001274	2024-09-10 12:00:23.507187	\N	7	t
1275	1275	FAC-001275	2025-01-27 01:08:13.373696	\N	10	t
1276	1276	FAC-001276	2025-01-26 06:24:06.665479	\N	4	t
1277	1277	FAC-001277	2025-02-03 00:30:23.699801	\N	6	t
1278	1278	FAC-001278	2024-08-21 17:49:27.483468	\N	7	t
1279	1279	FAC-001279	2025-04-30 12:50:43.797051	\N	3	t
1280	1280	FAC-001280	2024-09-13 17:33:43.749289	\N	7	t
1281	1281	FAC-001281	2024-07-01 20:35:10.059207	\N	6	t
1282	1282	FAC-001282	2024-07-10 14:28:41.59565	\N	5	t
1283	1283	FAC-001283	2024-07-30 06:17:34.118859	\N	5	t
1284	1284	FAC-001284	2025-02-23 02:11:57.335106	\N	9	t
1285	1285	FAC-001285	2024-09-22 09:55:58.976483	\N	2	t
1286	1286	FAC-001286	2025-05-14 13:19:25.418533	\N	5	t
1287	1287	FAC-001287	2025-04-24 10:45:37.813556	\N	7	t
1288	1288	FAC-001288	2025-03-21 23:40:21.724207	\N	3	t
1289	1289	FAC-001289	2025-05-04 13:10:39.098706	\N	2	t
1290	1290	FAC-001290	2025-03-17 10:38:22.40259	\N	3	t
1291	1291	FAC-001291	2025-04-07 07:54:27.798183	\N	2	t
1292	1292	FAC-001292	2025-02-19 08:23:15.956329	\N	2	t
1293	1293	FAC-001293	2024-11-06 04:31:02.851294	\N	4	t
1294	1294	FAC-001294	2024-11-02 15:33:11.0978	\N	9	t
1295	1295	FAC-001295	2025-02-22 00:25:04.881273	\N	7	t
1296	1296	FAC-001296	2024-06-15 06:56:56.537669	\N	4	t
1297	1297	FAC-001297	2024-11-19 13:08:04.495367	\N	8	t
1298	1298	FAC-001298	2024-12-03 19:35:22.731914	\N	3	t
1299	1299	FAC-001299	2024-08-23 18:27:40.524127	\N	5	t
1300	1300	FAC-001300	2024-08-20 16:51:04.726719	\N	7	t
1301	1301	FAC-001301	2025-02-02 05:11:08.462712	\N	10	t
1302	1302	FAC-001302	2024-08-01 23:10:00.164736	\N	2	t
1303	1303	FAC-001303	2024-11-14 11:48:05.213387	\N	6	t
1304	1304	FAC-001304	2025-03-23 04:05:44.358104	\N	6	t
1305	1305	FAC-001305	2024-11-12 18:49:06.221322	\N	5	t
1306	1306	FAC-001306	2024-12-11 05:23:35.952514	\N	7	t
1307	1307	FAC-001307	2024-07-02 02:37:33.692115	\N	1	t
1308	1308	FAC-001308	2024-12-22 07:00:23.214829	\N	8	t
1309	1309	FAC-001309	2024-09-19 00:58:23.350175	\N	3	t
1310	1310	FAC-001310	2024-08-18 05:01:11.237825	\N	7	t
1311	1311	FAC-001311	2024-08-15 14:44:49.939579	\N	10	t
1312	1312	FAC-001312	2025-05-05 02:04:42.865901	\N	2	t
1313	1313	FAC-001313	2025-04-20 18:24:56.026745	\N	1	t
1314	1314	FAC-001314	2024-10-09 17:39:41.71711	\N	2	t
1315	1315	FAC-001315	2024-12-30 00:20:17.999046	\N	6	t
1316	1316	FAC-001316	2024-12-17 12:54:14.607512	\N	8	t
1317	1317	FAC-001317	2025-03-04 14:53:50.933421	\N	10	t
1318	1318	FAC-001318	2025-01-31 15:35:40.247253	\N	10	t
1319	1319	FAC-001319	2025-03-16 10:54:39.072722	\N	7	t
1320	1320	FAC-001320	2024-12-07 17:39:01.363856	\N	7	t
1321	1321	FAC-001321	2025-04-22 00:06:08.856053	\N	5	t
1322	1322	FAC-001322	2024-10-26 22:01:00.264954	\N	6	t
1323	1323	FAC-001323	2024-10-14 04:09:37.604546	\N	2	t
1324	1324	FAC-001324	2025-04-24 03:25:30.437942	\N	1	t
1325	1325	FAC-001325	2024-09-15 21:24:48.375957	\N	5	t
1326	1326	FAC-001326	2025-04-13 18:30:59.157967	\N	5	t
1327	1327	FAC-001327	2025-02-19 10:37:18.6374	\N	1	t
1328	1328	FAC-001328	2024-11-04 13:55:30.50621	\N	5	t
1329	1329	FAC-001329	2024-06-25 07:32:14.387648	\N	8	t
1330	1330	FAC-001330	2025-03-04 14:44:30.193829	\N	8	t
1331	1331	FAC-001331	2025-03-18 00:22:21.480925	\N	1	t
1332	1332	FAC-001332	2024-08-08 02:23:43.597679	\N	6	t
1333	1333	FAC-001333	2025-06-08 05:36:44.565245	\N	6	t
1334	1334	FAC-001334	2024-11-08 23:42:46.056352	\N	4	t
1335	1335	FAC-001335	2024-12-07 15:25:02.264323	\N	6	t
1336	1336	FAC-001336	2025-05-16 14:42:30.260993	\N	6	t
1337	1337	FAC-001337	2024-07-04 21:19:20.306813	\N	8	t
1338	1338	FAC-001338	2024-10-28 05:15:35.725559	\N	2	t
1339	1339	FAC-001339	2025-02-22 14:26:53.649159	\N	10	t
1340	1340	FAC-001340	2024-08-19 04:20:58.139449	\N	6	t
1341	1341	FAC-001341	2024-08-20 21:53:22.260136	\N	5	t
1342	1342	FAC-001342	2025-01-16 00:43:29.320961	\N	4	t
1343	1343	FAC-001343	2025-01-11 14:55:15.090702	\N	5	t
1344	1344	FAC-001344	2024-10-18 17:59:09.244494	\N	5	t
1345	1345	FAC-001345	2024-07-11 00:48:42.083935	\N	6	t
1346	1346	FAC-001346	2024-11-15 14:12:06.611914	\N	6	t
1347	1347	FAC-001347	2024-08-15 20:45:40.792374	\N	6	t
1348	1348	FAC-001348	2024-06-28 19:21:28.556177	\N	2	t
1349	1349	FAC-001349	2025-06-02 11:19:31.136672	\N	7	t
1350	1350	FAC-001350	2025-02-15 16:03:57.004538	\N	2	t
1351	1351	FAC-001351	2024-10-05 02:25:14.196323	\N	5	t
1352	1352	FAC-001352	2024-10-17 04:42:45.379189	\N	6	t
1353	1353	FAC-001353	2025-01-20 05:36:04.075922	\N	9	t
1354	1354	FAC-001354	2024-06-27 03:03:16.682984	\N	3	t
1355	1355	FAC-001355	2025-05-01 05:44:58.097371	\N	4	t
1356	1356	FAC-001356	2024-06-15 00:26:57.063471	\N	3	t
1357	1357	FAC-001357	2024-11-07 06:23:40.131538	\N	5	t
1358	1358	FAC-001358	2025-05-20 14:20:43.493996	\N	4	t
1359	1359	FAC-001359	2024-09-13 07:43:42.042295	\N	7	t
1360	1360	FAC-001360	2024-07-17 19:13:19.574277	\N	9	t
1361	1361	FAC-001361	2025-01-24 20:34:34.137144	\N	5	t
1362	1362	FAC-001362	2025-01-28 21:15:50.003028	\N	10	t
1363	1363	FAC-001363	2024-11-25 06:05:18.543857	\N	4	t
1364	1364	FAC-001364	2025-02-27 04:38:34.618576	\N	6	t
1365	1365	FAC-001365	2024-09-03 16:14:15.654592	\N	9	t
1366	1366	FAC-001366	2024-12-10 05:35:27.123045	\N	6	t
1367	1367	FAC-001367	2025-06-06 02:23:18.891509	\N	10	t
1368	1368	FAC-001368	2024-07-28 14:23:28.51934	\N	9	t
1369	1369	FAC-001369	2024-10-18 04:05:29.040038	\N	8	t
1370	1370	FAC-001370	2024-08-24 00:58:49.690658	\N	10	t
1371	1371	FAC-001371	2024-07-17 12:32:16.543405	\N	1	t
1372	1372	FAC-001372	2024-10-19 10:04:21.814632	\N	9	t
1373	1373	FAC-001373	2025-06-13 15:49:14.516017	\N	9	t
1374	1374	FAC-001374	2024-07-05 11:18:53.182611	\N	4	t
1375	1375	FAC-001375	2025-03-18 04:46:35.943573	\N	4	t
1376	1376	FAC-001376	2025-03-10 20:06:58.393237	\N	6	t
1377	1377	FAC-001377	2024-12-24 12:44:17.162463	\N	2	t
1378	1378	FAC-001378	2024-11-22 15:08:00.45081	\N	3	t
1379	1379	FAC-001379	2025-04-16 08:53:35.685264	\N	6	t
1380	1380	FAC-001380	2024-11-02 14:34:16.334963	\N	5	t
1381	1381	FAC-001381	2024-12-27 16:22:03.876329	\N	2	t
1382	1382	FAC-001382	2025-01-13 04:49:52.619726	\N	1	t
1383	1383	FAC-001383	2024-11-27 06:04:59.817354	\N	5	t
1384	1384	FAC-001384	2025-01-22 12:04:59.72927	\N	5	t
1385	1385	FAC-001385	2024-07-29 19:31:03.194037	\N	6	t
1386	1386	FAC-001386	2024-06-24 07:24:50.378724	\N	9	t
1387	1387	FAC-001387	2024-06-17 19:12:35.290781	\N	4	t
1388	1388	FAC-001388	2025-03-01 12:17:22.952062	\N	3	t
1389	1389	FAC-001389	2024-08-14 10:44:12.692195	\N	1	t
1390	1390	FAC-001390	2024-10-21 09:19:53.208779	\N	3	t
1391	1391	FAC-001391	2024-09-18 08:49:50.950685	\N	3	t
1392	1392	FAC-001392	2024-07-14 13:28:51.252366	\N	2	t
1393	1393	FAC-001393	2024-08-16 08:57:56.125534	\N	1	t
1394	1394	FAC-001394	2025-04-03 11:48:42.789134	\N	7	t
1395	1395	FAC-001395	2024-07-08 09:54:57.470107	\N	9	t
1396	1396	FAC-001396	2024-12-01 05:50:13.679629	\N	5	t
1397	1397	FAC-001397	2024-12-16 22:00:55.871136	\N	6	t
1398	1398	FAC-001398	2024-11-23 10:31:53.04505	\N	4	t
1399	1399	FAC-001399	2024-10-24 01:34:07.41203	\N	6	t
1400	1400	FAC-001400	2025-01-07 04:03:58.925792	\N	10	t
1401	1401	FAC-001401	2025-01-17 00:26:25.758652	\N	3	t
1402	1402	FAC-001402	2025-06-13 08:21:23.145783	\N	3	t
1403	1403	FAC-001403	2024-06-24 01:23:35.062547	\N	9	t
1404	1404	FAC-001404	2024-12-05 07:30:31.060904	\N	6	t
1405	1405	FAC-001405	2024-10-11 06:07:49.690668	\N	2	t
1406	1406	FAC-001406	2025-01-17 00:37:25.952967	\N	7	t
1407	1407	FAC-001407	2024-12-03 01:19:34.718199	\N	9	t
1408	1408	FAC-001408	2024-07-18 11:52:07.25848	\N	4	t
1409	1409	FAC-001409	2025-01-18 15:13:20.35097	\N	10	t
1410	1410	FAC-001410	2024-08-25 12:35:27.798792	\N	5	t
1411	1411	FAC-001411	2024-11-24 07:37:52.046292	\N	1	t
1412	1412	FAC-001412	2025-01-04 11:23:53.617465	\N	5	t
1413	1413	FAC-001413	2024-10-17 00:34:19.27031	\N	7	t
1414	1414	FAC-001414	2024-09-09 14:34:23.859058	\N	8	t
1415	1415	FAC-001415	2024-12-15 07:34:35.550764	\N	4	t
1416	1416	FAC-001416	2024-09-21 12:50:35.534703	\N	4	t
1417	1417	FAC-001417	2024-10-02 15:57:38.686775	\N	10	t
1418	1418	FAC-001418	2025-06-06 16:46:36.536344	\N	7	t
1419	1419	FAC-001419	2025-04-09 06:47:33.4146	\N	2	t
1420	1420	FAC-001420	2025-05-18 11:47:53.831818	\N	7	t
1421	1421	FAC-001421	2025-05-10 23:05:02.647281	\N	7	t
1422	1422	FAC-001422	2024-08-05 22:16:36.756754	\N	5	t
1423	1423	FAC-001423	2024-11-10 23:05:18.247655	\N	2	t
1424	1424	FAC-001424	2024-12-10 08:05:34.982606	\N	5	t
1425	1425	FAC-001425	2024-06-20 02:26:20.925125	\N	9	t
1426	1426	FAC-001426	2025-05-02 04:47:15.075866	\N	4	t
1427	1427	FAC-001427	2024-06-30 16:27:43.339248	\N	10	t
1428	1428	FAC-001428	2025-05-18 00:36:55.80904	\N	3	t
1429	1429	FAC-001429	2024-12-04 10:42:37.455306	\N	3	t
1430	1430	FAC-001430	2024-10-27 10:50:28.471696	\N	4	t
1431	1431	FAC-001431	2024-12-22 20:31:53.840265	\N	10	t
1432	1432	FAC-001432	2024-11-05 08:17:57.37613	\N	7	t
1433	1433	FAC-001433	2025-06-08 21:45:55.355109	\N	4	t
1434	1434	FAC-001434	2025-03-31 21:18:44.958063	\N	4	t
1435	1435	FAC-001435	2024-12-11 16:36:59.921761	\N	4	t
1436	1436	FAC-001436	2025-05-23 18:49:07.057439	\N	9	t
1437	1437	FAC-001437	2025-06-10 17:28:25.166983	\N	2	t
1438	1438	FAC-001438	2024-06-19 16:58:08.405649	\N	6	t
1439	1439	FAC-001439	2024-09-17 10:39:17.797377	\N	9	t
1440	1440	FAC-001440	2024-08-05 01:09:55.837657	\N	7	t
1441	1441	FAC-001441	2024-12-30 22:48:05.453724	\N	6	t
1442	1442	FAC-001442	2025-01-27 18:44:04.366688	\N	9	t
1443	1443	FAC-001443	2024-11-11 05:08:21.524004	\N	1	t
1444	1444	FAC-001444	2025-05-31 21:03:19.796117	\N	4	t
1445	1445	FAC-001445	2025-01-14 13:20:41.843146	\N	4	t
1446	1446	FAC-001446	2025-04-12 16:25:05.042681	\N	9	t
1447	1447	FAC-001447	2024-11-05 02:21:00.512379	\N	9	t
1448	1448	FAC-001448	2025-03-10 07:48:00.867281	\N	4	t
1449	1449	FAC-001449	2025-04-16 03:38:10.744667	\N	8	t
1450	1450	FAC-001450	2025-04-14 18:53:20.969963	\N	3	t
1451	1451	FAC-001451	2024-09-13 20:09:37.315703	\N	9	t
1452	1452	FAC-001452	2024-12-07 02:09:42.61201	\N	8	t
1453	1453	FAC-001453	2024-07-07 23:25:31.564381	\N	3	t
1454	1454	FAC-001454	2024-10-30 18:26:29.51482	\N	6	t
1455	1455	FAC-001455	2024-12-03 16:40:14.952171	\N	2	t
1456	1456	FAC-001456	2024-09-10 00:12:20.001511	\N	7	t
1457	1457	FAC-001457	2024-10-26 03:07:33.283373	\N	4	t
1458	1458	FAC-001458	2025-02-01 12:30:50.392535	\N	4	t
1459	1459	FAC-001459	2024-08-11 11:45:20.82015	\N	7	t
1460	1460	FAC-001460	2025-05-27 11:52:29.942734	\N	3	t
1461	1461	FAC-001461	2025-01-13 00:19:05.163932	\N	3	t
1462	1462	FAC-001462	2024-10-08 23:23:12.566403	\N	4	t
1463	1463	FAC-001463	2025-05-11 18:37:17.935074	\N	5	t
1464	1464	FAC-001464	2024-06-19 05:14:33.429057	\N	5	t
1465	1465	FAC-001465	2024-08-09 23:29:57.046871	\N	10	t
1466	1466	FAC-001466	2024-08-09 20:48:41.928386	\N	6	t
1467	1467	FAC-001467	2024-09-09 09:28:22.782995	\N	4	t
1468	1468	FAC-001468	2024-10-22 18:50:59.165498	\N	8	t
1469	1469	FAC-001469	2024-09-01 07:06:22.98952	\N	2	t
1470	1470	FAC-001470	2024-07-14 04:20:26.925525	\N	10	t
1471	1471	FAC-001471	2025-05-08 12:15:07.812232	\N	9	t
1472	1472	FAC-001472	2025-06-06 22:51:59.784227	\N	5	t
1473	1473	FAC-001473	2024-07-02 04:01:00.94576	\N	1	t
1474	1474	FAC-001474	2024-10-26 13:32:10.865062	\N	6	t
1475	1475	FAC-001475	2024-07-22 22:06:11.390512	\N	6	t
1476	1476	FAC-001476	2024-11-01 02:59:52.611533	\N	3	t
1477	1477	FAC-001477	2024-08-17 00:44:22.537762	\N	8	t
1478	1478	FAC-001478	2024-07-24 19:35:43.876811	\N	2	t
1479	1479	FAC-001479	2025-05-02 04:02:39.707544	\N	10	t
1480	1480	FAC-001480	2024-12-06 00:28:31.628618	\N	4	t
1481	1481	FAC-001481	2024-06-22 11:30:59.261621	\N	8	t
1482	1482	FAC-001482	2025-05-21 05:46:11.222207	\N	3	t
1483	1483	FAC-001483	2024-08-31 15:33:59.318692	\N	6	t
1484	1484	FAC-001484	2024-11-25 10:15:59.261862	\N	3	t
1485	1485	FAC-001485	2024-11-08 13:41:22.871616	\N	9	t
1486	1486	FAC-001486	2025-02-25 10:58:17.060517	\N	10	t
1487	1487	FAC-001487	2025-05-03 04:36:27.684918	\N	10	t
1488	1488	FAC-001488	2025-04-06 19:52:32.300978	\N	6	t
1489	1489	FAC-001489	2024-08-27 20:02:54.916666	\N	7	t
1490	1490	FAC-001490	2025-03-01 21:21:50.436783	\N	2	t
1491	1491	FAC-001491	2025-01-23 22:39:18.748764	\N	4	t
1492	1492	FAC-001492	2025-01-08 13:23:30.583975	\N	3	t
1493	1493	FAC-001493	2025-02-08 08:06:20.473539	\N	7	t
1494	1494	FAC-001494	2025-03-27 04:36:42.794475	\N	2	t
1495	1495	FAC-001495	2024-07-10 01:49:51.880569	\N	6	t
1496	1496	FAC-001496	2024-10-18 11:21:20.136831	\N	2	t
1497	1497	FAC-001497	2025-02-06 18:58:56.437061	\N	2	t
1498	1498	FAC-001498	2024-10-31 01:52:46.356096	\N	10	t
1499	1499	FAC-001499	2024-12-07 10:16:02.342662	\N	5	t
1500	1500	FAC-001500	2024-12-27 00:11:50.160681	\N	3	t
1501	1501	FAC-001501	2024-10-31 12:56:09.699976	\N	6	t
1502	1502	FAC-001502	2024-09-21 00:59:42.747849	\N	6	t
1503	1503	FAC-001503	2025-05-09 18:32:54.563902	\N	2	t
1504	1504	FAC-001504	2024-09-20 11:51:50.145661	\N	2	t
1505	1505	FAC-001505	2024-10-16 05:38:38.855805	\N	10	t
1506	1506	FAC-001506	2025-05-26 03:27:38.962036	\N	6	t
1507	1507	FAC-001507	2024-12-30 10:22:05.364109	\N	3	t
1508	1508	FAC-001508	2025-06-05 21:41:31.526517	\N	7	t
1509	1509	FAC-001509	2024-11-05 22:15:09.748329	\N	7	t
1510	1510	FAC-001510	2024-09-21 21:10:22.323197	\N	9	t
1511	1511	FAC-001511	2024-10-05 14:31:21.858504	\N	9	t
1512	1512	FAC-001512	2025-02-17 11:26:03.872494	\N	4	t
1513	1513	FAC-001513	2025-04-14 16:19:07.087598	\N	2	t
1514	1514	FAC-001514	2025-02-02 21:12:17.064434	\N	3	t
1515	1515	FAC-001515	2024-11-11 13:40:56.033457	\N	9	t
1516	1516	FAC-001516	2024-12-18 16:11:43.546818	\N	1	t
1517	1517	FAC-001517	2024-09-21 06:06:38.204899	\N	9	t
1518	1518	FAC-001518	2024-10-04 16:36:32.868616	\N	2	t
1519	1519	FAC-001519	2024-12-07 17:31:59.533484	\N	7	t
1520	1520	FAC-001520	2024-08-27 11:00:12.762405	\N	7	t
1521	1521	FAC-001521	2024-09-09 02:53:42.670269	\N	4	t
1522	1522	FAC-001522	2024-12-25 00:17:16.645511	\N	9	t
1523	1523	FAC-001523	2025-02-11 03:45:25.227516	\N	6	t
1524	1524	FAC-001524	2024-09-08 07:25:19.376338	\N	2	t
1525	1525	FAC-001525	2025-03-07 17:23:23.635054	\N	7	t
1526	1526	FAC-001526	2025-05-23 00:57:54.91931	\N	1	t
1527	1527	FAC-001527	2025-01-29 21:33:50.993261	\N	4	t
1528	1528	FAC-001528	2024-08-18 11:50:38.975753	\N	2	t
1529	1529	FAC-001529	2024-09-14 06:10:32.078275	\N	4	t
1530	1530	FAC-001530	2024-10-27 17:25:37.701623	\N	10	t
1531	1531	FAC-001531	2025-04-10 23:53:47.310354	\N	6	t
1532	1532	FAC-001532	2024-07-16 11:57:05.052663	\N	3	t
1533	1533	FAC-001533	2024-12-17 03:13:30.231165	\N	4	t
1534	1534	FAC-001534	2025-04-14 23:13:32.293482	\N	9	t
1535	1535	FAC-001535	2024-12-31 14:07:22.732722	\N	7	t
1536	1536	FAC-001536	2024-12-27 15:13:33.373475	\N	5	t
1537	1537	FAC-001537	2024-06-14 18:21:10.285311	\N	10	t
1538	1538	FAC-001538	2025-01-05 13:08:22.159274	\N	8	t
1539	1539	FAC-001539	2024-08-09 10:15:21.764369	\N	4	t
1540	1540	FAC-001540	2024-11-27 14:17:49.581956	\N	10	t
1541	1541	FAC-001541	2024-12-04 08:09:50.31426	\N	9	t
1542	1542	FAC-001542	2024-06-17 09:24:00.391761	\N	4	t
1543	1543	FAC-001543	2025-03-24 23:14:01.830334	\N	8	t
1544	1544	FAC-001544	2024-12-06 13:17:45.848514	\N	1	t
1545	1545	FAC-001545	2024-10-29 20:47:04.84351	\N	2	t
1546	1546	FAC-001546	2024-10-16 21:56:47.798125	\N	7	t
1547	1547	FAC-001547	2024-07-21 14:04:30.861811	\N	7	t
1548	1548	FAC-001548	2024-06-22 06:36:32.911221	\N	7	t
1549	1549	FAC-001549	2025-03-16 16:31:43.890823	\N	7	t
1550	1550	FAC-001550	2024-10-28 10:46:14.726934	\N	2	t
1551	1551	FAC-001551	2025-04-06 07:00:46.804537	\N	10	t
1552	1552	FAC-001552	2024-06-25 07:27:30.008329	\N	9	t
1553	1553	FAC-001553	2024-12-30 06:10:46.385938	\N	7	t
1554	1554	FAC-001554	2025-04-01 19:27:42.496209	\N	2	t
1555	1555	FAC-001555	2024-08-06 12:45:27.104746	\N	10	t
1556	1556	FAC-001556	2024-06-21 01:14:03.777306	\N	3	t
1557	1557	FAC-001557	2024-06-15 13:10:42.280147	\N	9	t
1558	1558	FAC-001558	2024-07-12 12:51:24.451231	\N	7	t
1559	1559	FAC-001559	2024-08-07 07:32:26.623795	\N	4	t
1560	1560	FAC-001560	2025-04-24 17:10:12.616198	\N	5	t
1561	1561	FAC-001561	2025-04-21 00:12:20.003047	\N	5	t
1562	1562	FAC-001562	2025-04-07 19:59:17.896479	\N	7	t
1563	1563	FAC-001563	2025-05-04 01:06:45.49164	\N	4	t
1564	1564	FAC-001564	2024-10-05 15:18:52.200982	\N	7	t
1565	1565	FAC-001565	2024-12-01 16:58:37.047177	\N	1	t
1566	1566	FAC-001566	2025-02-08 16:03:58.597505	\N	6	t
1567	1567	FAC-001567	2025-05-07 00:32:34.06183	\N	9	t
1568	1568	FAC-001568	2025-06-06 19:36:27.045848	\N	7	t
1569	1569	FAC-001569	2024-06-29 19:01:19.922357	\N	8	t
1570	1570	FAC-001570	2024-09-11 00:05:47.700177	\N	4	t
1571	1571	FAC-001571	2024-12-23 06:58:59.29935	\N	8	t
1572	1572	FAC-001572	2025-05-16 00:04:21.511337	\N	8	t
1573	1573	FAC-001573	2024-10-12 01:18:31.422607	\N	5	t
1574	1574	FAC-001574	2024-10-04 02:43:15.904584	\N	4	t
1575	1575	FAC-001575	2025-04-18 14:57:48.594446	\N	2	t
1576	1576	FAC-001576	2025-01-16 18:02:09.591354	\N	3	t
1577	1577	FAC-001577	2025-02-21 21:04:38.857328	\N	9	t
1578	1578	FAC-001578	2025-03-31 16:27:32.194914	\N	9	t
1579	1579	FAC-001579	2025-01-17 18:33:12.279945	\N	6	t
1580	1580	FAC-001580	2024-09-02 22:04:22.780657	\N	3	t
1581	1581	FAC-001581	2025-03-16 16:33:34.44357	\N	7	t
1582	1582	FAC-001582	2024-07-08 17:23:23.344524	\N	1	t
1583	1583	FAC-001583	2024-10-21 19:13:48.986488	\N	5	t
1584	1584	FAC-001584	2025-02-06 13:52:13.746606	\N	4	t
1585	1585	FAC-001585	2024-09-16 04:59:58.428708	\N	4	t
1586	1586	FAC-001586	2024-07-05 11:56:56.800936	\N	7	t
1587	1587	FAC-001587	2025-01-29 14:31:58.2136	\N	9	t
1588	1588	FAC-001588	2025-02-12 14:52:03.428892	\N	1	t
1589	1589	FAC-001589	2025-01-28 06:56:18.531924	\N	2	t
1590	1590	FAC-001590	2025-05-01 22:33:24.95881	\N	8	t
1591	1591	FAC-001591	2024-12-10 19:59:09.073194	\N	5	t
1592	1592	FAC-001592	2024-08-26 04:01:20.478463	\N	9	t
1593	1593	FAC-001593	2024-10-31 02:04:45.332598	\N	5	t
1594	1594	FAC-001594	2025-04-22 14:24:32.977948	\N	2	t
1595	1595	FAC-001595	2024-12-04 06:08:59.054905	\N	7	t
1596	1596	FAC-001596	2025-01-24 06:12:22.261146	\N	8	t
1597	1597	FAC-001597	2025-04-16 13:22:18.459862	\N	10	t
1598	1598	FAC-001598	2024-09-02 03:25:32.763883	\N	3	t
1599	1599	FAC-001599	2025-05-01 17:59:17.033601	\N	3	t
1600	1600	FAC-001600	2025-06-10 11:30:48.815919	\N	4	t
1601	1601	FAC-001601	2024-07-06 01:01:37.880749	\N	8	t
1602	1602	FAC-001602	2024-10-14 07:42:51.450625	\N	8	t
1603	1603	FAC-001603	2024-12-18 16:41:00.617441	\N	3	t
1604	1604	FAC-001604	2025-01-02 18:01:36.466471	\N	6	t
1605	1605	FAC-001605	2024-10-25 22:14:02.280333	\N	2	t
1606	1606	FAC-001606	2025-05-10 21:05:54.863452	\N	7	t
1607	1607	FAC-001607	2025-05-31 13:29:46.459108	\N	7	t
1608	1608	FAC-001608	2024-07-03 01:10:04.64932	\N	3	t
1609	1609	FAC-001609	2024-06-27 07:50:22.415382	\N	4	t
1610	1610	FAC-001610	2024-12-23 07:29:27.661817	\N	9	t
1611	1611	FAC-001611	2025-03-04 09:31:10.660168	\N	7	t
1612	1612	FAC-001612	2024-07-01 01:32:04.282252	\N	5	t
1613	1613	FAC-001613	2025-05-18 22:11:39.090848	\N	7	t
1614	1614	FAC-001614	2024-08-10 08:01:25.01635	\N	10	t
1615	1615	FAC-001615	2024-12-12 21:57:28.761097	\N	5	t
1616	1616	FAC-001616	2024-07-10 01:31:20.057257	\N	2	t
1617	1617	FAC-001617	2025-06-12 03:27:02.888134	\N	3	t
1618	1618	FAC-001618	2025-01-17 12:57:11.05868	\N	3	t
1619	1619	FAC-001619	2025-04-16 09:41:04.791645	\N	9	t
1620	1620	FAC-001620	2024-11-02 02:19:37.985843	\N	3	t
1621	1621	FAC-001621	2024-06-21 07:22:55.424754	\N	3	t
1622	1622	FAC-001622	2025-02-02 16:18:42.0316	\N	4	t
1623	1623	FAC-001623	2024-06-27 19:56:09.838857	\N	10	t
1624	1624	FAC-001624	2025-04-21 03:47:03.577083	\N	3	t
1625	1625	FAC-001625	2025-05-09 02:46:37.10267	\N	10	t
1626	1626	FAC-001626	2025-02-04 09:52:26.008876	\N	10	t
1627	1627	FAC-001627	2024-07-11 04:01:21.890212	\N	9	t
1628	1628	FAC-001628	2024-08-28 19:54:22.448365	\N	10	t
1629	1629	FAC-001629	2025-05-13 17:40:24.079955	\N	4	t
1630	1630	FAC-001630	2025-01-15 20:55:44.661944	\N	2	t
1631	1631	FAC-001631	2024-11-02 04:21:27.921309	\N	4	t
1632	1632	FAC-001632	2024-08-07 22:35:47.825246	\N	8	t
1633	1633	FAC-001633	2024-08-02 14:41:04.334321	\N	6	t
1634	1634	FAC-001634	2025-04-07 21:49:47.928385	\N	10	t
1635	1635	FAC-001635	2024-09-13 05:54:06.778247	\N	2	t
1636	1636	FAC-001636	2025-06-05 18:31:07.658301	\N	2	t
1637	1637	FAC-001637	2024-09-26 16:08:36.145075	\N	4	t
1638	1638	FAC-001638	2025-06-04 00:13:02.09055	\N	1	t
1639	1639	FAC-001639	2025-05-25 06:37:12.403654	\N	5	t
1640	1640	FAC-001640	2025-05-26 02:36:30.452554	\N	8	t
1641	1641	FAC-001641	2024-09-10 03:57:46.876065	\N	6	t
1642	1642	FAC-001642	2025-01-12 08:27:06.490171	\N	5	t
1643	1643	FAC-001643	2025-05-18 12:54:07.937141	\N	4	t
1644	1644	FAC-001644	2024-11-18 15:29:34.635843	\N	6	t
1645	1645	FAC-001645	2024-08-14 17:57:42.866225	\N	8	t
1646	1646	FAC-001646	2024-11-13 06:53:05.276846	\N	8	t
1647	1647	FAC-001647	2025-02-23 17:14:34.236555	\N	7	t
1648	1648	FAC-001648	2025-02-23 06:39:27.739469	\N	2	t
1649	1649	FAC-001649	2024-10-25 18:12:10.683431	\N	9	t
1650	1650	FAC-001650	2025-02-05 13:25:26.483832	\N	7	t
1651	1651	FAC-001651	2025-03-23 16:07:49.897599	\N	6	t
1652	1652	FAC-001652	2025-04-18 09:29:56.426899	\N	5	t
1653	1653	FAC-001653	2024-12-12 03:24:09.117287	\N	6	t
1654	1654	FAC-001654	2024-09-09 10:55:45.286486	\N	5	t
1655	1655	FAC-001655	2024-08-07 02:59:07.153563	\N	6	t
1656	1656	FAC-001656	2024-07-05 11:51:32.991744	\N	2	t
1657	1657	FAC-001657	2025-04-21 23:42:46.112498	\N	6	t
1658	1658	FAC-001658	2024-07-29 16:18:55.909519	\N	8	t
1659	1659	FAC-001659	2025-03-24 19:52:20.957153	\N	9	t
1660	1660	FAC-001660	2025-05-02 15:15:11.139079	\N	7	t
1661	1661	FAC-001661	2025-03-21 12:15:42.128053	\N	3	t
1662	1662	FAC-001662	2024-11-11 13:38:28.73967	\N	6	t
1663	1663	FAC-001663	2025-03-23 23:28:58.573221	\N	4	t
1664	1664	FAC-001664	2024-06-22 02:01:33.936236	\N	6	t
1665	1665	FAC-001665	2025-01-17 22:53:59.327763	\N	4	t
1666	1666	FAC-001666	2025-04-21 05:11:37.953551	\N	8	t
1667	1667	FAC-001667	2025-03-05 12:10:48.182951	\N	3	t
1668	1668	FAC-001668	2024-09-17 23:13:27.114339	\N	6	t
1669	1669	FAC-001669	2025-03-11 05:06:13.153165	\N	4	t
1670	1670	FAC-001670	2024-12-01 21:33:58.19785	\N	8	t
1671	1671	FAC-001671	2025-06-02 19:30:32.923638	\N	7	t
1672	1672	FAC-001672	2025-01-02 18:32:09.639096	\N	4	t
1673	1673	FAC-001673	2024-12-19 06:44:48.082976	\N	6	t
1674	1674	FAC-001674	2025-03-17 17:31:00.969502	\N	6	t
1675	1675	FAC-001675	2025-05-18 18:35:26.764007	\N	4	t
1676	1676	FAC-001676	2024-10-01 15:53:00.084223	\N	10	t
1677	1677	FAC-001677	2024-11-09 05:24:58.767212	\N	10	t
1678	1678	FAC-001678	2024-09-07 02:10:40.507952	\N	7	t
1679	1679	FAC-001679	2025-04-08 20:24:30.013425	\N	6	t
1680	1680	FAC-001680	2024-10-28 12:00:20.495995	\N	6	t
1681	1681	FAC-001681	2025-03-07 08:32:33.064935	\N	5	t
1682	1682	FAC-001682	2025-03-04 14:02:53.311444	\N	3	t
1683	1683	FAC-001683	2024-12-17 14:08:50.964368	\N	6	t
1684	1684	FAC-001684	2024-08-24 07:14:33.697806	\N	6	t
1685	1685	FAC-001685	2025-02-22 19:26:08.289261	\N	4	t
1686	1686	FAC-001686	2025-01-06 18:52:48.506659	\N	6	t
1687	1687	FAC-001687	2025-06-03 23:52:08.700315	\N	1	t
1688	1688	FAC-001688	2024-11-21 23:08:27.983903	\N	9	t
1689	1689	FAC-001689	2024-09-19 00:28:49.129435	\N	4	t
1690	1690	FAC-001690	2024-07-01 23:08:02.458997	\N	8	t
1691	1691	FAC-001691	2024-08-07 07:49:06.004622	\N	3	t
1692	1692	FAC-001692	2024-10-16 20:07:14.540394	\N	8	t
1693	1693	FAC-001693	2025-06-08 11:37:14.858571	\N	9	t
1694	1694	FAC-001694	2025-05-04 08:27:01.349575	\N	6	t
1695	1695	FAC-001695	2024-10-18 07:44:49.317596	\N	10	t
1696	1696	FAC-001696	2025-04-10 04:11:17.660129	\N	8	t
1697	1697	FAC-001697	2025-01-17 13:23:59.894445	\N	4	t
1698	1698	FAC-001698	2025-01-01 19:22:15.451941	\N	9	t
1699	1699	FAC-001699	2024-07-30 20:01:41.047585	\N	2	t
1700	1700	FAC-001700	2025-05-26 06:52:47.241069	\N	9	t
1701	1701	FAC-001701	2025-04-03 10:41:14.892869	\N	1	t
1702	1702	FAC-001702	2025-04-29 05:49:42.009502	\N	5	t
1703	1703	FAC-001703	2024-11-02 08:20:20.464603	\N	4	t
1704	1704	FAC-001704	2025-04-08 17:59:17.595165	\N	9	t
1705	1705	FAC-001705	2025-01-03 04:44:13.245533	\N	3	t
1706	1706	FAC-001706	2025-03-04 15:41:16.724238	\N	3	t
1707	1707	FAC-001707	2024-07-25 07:41:35.297317	\N	5	t
1708	1708	FAC-001708	2024-11-03 00:26:02.217692	\N	7	t
1709	1709	FAC-001709	2024-07-07 07:31:53.968088	\N	10	t
1710	1710	FAC-001710	2024-09-09 23:50:50.299491	\N	4	t
1711	1711	FAC-001711	2025-03-29 07:55:10.760997	\N	10	t
1712	1712	FAC-001712	2024-08-01 07:16:03.734209	\N	4	t
1713	1713	FAC-001713	2025-01-20 20:22:08.862838	\N	9	t
1714	1714	FAC-001714	2024-07-09 18:49:36.924795	\N	8	t
1715	1715	FAC-001715	2025-01-31 12:23:16.079549	\N	2	t
1716	1716	FAC-001716	2024-08-19 03:46:05.54753	\N	7	t
1717	1717	FAC-001717	2025-03-14 06:51:23.786906	\N	10	t
1718	1718	FAC-001718	2024-09-14 20:07:33.790767	\N	7	t
1719	1719	FAC-001719	2024-11-16 20:08:15.03897	\N	8	t
1720	1720	FAC-001720	2025-01-20 02:57:22.15234	\N	7	t
1721	1721	FAC-001721	2024-08-11 03:34:30.810314	\N	5	t
1722	1722	FAC-001722	2024-12-28 22:43:26.472542	\N	5	t
1723	1723	FAC-001723	2025-04-05 07:14:45.693219	\N	8	t
1724	1724	FAC-001724	2025-01-26 05:37:02.540168	\N	10	t
1725	1725	FAC-001725	2024-09-29 01:55:58.037378	\N	8	t
1726	1726	FAC-001726	2025-04-23 01:49:08.012391	\N	4	t
1727	1727	FAC-001727	2025-02-19 17:08:02.818112	\N	3	t
1728	1728	FAC-001728	2025-02-24 03:34:09.382903	\N	3	t
1729	1729	FAC-001729	2025-02-23 21:34:20.352336	\N	10	t
1730	1730	FAC-001730	2024-09-13 08:53:48.728575	\N	8	t
1731	1731	FAC-001731	2024-10-09 17:40:01.422216	\N	9	t
1732	1732	FAC-001732	2025-05-07 07:12:19.311706	\N	2	t
1733	1733	FAC-001733	2024-09-25 04:58:58.467997	\N	6	t
1734	1734	FAC-001734	2025-03-15 16:00:19.783339	\N	6	t
1735	1735	FAC-001735	2025-04-16 15:47:44.60357	\N	9	t
1736	1736	FAC-001736	2024-12-01 00:22:28.514318	\N	7	t
1737	1737	FAC-001737	2024-07-08 15:07:43.311796	\N	3	t
1738	1738	FAC-001738	2024-08-28 10:46:31.441425	\N	4	t
1739	1739	FAC-001739	2024-12-08 17:19:08.125455	\N	2	t
1740	1740	FAC-001740	2024-07-30 00:26:39.046409	\N	9	t
1741	1741	FAC-001741	2025-04-15 04:44:59.456193	\N	1	t
1742	1742	FAC-001742	2024-07-25 03:21:46.458465	\N	7	t
1743	1743	FAC-001743	2024-11-04 21:18:43.61334	\N	5	t
1744	1744	FAC-001744	2025-05-25 05:24:37.236628	\N	8	t
1745	1745	FAC-001745	2024-07-19 21:14:03.978863	\N	4	t
1746	1746	FAC-001746	2025-02-12 07:20:13.607793	\N	4	t
1747	1747	FAC-001747	2024-08-12 09:20:59.172862	\N	1	t
1748	1748	FAC-001748	2025-01-29 01:10:29.469194	\N	7	t
1749	1749	FAC-001749	2024-12-14 04:46:42.022913	\N	4	t
1750	1750	FAC-001750	2025-04-06 06:35:02.992495	\N	7	t
1751	1751	FAC-001751	2024-08-23 14:56:41.76147	\N	4	t
1752	1752	FAC-001752	2024-10-20 10:24:52.33341	\N	3	t
1753	1753	FAC-001753	2024-09-30 05:44:35.794259	\N	8	t
1754	1754	FAC-001754	2024-12-19 17:51:31.894348	\N	2	t
1755	1755	FAC-001755	2024-07-13 19:13:53.773697	\N	2	t
1756	1756	FAC-001756	2024-12-10 05:23:40.526528	\N	6	t
1757	1757	FAC-001757	2025-05-02 08:44:07.40864	\N	8	t
1758	1758	FAC-001758	2025-01-22 11:18:46.140231	\N	3	t
1759	1759	FAC-001759	2024-12-07 01:24:48.610167	\N	2	t
1760	1760	FAC-001760	2025-05-10 04:47:42.503875	\N	8	t
1761	1761	FAC-001761	2024-07-02 22:08:01.235066	\N	8	t
1762	1762	FAC-001762	2024-07-31 04:35:08.289502	\N	5	t
1763	1763	FAC-001763	2024-09-08 22:46:20.935938	\N	6	t
1764	1764	FAC-001764	2025-02-13 05:54:08.19355	\N	5	t
1765	1765	FAC-001765	2025-05-15 04:57:59.645229	\N	10	t
1766	1766	FAC-001766	2024-11-04 15:59:26.813936	\N	4	t
1767	1767	FAC-001767	2025-02-17 14:02:53.340574	\N	7	t
1768	1768	FAC-001768	2024-12-02 18:11:48.843808	\N	1	t
1769	1769	FAC-001769	2025-01-27 00:51:18.711764	\N	3	t
1770	1770	FAC-001770	2025-01-30 19:40:38.250837	\N	6	t
1771	1771	FAC-001771	2024-11-29 17:22:29.036448	\N	8	t
1772	1772	FAC-001772	2025-04-30 17:11:38.326492	\N	4	t
1773	1773	FAC-001773	2024-12-01 23:00:00.279995	\N	7	t
1774	1774	FAC-001774	2024-08-25 03:54:13.520137	\N	7	t
1775	1775	FAC-001775	2024-08-09 03:46:52.031347	\N	3	t
1776	1776	FAC-001776	2024-12-13 21:25:04.880047	\N	3	t
1777	1777	FAC-001777	2024-07-14 19:05:46.562038	\N	8	t
1778	1778	FAC-001778	2025-06-01 23:08:03.577607	\N	3	t
1779	1779	FAC-001779	2024-07-03 14:47:27.945436	\N	8	t
1780	1780	FAC-001780	2025-01-03 22:20:46.981123	\N	10	t
1781	1781	FAC-001781	2024-10-30 04:28:40.22926	\N	7	t
1782	1782	FAC-001782	2025-02-06 02:42:46.065134	\N	5	t
1783	1783	FAC-001783	2024-06-21 23:04:37.678548	\N	5	t
1784	1784	FAC-001784	2024-08-29 09:41:22.11722	\N	6	t
1785	1785	FAC-001785	2024-08-26 11:41:25.06942	\N	1	t
1786	1786	FAC-001786	2024-09-05 04:29:55.75602	\N	4	t
1787	1787	FAC-001787	2024-06-26 15:25:40.460902	\N	10	t
1788	1788	FAC-001788	2025-03-30 18:17:01.023677	\N	5	t
1789	1789	FAC-001789	2025-01-20 04:53:53.919994	\N	9	t
1790	1790	FAC-001790	2025-01-21 15:18:20.590351	\N	3	t
1791	1791	FAC-001791	2024-08-28 23:43:10.626883	\N	1	t
1792	1792	FAC-001792	2024-12-30 23:38:08.036017	\N	7	t
1793	1793	FAC-001793	2024-11-03 09:53:15.076827	\N	6	t
1794	1794	FAC-001794	2025-01-01 22:26:26.025793	\N	10	t
1795	1795	FAC-001795	2024-11-06 12:09:28.705306	\N	2	t
1796	1796	FAC-001796	2025-05-25 18:24:26.022189	\N	2	t
1797	1797	FAC-001797	2024-08-07 05:27:54.825731	\N	4	t
1798	1798	FAC-001798	2024-12-10 20:53:40.055924	\N	6	t
1799	1799	FAC-001799	2024-11-01 13:48:00.652592	\N	7	t
1800	1800	FAC-001800	2025-04-17 11:11:06.515165	\N	3	t
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: erp_user
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	create tables	SQL	V1__create_tables.sql	-1740737734	erp_user	2025-06-12 17:56:51.334706	124	t
2	2	create views	SQL	V2__create_views.sql	1008539565	erp_user	2025-06-12 17:56:51.783136	23	t
3	3	create triggers	SQL	V3__create_triggers.sql	1596944880	erp_user	2025-06-12 17:56:51.886788	74	t
4	4	create stored procedures	SQL	V4__create_stored_procedures.sql	-1395138230	erp_user	2025-06-12 17:56:52.062973	100	t
5	5	massive data for sales history report	SQL	V5__massive_data_for_sales_history_report.sql	1765348780	erp_user	2025-06-12 17:56:52.263853	498	t
6	6	massive data for monthly billing report	SQL	V6__massive_data_for_monthly_billing_report.sql	-814044730	erp_user	2025-06-12 17:56:52.831043	137	t
7	7	create product categories and assignments	SQL	V7__create_product_categories_and_assignments.sql	-1148525472	erp_user	2025-06-12 17:56:53.02622	74	t
8	8	massive data for accounts receivable report	SQL	V8__massive_data_for_accounts_receivable_report.sql	1161712603	erp_user	2025-06-12 17:56:53.191837	233	t
9	9	create user roles and assignments	SQL	V9__create_user_roles_and_assignments.sql	275900445	erp_user	2025-06-17 08:48:56.563831	882	t
10	10	assign initial user roles	SQL	V10__assign_initial_user_roles.sql	-398590438	erp_user	2025-06-17 15:28:30.520785	123	t
\.


--
-- Data for Name: metodospago; Type: TABLE DATA; Schema: public; Owner: erp_user
--

COPY public.metodospago (metodopagoid, nombre, activo) FROM stdin;
1	Efectivo	t
2	Tarjeta de Crédito	t
3	Transferencia Bancaria	t
4	Pago Móvil	t
5	PayPal	t
\.


--
-- Data for Name: pagos; Type: TABLE DATA; Schema: public; Owner: erp_user
--

COPY public.pagos (pagoid, cuentaid, fechapago, monto, activo) FROM stdin;
1	2	2025-05-26 11:54:02.280093	2087.91	t
2	3	2024-12-27 13:44:03.782775	1994.41	t
3	5	2025-06-30 07:40:23.418473	112.24	t
4	6	2024-08-15 04:41:22.485605	1211.95	t
5	8	2024-09-15 09:25:24.218211	377.92	t
6	9	2025-03-01 09:23:04.341216	715.35	t
7	11	2025-05-17 00:13:56.153278	1481.34	t
8	12	2024-10-19 03:49:16.823596	3168.26	t
9	14	2024-08-10 06:28:56.033664	354.30	t
10	15	2025-03-03 02:31:46.157647	1557.87	t
11	17	2024-10-05 17:31:13.81861	978.18	t
12	18	2025-06-11 08:21:00.892579	1123.13	t
13	20	2025-02-23 03:10:18.555808	892.58	t
14	21	2024-09-02 08:29:30.680831	291.91	t
15	23	2025-01-29 16:56:58.41632	180.67	t
16	24	2024-11-26 12:12:58.835839	4037.35	t
17	26	2025-02-02 16:55:09.853847	1114.86	t
18	27	2024-09-26 06:56:33.751016	2718.43	t
19	29	2025-02-24 01:10:02.568059	2446.51	t
20	30	2025-05-23 02:55:55.204029	2297.73	t
21	32	2024-12-11 06:00:40.161255	71.08	t
22	33	2024-10-24 12:40:58.369488	4215.27	t
23	35	2024-12-05 03:04:05.850434	2209.23	t
24	36	2025-01-14 19:58:13.35038	1020.90	t
25	38	2025-04-20 05:46:18.061187	1599.14	t
26	39	2025-03-23 11:32:59.375384	2308.34	t
27	41	2025-04-24 15:50:23.497701	347.62	t
28	42	2024-09-24 11:25:29.310213	4146.34	t
29	44	2025-02-12 21:15:33.3895	829.44	t
30	45	2025-06-24 19:17:04.944672	1951.64	t
31	47	2025-02-26 14:25:10.048721	1029.16	t
32	48	2024-09-19 06:51:40.654376	4184.37	t
33	50	2024-09-13 05:04:08.349083	1757.14	t
34	51	2024-11-06 09:48:50.616652	1060.28	t
35	53	2025-06-23 02:55:43.9948	607.64	t
36	54	2025-03-26 09:18:29.273104	5022.74	t
37	56	2024-09-19 09:20:31.533823	1017.05	t
38	57	2024-12-04 06:36:38.156192	2605.76	t
39	59	2024-09-10 07:49:20.48509	1268.97	t
40	60	2025-04-30 12:54:55.677497	801.64	t
41	62	2025-06-03 11:04:57.845466	550.24	t
42	63	2024-09-21 02:15:56.1114	3956.61	t
43	65	2025-02-14 14:41:35.191917	997.49	t
44	66	2025-01-08 12:49:58.475156	1948.89	t
45	68	2025-03-12 18:15:23.811676	2416.07	t
46	69	2024-09-05 04:38:58.18644	3583.94	t
47	71	2024-12-20 11:17:49.719509	2134.76	t
48	72	2025-03-09 19:07:52.269492	3389.71	t
49	74	2025-04-16 10:44:01.185891	129.21	t
50	75	2025-04-16 20:21:13.511128	168.86	t
51	77	2025-05-10 20:45:37.48267	2288.00	t
52	78	2024-12-03 21:30:31.454707	2500.03	t
53	80	2024-08-22 06:06:11.061152	242.44	t
54	81	2024-11-19 09:11:24.222474	2588.73	t
55	83	2024-12-27 06:43:34.035926	2011.00	t
56	84	2025-05-04 10:08:04.057696	1844.74	t
57	86	2025-06-09 04:42:08.654658	1108.45	t
58	87	2024-10-30 04:32:32.308309	4930.83	t
59	89	2024-07-30 12:24:52.308748	1113.65	t
60	90	2025-02-22 01:28:55.435968	3884.94	t
61	92	2025-01-16 02:57:41.915086	70.29	t
62	93	2025-05-21 01:07:37.829804	4864.31	t
63	95	2025-06-29 13:35:59.255167	1773.05	t
64	96	2025-02-26 14:51:49.458025	4297.65	t
65	98	2024-11-07 17:34:32.708914	1816.00	t
66	99	2025-06-26 09:46:24.881154	4311.43	t
67	101	2025-06-27 05:58:56.915714	599.83	t
68	102	2024-11-21 20:12:51.709855	3837.13	t
69	104	2024-07-29 08:39:25.562199	1154.97	t
70	105	2025-05-24 08:13:40.636177	270.80	t
71	107	2025-06-10 19:23:30.673326	2084.69	t
72	108	2024-11-06 22:17:49.986058	82.45	t
73	110	2025-01-10 15:31:50.928486	904.44	t
74	111	2025-03-18 03:17:57.385619	3964.02	t
75	113	2024-09-26 17:30:10.341387	1549.78	t
76	114	2024-09-06 13:10:58.915161	4769.89	t
77	116	2025-04-12 01:33:08.811424	1609.68	t
78	117	2024-10-10 21:13:44.178926	1794.61	t
79	119	2024-09-07 19:47:24.954631	2040.88	t
80	120	2025-03-13 09:48:16.047071	1249.01	t
81	122	2024-12-24 09:12:14.50805	858.40	t
82	123	2024-07-29 17:22:48.653762	3071.82	t
83	125	2025-03-04 04:50:47.117042	1285.95	t
84	126	2024-12-15 05:38:08.742028	2467.02	t
85	128	2025-04-28 10:48:42.127627	158.41	t
86	129	2024-07-29 14:36:17.028378	248.53	t
87	131	2024-10-04 20:41:29.211508	2477.85	t
88	132	2025-02-20 19:34:27.566603	1791.92	t
89	134	2024-10-30 02:13:45.166173	449.36	t
90	135	2024-07-13 02:44:35.126114	3845.03	t
91	137	2025-03-30 11:17:24.953732	1200.38	t
92	138	2025-01-03 01:01:27.212123	3717.79	t
93	140	2024-11-27 03:50:05.006368	2365.47	t
94	141	2025-02-02 10:20:25.080094	2439.05	t
95	143	2025-04-15 04:24:16.552493	643.42	t
96	144	2024-07-16 13:09:32.109905	4698.76	t
97	146	2025-06-27 18:44:43.248257	1874.69	t
98	147	2024-08-18 05:22:12.312986	2206.35	t
99	149	2024-09-17 03:52:28.628484	521.76	t
100	150	2025-02-28 21:40:16.639511	2352.67	t
101	152	2024-07-24 06:02:52.404961	167.54	t
102	153	2024-09-10 21:56:35.023792	141.12	t
103	155	2025-03-18 17:50:04.123343	2009.20	t
104	156	2024-11-24 15:57:08.420987	2637.44	t
105	158	2025-05-25 08:06:22.560916	1038.00	t
106	159	2024-10-23 04:42:52.884499	3796.38	t
107	161	2024-07-11 06:48:36.625867	534.85	t
108	162	2025-03-10 06:40:57.725218	1975.86	t
109	164	2024-10-08 23:43:16.194872	2117.20	t
110	165	2025-01-10 03:34:23.632134	148.00	t
111	167	2025-04-04 15:51:03.110279	2144.65	t
112	168	2025-03-22 00:44:08.770402	4225.32	t
113	170	2024-10-26 05:12:03.364991	562.20	t
114	171	2024-08-18 20:04:10.454221	1815.50	t
115	173	2025-05-26 19:01:02.461161	462.43	t
116	174	2024-07-27 11:44:22.609224	1744.70	t
117	176	2025-06-13 12:34:52.712164	2297.37	t
118	177	2025-01-24 02:57:43.864003	3091.75	t
119	179	2025-01-16 09:27:33.141259	212.26	t
120	180	2025-04-02 14:44:43.115328	4985.66	t
121	182	2025-05-10 09:40:24.835541	1470.92	t
122	183	2025-06-21 08:10:05.884777	187.60	t
123	185	2024-12-08 11:04:58.574533	651.95	t
124	186	2025-06-15 22:29:54.80587	2374.73	t
125	188	2025-04-22 09:24:26.653493	2193.37	t
126	189	2025-07-02 16:14:52.393582	4421.39	t
127	191	2025-02-20 19:04:17.742236	2504.83	t
128	192	2025-06-23 18:59:42.696486	1448.15	t
129	194	2024-07-29 23:21:08.641878	1374.18	t
130	195	2025-05-21 06:58:35.607183	4535.10	t
131	197	2024-07-27 13:37:26.292084	503.35	t
132	198	2024-10-08 06:54:42.661777	3794.07	t
133	200	2024-08-28 00:45:36.406473	2024.22	t
134	201	2025-05-23 02:27:05.380306	1002.55	t
135	203	2025-01-03 11:24:17.827269	2017.03	t
136	204	2024-10-14 16:59:21.47458	4297.48	t
137	206	2024-09-05 15:06:26.742452	2061.40	t
138	207	2024-10-05 15:04:39.574911	3812.34	t
139	209	2025-01-07 05:21:45.53193	269.91	t
140	210	2025-01-14 22:46:18.802099	4598.29	t
141	212	2024-12-27 21:44:18.520615	1222.45	t
142	213	2024-08-01 02:58:00.166674	2989.80	t
143	215	2025-04-13 23:59:26.089749	106.23	t
144	216	2025-01-25 11:28:37.65197	281.83	t
145	218	2024-10-06 05:27:20.903079	2171.05	t
146	219	2024-11-29 20:39:08.492549	3239.14	t
147	221	2024-08-25 12:41:34.907822	1337.49	t
148	222	2025-01-03 00:19:18.736552	1942.56	t
149	224	2025-01-08 00:47:31.688788	645.14	t
150	225	2024-09-10 10:16:05.07805	589.13	t
151	227	2024-10-05 18:05:02.795048	958.45	t
152	228	2024-12-07 20:16:51.515267	4142.81	t
153	230	2025-04-23 08:36:48.820269	1723.99	t
154	231	2024-08-22 07:13:22.119695	1048.74	t
155	233	2025-06-20 08:51:48.029413	59.66	t
156	234	2024-08-25 12:53:56.666096	4322.55	t
157	236	2024-07-24 05:08:15.279798	2258.35	t
158	237	2025-01-12 09:46:36.6023	718.26	t
159	239	2024-08-06 18:51:41.710221	952.36	t
160	240	2025-05-07 02:36:43.359354	309.01	t
161	242	2025-02-27 14:24:44.399331	2372.43	t
162	243	2025-04-10 17:58:33.096818	4517.69	t
163	245	2024-10-06 22:28:36.574908	1384.41	t
164	246	2025-05-31 18:23:12.315656	3966.43	t
165	248	2025-02-07 17:55:22.903342	1118.93	t
166	249	2025-05-27 19:00:57.767271	2608.45	t
167	251	2025-05-06 10:25:18.781479	1863.83	t
168	252	2024-12-25 01:07:50.390422	4974.30	t
169	254	2024-09-03 11:37:21.202322	634.46	t
170	255	2025-05-25 05:13:10.493817	919.11	t
171	257	2024-11-03 09:30:38.326024	609.71	t
172	258	2024-10-27 16:54:10.993358	4749.27	t
173	260	2025-01-30 00:06:52.999171	896.78	t
174	261	2025-02-01 20:10:00.317767	2296.58	t
175	263	2025-04-05 01:44:54.551534	2312.40	t
176	264	2025-03-03 19:49:23.42701	4537.59	t
177	266	2025-01-06 11:43:49.956443	1528.54	t
178	267	2025-01-19 02:10:42.952456	2861.20	t
179	269	2025-06-05 04:56:29.514645	1111.87	t
180	270	2025-03-31 19:10:04.476437	1037.58	t
181	272	2025-06-02 17:24:29.188613	366.57	t
182	273	2024-12-16 01:13:17.795406	2747.29	t
183	275	2025-03-18 09:44:23.469252	1354.49	t
184	276	2025-02-26 21:55:20.84371	4712.36	t
185	278	2025-01-10 15:26:10.294068	328.30	t
186	279	2025-01-31 07:29:17.05373	1339.75	t
187	281	2025-01-24 10:26:48.872544	76.05	t
188	282	2025-04-03 01:31:27.530514	4816.05	t
189	284	2024-09-07 16:12:31.662164	1632.63	t
190	285	2024-08-21 21:10:30.295159	2888.41	t
191	287	2024-07-27 00:20:47.450865	2070.15	t
192	288	2024-08-22 22:02:56.982838	4229.64	t
193	290	2025-01-01 08:49:28.261706	1611.19	t
194	291	2024-12-20 03:48:46.812144	1453.03	t
195	293	2024-08-13 10:18:38.930085	2418.53	t
196	294	2024-12-04 03:43:16.736719	556.46	t
197	296	2024-12-01 09:56:42.082897	1794.22	t
198	297	2024-08-23 16:53:43.328025	765.04	t
199	299	2025-02-21 04:49:50.963233	968.94	t
200	300	2024-10-16 13:27:06.578663	4241.11	t
201	302	2024-11-07 07:41:25.545334	508.91	t
202	303	2025-05-31 05:26:18.884905	3290.26	t
203	305	2025-02-12 16:42:15.238683	998.14	t
204	306	2025-03-11 22:32:10.054534	3045.68	t
205	308	2024-11-07 00:46:41.037727	1120.09	t
206	309	2024-09-07 11:43:50.359468	2801.51	t
207	311	2024-12-12 22:16:46.203345	213.04	t
208	312	2025-01-26 19:57:46.89449	1804.17	t
209	314	2024-10-09 15:43:29.632694	2029.35	t
210	315	2025-01-03 00:55:41.202223	1874.09	t
211	317	2024-08-05 20:27:23.966388	1798.07	t
212	318	2025-02-19 14:13:48.645505	1615.31	t
213	320	2024-10-22 17:06:43.393289	807.07	t
214	321	2025-06-11 20:35:17.722371	4267.60	t
215	323	2025-05-01 21:35:26.107591	2100.83	t
216	324	2025-02-10 11:21:07.667168	484.06	t
217	326	2025-03-14 18:40:22.976042	2225.64	t
218	327	2024-11-07 02:04:08.666164	3431.37	t
219	329	2024-07-18 10:49:04.63924	2288.14	t
220	330	2024-07-06 18:17:39.887064	2339.76	t
221	332	2024-08-03 23:14:45.394591	1103.95	t
222	333	2025-05-27 18:21:17.9597	4882.12	t
223	335	2025-03-11 07:59:06.880985	1722.45	t
224	336	2025-06-12 07:48:41.465381	1637.35	t
225	338	2025-05-01 20:51:25.410246	2356.36	t
226	339	2024-11-06 08:20:14.459883	2701.86	t
227	341	2025-04-21 20:14:58.265653	2241.44	t
228	342	2025-05-01 21:06:22.495846	1646.18	t
229	344	2024-07-28 16:45:53.8324	826.27	t
230	345	2024-08-06 01:58:57.49504	760.04	t
231	347	2024-12-19 18:39:23.277732	86.42	t
232	348	2024-08-17 04:20:43.015296	1768.56	t
233	350	2024-09-12 02:09:30.976879	2320.31	t
234	351	2025-06-10 09:58:50.629136	4689.66	t
235	353	2025-04-20 01:25:21.105092	1924.14	t
236	354	2024-12-21 23:55:06.16551	2666.71	t
237	356	2024-11-15 05:25:33.840627	487.62	t
238	357	2025-04-04 01:30:03.531267	585.97	t
239	359	2024-09-07 00:10:42.004516	1905.13	t
240	360	2024-10-11 03:30:41.005469	1310.39	t
241	362	2025-02-13 17:56:51.196333	1546.01	t
242	363	2024-12-11 00:41:27.423931	575.51	t
243	365	2024-09-01 15:01:44.334384	569.81	t
244	366	2025-04-19 15:01:37.992485	2952.81	t
245	368	2024-08-23 06:08:06.221688	1523.94	t
246	369	2025-03-08 02:24:01.521278	3647.23	t
247	371	2025-03-25 15:11:41.679933	1330.31	t
248	372	2025-05-20 01:47:19.564812	3979.58	t
249	374	2025-06-27 05:21:15.658701	1681.96	t
250	375	2024-10-13 16:57:40.457254	1960.51	t
251	377	2025-06-12 11:37:28.804801	1682.15	t
252	378	2025-01-31 10:39:30.499069	2625.60	t
253	380	2024-09-28 17:01:13.472663	1365.76	t
254	381	2025-05-05 13:18:25.671268	2590.64	t
255	383	2025-01-29 00:13:42.302845	1811.92	t
256	384	2025-01-12 12:25:42.229758	2998.67	t
257	386	2025-01-21 14:41:08.865974	401.93	t
258	387	2024-11-14 21:56:53.178081	1617.09	t
259	389	2025-03-13 11:01:22.44974	1846.94	t
260	390	2024-12-30 06:30:09.069002	1335.23	t
261	392	2025-06-24 18:43:00.892966	1014.36	t
262	393	2025-06-23 03:30:10.069902	2086.76	t
263	395	2024-11-17 21:06:10.788855	1124.46	t
264	396	2024-10-03 05:35:49.066823	4386.20	t
265	398	2024-08-17 07:45:28.457788	1712.74	t
266	399	2024-08-01 04:15:38.919317	2644.17	t
267	401	2024-07-25 21:47:11.61699	859.54	t
268	402	2024-10-06 12:54:00.471344	1316.73	t
269	404	2024-09-30 00:48:07.275218	1998.03	t
270	405	2025-02-02 16:10:07.094017	4145.72	t
271	407	2025-01-15 17:13:29.53636	814.18	t
272	408	2025-02-11 06:44:06.781574	1704.13	t
273	410	2024-12-29 11:55:44.231523	1592.97	t
274	411	2024-12-26 05:35:24.757919	4962.68	t
275	413	2024-11-24 11:57:39.872113	1552.11	t
276	414	2024-09-29 21:00:20.747576	4596.85	t
277	416	2025-02-25 10:26:10.399138	1565.91	t
278	417	2024-10-10 07:42:06.465365	404.91	t
279	419	2024-12-23 21:30:19.833446	2476.54	t
280	420	2024-11-07 17:42:33.055173	3756.64	t
281	422	2025-06-18 13:11:05.060605	1108.16	t
282	423	2024-07-31 07:21:46.537923	5040.35	t
283	425	2025-02-20 01:53:46.971347	1432.36	t
284	426	2025-04-04 15:32:11.705786	1677.91	t
285	428	2024-07-29 08:15:45.659471	1149.27	t
286	429	2024-10-12 18:14:37.507033	2943.23	t
287	431	2025-01-24 14:48:21.903902	458.83	t
288	432	2024-12-26 00:51:16.320039	1916.75	t
289	434	2024-07-17 01:48:36.575047	982.22	t
290	435	2025-04-23 07:03:46.779366	4176.89	t
291	437	2025-05-14 12:11:35.590435	808.86	t
292	438	2024-07-13 15:42:31.360195	1824.83	t
293	440	2025-01-18 20:19:35.826663	1054.14	t
294	441	2024-12-17 03:59:26.795702	1899.03	t
295	443	2025-04-09 21:30:51.774943	2015.36	t
296	444	2025-06-06 09:23:15.473387	2153.67	t
297	446	2024-10-13 10:58:12.974964	1778.28	t
298	447	2025-03-07 03:18:18.783227	484.74	t
299	449	2024-09-25 22:22:57.598698	667.82	t
300	450	2025-03-31 04:44:15.494469	3823.58	t
301	452	2024-10-19 13:49:58.991668	1877.90	t
302	453	2024-09-30 08:35:50.540735	2775.67	t
303	455	2024-12-27 19:30:21.597241	2159.12	t
304	456	2024-10-27 09:46:57.642949	1646.73	t
305	458	2024-08-15 18:22:18.28396	1559.40	t
306	459	2025-01-16 09:19:08.777883	2815.79	t
307	461	2025-05-10 05:37:39.808657	1841.77	t
308	462	2024-09-22 02:47:30.492729	4274.23	t
309	464	2025-03-22 02:56:19.576924	748.53	t
310	465	2025-02-08 21:33:57.722358	2332.18	t
311	467	2024-08-16 01:26:18.476607	277.24	t
312	468	2024-10-03 04:46:18.742159	2236.93	t
313	470	2025-01-26 18:54:01.707041	654.27	t
314	471	2024-08-03 07:39:48.882539	444.96	t
315	473	2025-06-02 20:59:53.161336	414.99	t
316	474	2025-01-17 23:52:44.511521	3685.77	t
317	476	2024-11-08 11:19:56.800343	2208.09	t
318	477	2024-08-26 10:09:57.92629	4205.67	t
319	479	2024-12-24 10:07:50.229252	423.75	t
320	480	2025-05-04 02:51:47.769014	431.95	t
321	482	2024-12-18 15:14:36.02839	1939.24	t
322	483	2024-07-16 10:51:49.797845	2067.96	t
323	485	2024-08-30 09:29:59.813243	1636.85	t
324	486	2025-06-29 04:38:38.304246	3994.39	t
325	488	2024-10-03 07:26:00.360024	1837.03	t
326	489	2024-10-17 23:11:44.67223	3923.17	t
327	491	2025-05-08 04:15:04.380744	2270.44	t
328	492	2025-03-04 05:16:29.977869	2170.25	t
329	494	2024-07-21 17:10:34.491805	169.41	t
330	495	2024-08-18 01:23:10.253051	3111.26	t
331	497	2024-11-28 13:20:31.502211	1909.33	t
332	498	2024-08-10 20:49:06.580043	2227.27	t
333	500	2025-01-04 15:50:35.591933	1851.03	t
334	501	2025-05-06 10:07:29.889492	2613.37	t
335	503	2024-10-21 06:36:44.38881	1698.67	t
336	504	2025-01-29 16:25:08.698888	4341.37	t
337	506	2025-05-27 19:20:19.227598	2519.57	t
338	507	2025-01-16 15:43:32.123155	1994.60	t
339	509	2024-08-17 10:42:10.625621	895.36	t
340	510	2024-12-03 22:36:42.531075	3785.73	t
341	512	2025-04-27 11:11:25.371081	1874.91	t
342	513	2024-11-08 22:46:31.628925	2988.52	t
343	515	2024-09-13 21:56:32.707864	2242.40	t
344	516	2024-08-08 01:45:27.923021	4050.27	t
345	518	2025-04-08 22:20:27.185845	2098.01	t
346	519	2025-02-24 15:26:43.959187	208.55	t
347	521	2025-01-28 00:21:52.833971	1182.47	t
348	522	2025-01-10 09:41:55.695006	434.43	t
349	524	2024-08-13 00:32:57.834306	1228.05	t
350	525	2025-03-12 09:32:33.75986	1889.98	t
351	527	2025-06-11 20:34:44.812775	229.13	t
352	528	2024-07-26 18:40:50.229362	3464.95	t
353	530	2024-10-31 20:54:36.401408	328.11	t
354	531	2025-04-14 17:47:52.761853	4514.72	t
355	533	2024-07-14 18:22:46.573253	817.40	t
356	534	2025-05-05 12:46:00.007647	3627.58	t
357	536	2025-02-10 07:25:46.192746	286.10	t
358	537	2025-06-04 01:21:42.012592	3563.27	t
359	539	2024-10-29 04:34:34.792045	2214.55	t
360	540	2024-09-19 17:13:03.809121	3151.13	t
361	542	2024-09-11 16:31:24.660763	762.86	t
362	543	2024-12-13 06:14:24.415552	513.52	t
363	545	2024-12-03 00:00:18.237262	1387.62	t
364	546	2024-11-28 16:28:20.494662	795.56	t
365	548	2024-11-17 23:12:57.391325	1303.54	t
366	549	2025-03-19 12:11:57.873677	1166.91	t
367	551	2024-10-26 02:44:54.221681	1470.76	t
368	552	2025-06-21 22:29:38.551416	845.23	t
369	554	2025-07-01 14:31:48.29327	2346.96	t
370	555	2024-12-14 19:20:49.699118	4647.16	t
371	557	2025-05-24 13:12:54.294466	2110.51	t
372	558	2024-12-04 03:53:43.150329	4302.98	t
373	560	2024-07-05 08:27:41.199109	795.96	t
374	561	2025-06-20 16:34:12.783292	1176.85	t
375	563	2024-10-30 01:14:09.506612	1479.77	t
376	564	2024-10-01 02:47:25.794446	705.43	t
377	566	2024-08-16 04:24:00.140889	1347.89	t
378	567	2024-11-21 23:03:13.159037	4591.32	t
379	569	2025-06-18 17:16:26.944897	698.99	t
380	570	2024-09-14 09:59:27.177435	3636.17	t
381	572	2024-12-31 09:53:46.095513	2220.13	t
382	573	2025-01-29 11:27:45.682774	2391.31	t
383	575	2025-02-23 12:44:40.688613	384.43	t
384	576	2024-09-09 21:48:01.133582	4391.17	t
385	578	2024-12-09 06:05:38.692007	1483.30	t
386	579	2025-04-15 03:32:33.975925	4276.61	t
387	581	2025-02-20 13:25:28.754245	1206.36	t
388	582	2025-06-20 15:57:06.679725	2836.81	t
389	584	2024-12-23 21:42:42.728073	1493.85	t
390	585	2024-09-12 11:21:29.755666	1796.84	t
391	587	2025-05-03 04:29:27.675426	2368.03	t
392	588	2025-03-27 21:52:59.719729	568.07	t
393	590	2024-09-03 13:02:48.135016	2359.20	t
394	591	2024-12-13 04:39:28.239129	5018.98	t
395	593	2024-10-07 14:58:55.118626	834.34	t
396	594	2024-07-12 03:07:26.853197	3298.54	t
397	596	2025-01-26 11:02:58.018933	447.58	t
398	597	2024-09-21 21:22:38.195006	2484.80	t
399	599	2025-03-30 14:12:46.065599	881.33	t
400	600	2025-04-18 21:07:03.662513	3791.03	t
401	602	2024-07-07 18:08:01.213716	758.40	t
402	603	2025-01-20 07:50:28.187526	3829.94	t
403	605	2025-02-10 09:28:20.292808	2106.95	t
404	606	2024-07-07 08:54:47.658245	4024.14	t
405	608	2024-12-31 13:31:25.649164	2287.36	t
406	609	2024-12-03 04:08:27.571045	2922.68	t
407	611	2025-01-30 08:56:48.685019	1009.78	t
408	612	2025-05-28 11:13:27.555028	1444.03	t
409	614	2025-02-18 12:48:57.549487	166.40	t
410	615	2024-11-11 04:48:44.523155	2625.63	t
411	617	2024-12-21 12:57:58.151959	956.92	t
412	618	2025-02-11 19:21:36.277656	1006.50	t
413	620	2024-12-16 09:15:10.361566	253.93	t
414	621	2025-06-13 12:47:03.998601	1927.05	t
415	623	2024-07-27 16:57:55.178516	312.25	t
416	624	2025-06-19 10:19:18.138349	1810.92	t
417	626	2025-04-10 12:34:59.629764	67.77	t
418	627	2024-08-12 22:12:13.500637	5048.21	t
419	629	2025-01-09 12:56:02.502908	1397.39	t
420	630	2024-10-22 15:33:18.58379	2086.98	t
421	632	2025-01-27 02:50:51.050083	573.49	t
422	633	2025-01-06 22:26:10.709754	2386.93	t
423	635	2025-01-06 22:41:50.48512	473.10	t
424	636	2025-03-10 22:13:50.087829	2207.39	t
425	638	2025-03-21 01:07:08.954593	442.03	t
426	639	2024-10-12 09:57:13.777768	2994.21	t
427	641	2024-07-13 16:10:40.97823	1125.42	t
428	642	2024-12-30 02:17:23.285993	4983.90	t
429	644	2024-08-21 12:01:24.279936	485.94	t
430	645	2024-09-06 17:14:32.907696	1835.73	t
431	647	2025-06-26 22:55:37.149245	1013.95	t
432	648	2025-01-02 18:27:19.145245	3331.26	t
433	650	2024-10-19 20:54:17.383158	1317.77	t
434	651	2025-01-25 06:18:22.245596	1574.34	t
435	653	2024-09-13 20:49:03.576056	648.97	t
436	654	2024-08-01 09:22:52.722592	4963.99	t
437	656	2024-10-07 03:24:02.421424	454.31	t
438	657	2024-12-18 02:49:50.583703	2256.65	t
439	659	2024-12-18 05:04:22.860628	1236.82	t
440	660	2025-05-06 19:52:23.754699	2340.93	t
441	662	2025-03-29 01:09:30.223826	486.80	t
442	663	2025-04-13 23:57:17.226302	2128.45	t
443	665	2025-03-21 04:48:21.159341	1897.49	t
444	666	2025-05-18 15:18:07.597908	3214.93	t
445	668	2024-12-17 22:00:16.510878	2216.51	t
446	669	2025-05-10 14:25:43.605053	3135.24	t
447	671	2025-06-02 08:19:10.995025	93.46	t
448	672	2025-05-22 19:03:44.161285	332.60	t
449	674	2024-09-30 01:32:50.510007	2511.15	t
450	675	2024-09-25 16:38:33.587967	4858.11	t
451	677	2024-10-17 08:20:35.382602	1119.13	t
452	678	2024-07-03 19:19:02.348498	4639.85	t
453	680	2025-03-11 08:09:02.175717	1703.87	t
454	681	2025-05-22 16:30:44.262211	3429.11	t
455	683	2024-10-20 05:00:49.039948	1297.19	t
456	684	2024-10-17 14:46:27.528543	4443.97	t
457	686	2025-06-11 05:00:20.914175	2094.37	t
458	687	2025-01-22 05:54:23.722126	1475.33	t
459	689	2024-11-09 07:59:53.204974	845.26	t
460	690	2025-02-23 00:39:59.902258	1470.32	t
461	692	2025-03-30 01:36:26.725792	2291.34	t
462	693	2025-02-11 21:49:14.28235	4208.08	t
463	695	2025-03-02 11:45:00.562109	1544.92	t
464	696	2024-12-19 01:40:32.911417	2927.78	t
465	698	2025-04-14 07:36:22.699265	2520.40	t
466	699	2024-12-17 05:25:32.832257	2370.96	t
467	701	2024-08-24 20:24:34.702874	1202.53	t
468	702	2024-08-06 23:59:17.090835	2856.82	t
469	704	2025-01-28 15:08:50.565079	426.37	t
470	705	2025-05-22 01:32:20.386954	641.38	t
471	707	2025-06-15 00:07:56.857101	417.22	t
472	708	2025-01-14 11:55:44.681358	2103.04	t
473	710	2024-11-02 11:19:19.970748	1139.04	t
474	711	2024-08-15 11:45:23.663265	2006.35	t
475	713	2025-01-30 06:33:27.227271	1463.18	t
476	714	2024-11-09 10:41:50.052503	4328.70	t
477	716	2024-11-27 12:04:23.340577	2322.28	t
478	717	2025-03-09 12:01:37.855047	520.97	t
479	719	2025-03-22 00:48:53.468075	947.73	t
480	720	2025-02-03 08:29:44.1226	4965.63	t
481	722	2025-03-24 16:42:16.39389	2132.79	t
482	723	2024-11-05 02:29:11.141728	2175.72	t
483	725	2025-01-01 12:06:59.33408	165.44	t
484	726	2024-10-15 18:06:38.93978	4280.62	t
485	728	2024-08-17 20:44:14.614763	1123.69	t
486	729	2024-09-24 01:18:22.551132	4752.75	t
487	731	2025-03-18 01:09:55.442321	2441.73	t
488	732	2024-07-31 18:41:27.323773	1553.99	t
489	734	2025-06-03 00:10:21.118246	2240.55	t
490	735	2025-06-27 17:00:54.015095	330.16	t
491	737	2025-02-03 08:49:04.259857	1652.20	t
492	738	2025-04-14 01:24:46.44164	1837.81	t
493	740	2024-09-09 19:10:25.202352	472.51	t
494	741	2024-08-08 18:05:29.336048	4652.37	t
495	743	2025-06-20 12:19:36.485003	663.38	t
496	744	2024-11-10 04:35:31.315619	4748.27	t
497	746	2025-04-21 05:44:12.599892	2416.68	t
498	747	2025-07-01 14:29:30.088685	1673.38	t
499	749	2024-07-13 08:54:49.805061	1036.38	t
500	750	2024-12-27 05:32:25.429349	1193.73	t
501	752	2025-01-31 02:44:24.874475	1541.05	t
502	753	2025-03-20 20:54:55.26304	2412.58	t
503	755	2024-07-15 23:37:50.67789	2300.96	t
504	756	2024-11-25 10:29:33.039005	1179.88	t
505	758	2024-07-22 07:04:13.070365	1774.08	t
506	759	2024-08-14 14:01:32.925716	4427.71	t
507	761	2025-02-19 03:58:37.740348	1242.55	t
508	762	2025-02-14 05:08:30.792522	3390.28	t
509	764	2025-05-05 02:55:09.083778	790.49	t
510	765	2024-09-16 17:24:07.097179	4571.92	t
511	767	2025-05-31 17:50:57.982162	360.52	t
512	768	2025-02-02 15:26:05.457989	2713.53	t
513	770	2024-10-22 13:22:39.812783	2434.02	t
514	771	2024-08-11 20:05:10.562733	5010.31	t
515	773	2024-07-26 13:57:43.809482	842.38	t
516	774	2024-08-18 17:57:44.683457	2307.01	t
517	776	2025-01-17 12:15:09.203358	2392.30	t
518	777	2024-08-19 01:48:13.701368	3025.17	t
519	779	2024-08-14 06:46:56.701654	1740.29	t
520	780	2025-02-20 20:56:59.532981	3169.01	t
521	782	2025-02-25 14:37:36.789816	361.42	t
522	783	2025-06-04 14:20:59.371516	4210.53	t
523	785	2024-12-26 19:37:14.310613	1089.20	t
524	786	2025-06-22 12:08:59.758678	1454.89	t
525	788	2024-08-16 15:10:18.780096	2022.44	t
526	789	2024-08-21 10:54:47.452626	4061.69	t
527	791	2025-06-04 19:43:23.561061	2041.34	t
528	792	2024-11-12 01:30:35.857103	3480.19	t
529	794	2025-02-05 14:24:50.915787	252.30	t
530	795	2024-12-20 09:15:34.816731	1946.81	t
531	797	2024-09-30 16:28:53.960897	1098.02	t
532	798	2024-07-13 23:41:14.624863	1265.70	t
533	800	2024-07-24 20:17:28.86588	2150.44	t
534	801	2025-05-24 12:29:43.972968	568.41	t
535	803	2024-08-10 19:59:20.972529	1658.88	t
536	804	2025-04-13 19:01:20.047421	2387.94	t
537	806	2024-10-16 04:48:37.400136	2174.96	t
538	807	2025-01-03 02:13:57.646462	3183.78	t
539	809	2024-08-19 18:40:31.304815	1723.15	t
540	810	2025-05-28 03:13:07.911683	3306.88	t
541	812	2025-02-10 01:51:25.201995	1760.08	t
542	813	2025-01-02 08:02:39.827291	2046.75	t
543	815	2024-09-04 00:58:51.894141	458.23	t
544	816	2024-11-11 14:30:33.259391	2670.47	t
545	818	2025-01-24 08:16:31.739835	314.98	t
546	819	2025-05-06 19:12:33.622788	2167.61	t
547	821	2025-03-19 09:24:56.629433	807.54	t
548	822	2025-05-04 12:14:23.815123	4452.95	t
549	824	2024-10-15 05:54:48.100257	1860.73	t
550	825	2025-05-06 17:41:18.267292	4001.64	t
551	827	2024-10-05 15:27:07.345674	1758.18	t
552	828	2024-12-04 07:28:48.999225	1831.30	t
553	830	2025-02-06 18:50:58.670615	1782.26	t
554	831	2024-07-06 09:03:20.623997	4876.43	t
555	833	2024-10-07 23:35:09.839498	1553.36	t
556	834	2024-12-02 06:27:40.215049	3584.53	t
557	836	2025-03-06 01:40:41.18674	621.27	t
558	837	2025-07-01 02:57:52.38182	2391.81	t
559	839	2024-12-21 03:03:12.137166	1420.57	t
560	840	2025-05-22 13:24:26.031785	3341.37	t
561	842	2025-04-19 09:28:53.161823	175.08	t
562	843	2024-08-04 12:18:34.371353	3226.81	t
563	845	2024-09-06 23:20:16.174001	2408.86	t
564	846	2024-11-07 21:38:16.454641	1910.20	t
565	848	2024-08-25 03:38:09.692835	2252.12	t
566	849	2025-05-21 13:51:54.274788	3356.19	t
567	851	2024-08-27 22:01:26.828881	468.52	t
568	852	2025-01-22 22:41:35.784237	1041.79	t
569	854	2025-04-04 19:22:01.958389	173.29	t
570	855	2025-05-15 00:43:00.28376	1791.72	t
571	857	2024-09-06 17:16:17.538739	1365.21	t
572	858	2025-05-30 14:16:55.447879	668.97	t
573	860	2024-10-16 03:04:24.681906	2391.60	t
574	861	2025-06-15 00:31:13.552359	2695.62	t
575	863	2024-11-25 13:40:13.787704	594.90	t
576	864	2024-11-26 00:44:25.471377	2968.35	t
577	866	2025-02-07 13:30:17.063065	134.98	t
578	867	2025-07-02 13:39:16.013764	1775.57	t
579	869	2025-05-09 16:39:17.315384	333.57	t
580	870	2024-09-28 09:34:55.16902	435.50	t
581	872	2024-10-01 02:10:37.572442	1619.40	t
582	873	2024-07-27 14:29:19.784977	4692.13	t
583	875	2025-02-27 14:09:26.325501	1342.37	t
584	876	2025-02-21 02:13:20.711258	900.78	t
585	878	2025-01-19 04:07:37.706631	1270.11	t
586	879	2024-10-08 07:56:08.930961	1765.52	t
587	881	2025-04-23 07:09:49.577677	667.49	t
588	882	2024-09-20 16:34:40.327148	2935.51	t
589	884	2025-03-27 19:10:44.437496	281.36	t
590	885	2025-06-18 11:54:26.065268	2727.09	t
591	887	2024-11-17 22:50:14.266608	1307.03	t
592	888	2025-02-15 21:14:54.44681	2472.18	t
593	890	2025-05-16 05:54:26.02702	1089.55	t
594	891	2024-07-13 07:06:21.670649	541.45	t
595	893	2025-05-05 12:40:41.703261	657.69	t
596	894	2025-04-05 12:44:03.2399	1113.28	t
597	896	2025-04-02 11:38:46.11685	2109.52	t
598	897	2025-03-26 15:58:00.29646	2014.19	t
599	899	2025-01-03 00:32:54.942373	351.87	t
600	900	2024-09-05 19:05:55.194271	4612.40	t
601	902	2024-11-14 17:02:25.191277	819.27	t
602	903	2025-05-18 02:03:02.315203	1850.74	t
603	905	2024-08-29 14:05:02.400695	933.63	t
604	906	2025-05-12 22:26:19.516188	2161.10	t
605	908	2025-03-17 09:06:22.230489	858.77	t
606	909	2025-01-27 13:52:08.688269	1357.97	t
607	911	2025-02-08 11:56:20.716243	548.43	t
608	912	2024-12-15 08:37:52.412902	811.92	t
609	914	2024-10-01 16:43:05.777134	1088.77	t
610	915	2024-11-28 02:46:02.30467	2887.97	t
611	917	2024-10-03 11:23:15.758012	1020.13	t
612	918	2025-05-25 06:00:00.208409	537.53	t
613	920	2024-09-04 11:35:08.614171	960.10	t
614	921	2024-07-12 09:23:10.010879	2217.72	t
615	923	2025-05-16 19:55:31.967074	2157.54	t
616	924	2024-12-05 21:17:44.344905	2639.76	t
617	926	2024-10-11 20:16:16.133805	658.90	t
618	927	2025-05-12 13:09:29.363791	2115.02	t
619	929	2025-03-14 18:18:20.23467	1459.16	t
620	930	2025-01-17 22:47:23.545002	220.89	t
621	932	2025-05-01 02:27:11.271925	732.37	t
622	933	2025-06-11 06:26:03.854972	3392.73	t
623	935	2025-02-10 22:53:47.937782	229.65	t
624	936	2024-08-01 11:34:05.594794	2250.16	t
625	938	2025-02-20 01:04:56.345502	2521.87	t
626	939	2025-04-24 21:50:27.474779	1243.01	t
627	941	2024-07-27 16:54:02.976946	426.93	t
628	942	2025-03-18 13:10:45.014508	2772.36	t
629	944	2025-02-04 08:08:46.251405	427.52	t
630	945	2024-11-29 13:50:19.532175	4110.73	t
631	947	2025-05-16 20:33:38.195175	2353.65	t
632	948	2024-11-22 11:47:13.033553	4973.29	t
633	950	2024-11-12 15:45:51.872267	721.19	t
634	951	2024-08-07 02:39:09.125496	4867.94	t
635	953	2024-07-20 15:49:24.420296	586.19	t
636	954	2024-11-03 15:33:27.788316	950.69	t
637	956	2024-10-15 11:26:40.258812	1338.64	t
638	957	2025-06-20 19:58:25.718291	489.80	t
639	959	2024-07-21 10:46:00.63781	1759.68	t
640	960	2024-09-27 17:44:25.891874	4400.43	t
641	962	2025-05-17 05:47:05.584898	1190.30	t
642	963	2024-11-27 16:27:19.951403	1288.05	t
643	965	2024-10-08 05:20:59.446459	1487.64	t
644	966	2024-12-09 09:10:03.748083	1593.22	t
645	968	2024-07-07 07:50:26.819737	233.13	t
646	969	2024-09-13 18:39:36.575038	549.64	t
647	971	2025-03-10 18:06:56.68109	1802.95	t
648	972	2024-11-18 14:40:45.410147	158.18	t
649	974	2024-07-14 04:21:10.878774	1044.60	t
650	975	2025-01-08 19:16:06.075777	402.23	t
651	977	2024-12-25 02:05:57.108677	1218.85	t
652	978	2024-11-04 00:28:30.882048	2102.54	t
653	980	2024-07-12 21:23:18.061199	898.68	t
654	981	2025-05-12 07:20:32.092872	4290.48	t
655	983	2025-04-19 06:42:50.261694	2038.30	t
656	984	2025-02-28 14:06:18.438315	2764.93	t
657	986	2025-06-19 02:16:03.525314	1278.89	t
658	987	2025-05-24 16:27:34.111749	2964.81	t
659	989	2024-07-30 05:12:14.183157	2269.48	t
660	990	2025-02-03 04:12:56.934352	1655.71	t
661	992	2024-07-31 02:42:01.982442	2062.69	t
662	993	2025-03-23 14:13:52.180414	4326.52	t
663	995	2024-09-19 15:38:34.74578	832.35	t
664	996	2024-11-26 03:05:37.182496	2520.84	t
665	998	2024-12-31 18:07:45.587061	1312.44	t
666	999	2025-02-16 08:30:21.213131	3377.17	t
667	1001	2025-01-18 14:38:00.595968	662.15	t
668	1002	2024-12-09 18:59:33.4707	333.81	t
669	1004	2025-03-16 13:52:07.653661	258.70	t
670	1005	2025-06-30 00:28:52.457784	4630.10	t
671	1007	2025-04-26 01:09:43.383278	2060.48	t
672	1008	2024-10-19 18:11:45.883141	3623.18	t
673	1010	2025-05-18 02:49:54.394396	2385.42	t
674	1011	2025-04-12 00:26:27.667744	4023.23	t
675	1013	2024-09-30 08:57:32.940064	687.38	t
676	1014	2024-08-18 05:30:16.143439	2308.81	t
677	1016	2024-10-22 08:05:51.391758	298.85	t
678	1017	2025-01-16 13:47:25.671121	634.72	t
679	1019	2025-05-03 04:37:01.452452	43.50	t
680	1020	2025-05-03 01:11:48.819172	4089.85	t
681	1022	2025-02-24 23:46:17.411026	944.48	t
682	1023	2025-02-04 10:32:57.787247	4829.40	t
683	1025	2025-04-17 10:50:17.102498	2300.49	t
684	1026	2024-10-21 16:04:26.894677	1357.62	t
685	1028	2025-01-27 00:06:24.305235	377.97	t
686	1029	2024-10-26 10:46:19.937445	4365.87	t
687	1031	2024-11-15 06:53:11.601186	992.79	t
688	1032	2025-01-07 00:27:25.506121	2764.62	t
689	1034	2024-12-14 22:28:56.60552	1793.81	t
690	1035	2024-10-03 15:43:09.80009	231.98	t
691	1037	2024-10-11 20:30:07.635579	1823.21	t
692	1038	2024-08-12 12:40:49.576675	691.71	t
693	1040	2024-12-31 23:53:02.891022	2164.91	t
694	1041	2024-08-04 14:26:22.810708	4199.49	t
695	1043	2025-03-13 18:21:45.548658	1192.61	t
696	1044	2025-06-18 10:58:37.078531	4351.80	t
697	1046	2024-09-26 23:10:31.594218	1441.74	t
698	1047	2025-06-15 22:30:37.721006	3426.06	t
699	1049	2024-08-14 17:11:13.891938	1583.94	t
700	1050	2024-12-19 02:43:00.348326	161.72	t
701	1052	2024-11-25 09:07:45.053591	1765.35	t
702	1053	2025-05-30 13:30:53.811368	2538.68	t
703	1055	2024-07-13 00:33:23.44695	2370.10	t
704	1056	2024-12-06 13:02:51.398162	4990.01	t
705	1058	2025-01-06 22:06:53.814328	1553.85	t
706	1059	2024-10-09 21:31:49.19151	2935.34	t
707	1061	2025-06-03 02:50:39.568623	1604.51	t
708	1062	2024-09-26 17:25:39.506316	4629.71	t
709	1064	2024-11-26 05:45:15.107414	217.76	t
710	1065	2024-10-19 19:09:12.947428	3611.83	t
711	1067	2025-05-25 02:37:23.130877	2339.58	t
712	1068	2025-01-31 20:38:51.192633	4392.27	t
713	1070	2024-08-26 22:12:46.618583	1244.98	t
714	1071	2025-06-12 17:24:03.145171	3191.73	t
715	1073	2025-02-01 01:15:31.834038	493.83	t
716	1074	2024-07-16 01:09:50.614547	2465.05	t
717	1076	2024-12-04 13:17:27.04053	2435.65	t
718	1077	2024-08-05 19:12:00.663968	4769.90	t
719	1079	2025-02-03 06:00:16.332351	1689.55	t
720	1080	2024-07-08 07:21:24.385196	1742.34	t
721	1082	2024-09-30 00:54:01.18067	508.40	t
722	1083	2025-06-20 01:04:16.962388	1087.00	t
723	1085	2024-09-22 15:29:22.825646	898.91	t
724	1086	2024-09-06 22:03:00.671496	2652.43	t
725	1088	2024-07-28 11:36:37.056377	1197.55	t
726	1089	2024-08-12 16:25:52.257342	2700.83	t
727	1091	2025-01-19 17:47:52.940023	332.49	t
728	1092	2024-07-26 14:05:15.687702	3590.96	t
729	1094	2024-10-13 08:08:15.061733	251.36	t
730	1095	2025-04-15 00:18:54.481375	941.29	t
731	1097	2024-08-24 15:25:39.361671	609.73	t
732	1098	2024-10-08 15:45:13.868837	682.11	t
733	1100	2024-08-01 20:53:01.4125	444.91	t
734	1101	2024-11-18 22:59:14.131385	1671.11	t
735	1103	2025-03-08 04:38:31.809992	1894.26	t
736	1104	2024-09-17 05:00:18.576065	1916.23	t
737	1106	2024-10-22 05:16:52.828713	1806.40	t
738	1107	2024-08-20 04:26:08.18889	768.28	t
739	1109	2025-06-27 03:00:44.659475	409.11	t
740	1110	2024-11-05 23:41:39.453222	2750.76	t
741	1112	2025-05-06 17:10:02.726262	2319.48	t
742	1113	2024-08-10 20:07:04.286243	4662.12	t
743	1115	2024-11-05 18:11:30.9162	2260.46	t
744	1116	2025-05-31 05:26:09.487458	1161.55	t
745	1118	2024-10-12 21:29:15.636639	360.53	t
746	1119	2025-05-12 00:19:37.279644	1038.31	t
747	1121	2025-06-15 12:05:15.348518	149.47	t
748	1122	2024-07-10 11:45:53.56727	1688.15	t
749	1124	2025-03-16 21:35:08.774467	2056.84	t
750	1125	2024-11-27 17:55:43.22369	2833.37	t
751	1127	2024-07-12 12:48:26.348651	782.80	t
752	1128	2025-01-04 06:59:30.103451	917.22	t
753	1130	2024-07-14 01:06:21.190749	531.64	t
754	1131	2025-03-29 11:04:25.542595	1502.54	t
755	1133	2024-10-24 22:02:30.976339	1887.25	t
756	1134	2025-02-10 15:37:17.417859	1624.10	t
757	1136	2024-09-03 20:25:48.112573	658.80	t
758	1137	2025-06-13 12:22:35.435384	5024.44	t
759	1139	2024-07-18 21:29:16.36263	1103.60	t
760	1140	2024-10-30 19:16:05.118433	668.89	t
761	1142	2025-04-27 03:24:39.078912	796.28	t
762	1143	2024-08-09 04:26:56.437638	1924.02	t
763	1145	2024-11-02 12:30:14.774574	1371.44	t
764	1146	2025-02-10 03:03:07.383703	4009.61	t
765	1148	2025-02-26 20:36:09.454383	2156.59	t
766	1149	2024-07-09 09:54:01.955079	1705.69	t
767	1151	2024-11-23 10:28:42.646325	114.69	t
768	1152	2024-08-18 08:44:58.509502	996.85	t
769	1154	2024-11-18 22:39:35.02582	2073.47	t
770	1155	2025-05-19 02:15:31.571923	3239.93	t
771	1157	2024-12-07 21:45:03.278994	510.98	t
772	1158	2024-10-19 11:04:17.616783	1941.06	t
773	1160	2024-11-28 16:47:19.026016	1843.63	t
774	1161	2025-04-20 04:33:25.852453	2422.21	t
775	1163	2025-06-19 14:50:56.777168	2067.39	t
776	1164	2024-07-20 08:07:53.528472	3466.68	t
777	1166	2025-02-22 00:38:31.126553	1081.37	t
778	1167	2025-06-26 04:33:02.020718	3222.72	t
779	1169	2025-03-20 10:52:19.877104	2207.85	t
780	1170	2024-08-02 05:02:52.492133	1512.03	t
781	1172	2024-11-07 02:01:38.357962	1676.95	t
782	1173	2025-01-28 10:44:54.099931	887.87	t
783	1175	2024-11-29 16:49:42.290048	1328.99	t
784	1176	2025-05-23 21:54:48.06593	593.38	t
785	1178	2025-06-15 22:39:05.254813	290.06	t
786	1179	2024-10-28 08:40:57.637825	1591.40	t
787	1181	2024-10-28 11:14:50.479501	1885.28	t
788	1182	2025-01-13 05:02:19.019624	4843.48	t
789	1184	2025-03-28 08:34:21.230196	2453.84	t
790	1185	2025-05-10 22:15:25.256804	1384.82	t
791	1187	2024-12-21 23:47:12.647021	2122.76	t
792	1188	2024-08-14 14:55:36.82073	4201.39	t
793	1190	2025-02-01 07:50:47.293382	1055.62	t
794	1191	2024-11-03 13:35:47.525959	4208.85	t
795	1193	2024-08-20 00:46:30.283116	2183.79	t
796	1194	2024-11-24 17:26:43.964013	3624.87	t
797	1196	2025-02-12 00:42:45.056958	2131.05	t
798	1197	2025-03-29 18:52:56.696639	4030.26	t
799	1199	2024-09-25 12:51:57.98033	1643.80	t
800	1200	2025-02-17 19:52:19.49634	4904.16	t
801	1202	2025-03-02 11:53:49.538173	239.42	t
802	1203	2025-01-12 21:19:42.222684	4466.40	t
803	1205	2025-05-12 07:20:46.547427	2185.40	t
804	1206	2024-09-15 13:21:40.148881	1120.47	t
805	1208	2025-01-05 10:12:21.017958	1092.63	t
806	1209	2025-07-01 06:11:50.838896	1927.28	t
807	1211	2025-02-06 15:07:11.313818	891.66	t
808	1212	2024-12-30 03:25:22.827939	4569.96	t
809	1214	2024-08-17 23:18:20.432779	759.91	t
810	1215	2025-05-21 19:57:15.238793	2649.98	t
811	1217	2024-07-16 16:51:01.014417	2405.46	t
812	1218	2024-08-12 21:39:36.960115	4358.23	t
813	1220	2025-02-21 01:09:51.002197	1889.71	t
814	1221	2025-03-13 00:14:47.683139	1663.60	t
815	1223	2024-10-27 02:23:44.156032	1400.18	t
816	1224	2024-12-15 22:06:44.527118	3217.48	t
817	1226	2024-09-09 03:10:52.747612	1621.09	t
818	1227	2025-01-06 22:41:11.638439	2162.04	t
819	1229	2024-09-17 17:16:49.767194	1009.27	t
820	1230	2024-12-03 02:49:38.75128	2788.54	t
821	1232	2024-07-21 12:29:22.860247	246.37	t
822	1233	2024-08-09 22:11:15.307208	448.49	t
823	1235	2025-05-17 12:25:39.144959	832.36	t
824	1236	2024-12-10 11:34:13.530462	4510.37	t
825	1238	2024-08-26 09:59:25.303285	1097.86	t
826	1239	2025-05-21 00:10:58.851798	2595.52	t
827	1241	2025-01-25 15:30:14.616306	1532.06	t
828	1242	2025-06-20 17:31:06.885357	154.36	t
829	1244	2024-07-29 04:42:57.644505	2493.26	t
830	1245	2025-06-21 03:28:02.169661	459.49	t
831	1247	2025-04-26 10:55:43.766302	725.28	t
832	1248	2024-11-04 11:30:36.515273	131.50	t
833	1250	2024-11-17 05:15:03.493578	360.20	t
834	1251	2024-08-10 10:47:00.060311	2940.17	t
835	1253	2024-10-02 03:44:28.044968	1518.56	t
836	1254	2024-07-07 20:07:54.944373	862.77	t
837	1256	2025-01-10 19:49:01.873271	1613.52	t
838	1257	2025-01-22 19:42:49.310421	3590.07	t
839	1259	2024-12-27 22:13:44.250508	2502.83	t
840	1260	2025-04-27 18:21:54.59146	1475.31	t
841	1262	2024-10-06 06:57:10.721966	1481.69	t
842	1263	2025-06-22 15:53:51.377573	3764.83	t
843	1265	2025-03-23 01:11:35.536254	2489.55	t
844	1266	2025-01-10 13:42:27.793222	3546.08	t
845	1268	2024-12-17 14:48:17.296974	1506.59	t
846	1269	2025-02-21 10:12:24.937957	962.01	t
847	1271	2024-07-11 19:23:34.75385	1675.74	t
848	1272	2025-03-03 08:52:20.895539	4211.63	t
849	1274	2024-09-29 12:00:23.507187	2503.19	t
850	1275	2025-02-15 01:08:13.373696	4647.55	t
851	1277	2025-02-22 00:30:23.699801	759.12	t
852	1278	2024-09-09 17:49:27.483468	686.07	t
853	1280	2024-10-02 17:33:43.749289	2032.87	t
854	1281	2024-07-20 20:35:10.059207	2460.81	t
855	1283	2024-08-18 06:17:34.118859	245.74	t
856	1284	2025-03-14 02:11:57.335106	2929.35	t
857	1286	2025-06-02 13:19:25.418533	1932.61	t
858	1287	2025-05-13 10:45:37.813556	1058.46	t
859	1289	2025-05-23 13:10:39.098706	207.08	t
860	1290	2025-04-05 10:38:22.40259	1358.37	t
861	1292	2025-03-10 08:23:15.956329	2091.13	t
862	1293	2024-11-25 04:31:02.851294	2512.57	t
863	1295	2025-03-13 00:25:04.881273	1764.95	t
864	1296	2024-07-04 06:56:56.537669	3261.48	t
865	1298	2024-12-22 19:35:22.731914	1855.54	t
866	1299	2024-09-11 18:27:40.524127	3966.14	t
867	1301	2025-02-21 05:11:08.462712	2407.89	t
868	1302	2024-08-20 23:10:00.164736	238.99	t
869	1304	2025-04-11 04:05:44.358104	2316.27	t
870	1305	2024-12-01 18:49:06.221322	3028.00	t
871	1307	2024-07-21 02:37:33.692115	75.79	t
872	1308	2025-01-10 07:00:23.214829	1955.09	t
873	1310	2024-09-06 05:01:11.237825	304.99	t
874	1311	2024-09-03 14:44:49.939579	1420.27	t
875	1313	2025-05-09 18:24:56.026745	460.61	t
876	1314	2024-10-28 17:39:41.71711	681.14	t
877	1316	2025-01-05 12:54:14.607512	1710.73	t
878	1317	2025-03-23 14:53:50.933421	4802.54	t
879	1319	2025-04-04 10:54:39.072722	674.17	t
880	1320	2024-12-26 17:39:01.363856	393.15	t
881	1322	2024-11-14 22:01:00.264954	2038.60	t
882	1323	2024-11-02 04:09:37.604546	3043.45	t
883	1325	2024-10-04 21:24:48.375957	1320.28	t
884	1326	2025-05-02 18:30:59.157967	2599.02	t
885	1328	2024-11-23 13:55:30.50621	1485.40	t
886	1329	2024-07-14 07:32:14.387648	3917.01	t
887	1331	2025-04-06 00:22:21.480925	1631.55	t
888	1332	2024-08-27 02:23:43.597679	3816.25	t
889	1334	2024-11-27 23:42:46.056352	59.45	t
890	1335	2024-12-26 15:25:02.264323	1602.05	t
891	1337	2024-07-23 21:19:20.306813	1683.82	t
892	1338	2024-11-16 05:15:35.725559	3952.96	t
893	1340	2024-09-07 04:20:58.139449	1246.42	t
894	1341	2024-09-08 21:53:22.260136	4171.58	t
895	1343	2025-01-30 14:55:15.090702	2012.49	t
896	1344	2024-11-06 17:59:09.244494	2567.64	t
897	1346	2024-12-04 14:12:06.611914	574.97	t
898	1347	2024-09-03 20:45:40.792374	444.46	t
899	1349	2025-06-21 11:19:31.136672	2363.84	t
900	1350	2025-03-06 16:03:57.004538	336.35	t
901	1352	2024-11-05 04:42:45.379189	494.84	t
902	1353	2025-02-08 05:36:04.075922	3766.46	t
903	1355	2025-05-20 05:44:58.097371	1179.52	t
904	1356	2024-07-04 00:26:57.063471	3185.09	t
905	1358	2025-06-08 14:20:43.493996	987.64	t
906	1359	2024-10-02 07:43:42.042295	415.59	t
907	1361	2025-02-12 20:34:34.137144	2427.14	t
908	1362	2025-02-16 21:15:50.003028	3528.83	t
909	1364	2025-03-18 04:38:34.618576	865.17	t
910	1365	2024-09-22 16:14:15.654592	4086.53	t
911	1367	2025-06-25 02:23:18.891509	2220.52	t
912	1368	2024-08-16 14:23:28.51934	1083.33	t
913	1370	2024-09-12 00:58:49.690658	2104.97	t
914	1371	2024-08-05 12:32:16.543405	3915.17	t
915	1373	2025-07-02 15:49:14.516017	1595.55	t
916	1374	2024-07-24 11:18:53.182611	4435.91	t
917	1376	2025-03-29 20:06:58.393237	464.64	t
918	1377	2025-01-12 12:44:17.162463	2692.01	t
919	1379	2025-05-05 08:53:35.685264	418.77	t
920	1380	2024-11-21 14:34:16.334963	560.04	t
921	1382	2025-02-01 04:49:52.619726	1812.60	t
922	1383	2024-12-16 06:04:59.817354	4924.66	t
923	1385	2024-08-17 19:31:03.194037	1981.29	t
924	1386	2024-07-13 07:24:50.378724	1389.14	t
925	1388	2025-03-20 12:17:22.952062	172.98	t
926	1389	2024-09-02 10:44:12.692195	77.85	t
927	1391	2024-10-07 08:49:50.950685	226.21	t
928	1392	2024-08-02 13:28:51.252366	328.56	t
929	1394	2025-04-22 11:48:42.789134	1584.25	t
930	1395	2024-07-27 09:54:57.470107	947.18	t
931	1397	2025-01-04 22:00:55.871136	437.45	t
932	1398	2024-12-12 10:31:53.04505	405.87	t
933	1400	2025-01-26 04:03:58.925792	2302.09	t
934	1401	2025-02-05 00:26:25.758652	2590.47	t
935	1403	2024-07-13 01:23:35.062547	2385.48	t
936	1404	2024-12-24 07:30:31.060904	5030.45	t
937	1406	2025-02-05 00:37:25.952967	1728.14	t
938	1407	2024-12-22 01:19:34.718199	3418.10	t
939	1409	2025-02-06 15:13:20.35097	1309.74	t
940	1410	2024-09-13 12:35:27.798792	634.87	t
941	1412	2025-01-23 11:23:53.617465	1009.25	t
942	1413	2024-11-05 00:34:19.27031	3106.35	t
943	1415	2025-01-03 07:34:35.550764	747.29	t
944	1416	2024-10-10 12:50:35.534703	3255.43	t
945	1418	2025-06-25 16:46:36.536344	2332.59	t
946	1419	2025-04-28 06:47:33.4146	1843.01	t
947	1421	2025-05-29 23:05:02.647281	1290.04	t
948	1422	2024-08-24 22:16:36.756754	1334.91	t
949	1424	2024-12-29 08:05:34.982606	907.59	t
950	1425	2024-07-09 02:26:20.925125	2726.35	t
951	1427	2024-07-19 16:27:43.339248	679.83	t
952	1428	2025-06-06 00:36:55.80904	4034.38	t
953	1430	2024-11-15 10:50:28.471696	460.67	t
954	1431	2025-01-10 20:31:53.840265	4515.74	t
955	1433	2025-06-27 21:45:55.355109	2498.29	t
956	1434	2025-04-19 21:18:44.958063	1099.00	t
957	1436	2025-06-11 18:49:07.057439	1593.78	t
958	1437	2025-06-29 17:28:25.166983	468.47	t
959	1439	2024-10-06 10:39:17.797377	1416.74	t
960	1440	2024-08-24 01:09:55.837657	1558.00	t
961	1442	2025-02-15 18:44:04.366688	306.50	t
962	1443	2024-11-30 05:08:21.524004	50.86	t
963	1445	2025-02-02 13:20:41.843146	1840.02	t
964	1446	2025-05-01 16:25:05.042681	4483.66	t
965	1448	2025-03-29 07:48:00.867281	342.78	t
966	1449	2025-05-05 03:38:10.744667	3878.56	t
967	1451	2024-10-02 20:09:37.315703	520.54	t
968	1452	2024-12-26 02:09:42.61201	4596.31	t
969	1454	2024-11-18 18:26:29.51482	2089.16	t
970	1455	2024-12-22 16:40:14.952171	3487.98	t
971	1457	2024-11-14 03:07:33.283373	2501.65	t
972	1458	2025-02-20 12:30:50.392535	2841.36	t
973	1460	2025-06-15 11:52:29.942734	542.56	t
974	1461	2025-02-01 00:19:05.163932	3263.86	t
975	1463	2025-05-30 18:37:17.935074	1810.84	t
976	1464	2024-07-08 05:14:33.429057	3979.16	t
977	1466	2024-08-28 20:48:41.928386	668.43	t
978	1467	2024-09-28 09:28:22.782995	407.43	t
979	1469	2024-09-20 07:06:22.98952	64.32	t
980	1470	2024-08-02 04:20:26.925525	1707.80	t
981	1472	2025-06-25 22:51:59.784227	557.76	t
982	1473	2024-07-21 04:01:00.94576	4809.45	t
983	1475	2024-08-10 22:06:11.390512	2492.37	t
984	1476	2024-11-20 02:59:52.611533	1808.77	t
985	1478	2024-08-12 19:35:43.876811	980.03	t
986	1479	2025-05-21 04:02:39.707544	411.73	t
987	1481	2024-07-11 11:30:59.261621	31.01	t
988	1482	2025-06-09 05:46:11.222207	3351.89	t
989	1484	2024-12-14 10:15:59.261862	1317.24	t
990	1485	2024-11-27 13:41:22.871616	605.89	t
991	1487	2025-05-22 04:36:27.684918	1961.58	t
992	1488	2025-04-25 19:52:32.300978	3621.70	t
993	1490	2025-03-20 21:21:50.436783	1837.61	t
994	1491	2025-02-11 22:39:18.748764	2255.71	t
995	1493	2025-02-27 08:06:20.473539	1075.04	t
996	1494	2025-04-15 04:36:42.794475	730.33	t
997	1496	2024-11-06 11:21:20.136831	2002.42	t
998	1497	2025-02-25 18:58:56.437061	4873.36	t
999	1499	2024-12-26 10:16:02.342662	614.59	t
1000	1500	2025-01-15 00:11:50.160681	3282.30	t
1001	1502	2024-10-10 00:59:42.747849	710.37	t
1002	1503	2025-05-28 18:32:54.563902	1582.39	t
1003	1505	2024-11-04 05:38:38.855805	1821.95	t
1004	1506	2025-06-14 03:27:38.962036	1708.23	t
1005	1508	2025-06-24 21:41:31.526517	2336.46	t
1006	1509	2024-11-24 22:15:09.748329	4262.58	t
1007	1511	2024-10-24 14:31:21.858504	2221.22	t
1008	1512	2025-03-08 11:26:03.872494	3156.96	t
1009	1514	2025-02-21 21:12:17.064434	1133.07	t
1010	1515	2024-11-30 13:40:56.033457	3642.99	t
1011	1517	2024-10-10 06:06:38.204899	402.60	t
1012	1518	2024-10-23 16:36:32.868616	3550.83	t
1013	1520	2024-09-15 11:00:12.762405	2180.45	t
1014	1521	2024-09-28 02:53:42.670269	3535.93	t
1015	1523	2025-03-02 03:45:25.227516	242.45	t
1016	1524	2024-09-27 07:25:19.376338	780.16	t
1017	1526	2025-06-11 00:57:54.91931	2361.87	t
1018	1527	2025-02-17 21:33:50.993261	4457.98	t
1019	1529	2024-10-03 06:10:32.078275	464.87	t
1020	1530	2024-11-15 17:25:37.701623	748.97	t
1021	1532	2024-08-04 11:57:05.052663	902.00	t
1022	1533	2025-01-05 03:13:30.231165	4413.93	t
1023	1535	2025-01-19 14:07:22.732722	1545.92	t
1024	1536	2025-01-15 15:13:33.373475	3248.71	t
1025	1538	2025-01-24 13:08:22.159274	928.01	t
1026	1539	2024-08-28 10:15:21.764369	3196.07	t
1027	1541	2024-12-23 08:09:50.31426	2260.94	t
1028	1542	2024-07-06 09:24:00.391761	1994.71	t
1029	1544	2024-12-25 13:17:45.848514	67.87	t
1030	1545	2024-11-17 20:47:04.84351	2868.54	t
1031	1547	2024-08-09 14:04:30.861811	1651.65	t
1032	1548	2024-07-11 06:36:32.911221	4100.48	t
1033	1550	2024-11-16 10:46:14.726934	898.35	t
1034	1551	2025-04-25 07:00:46.804537	2704.59	t
1035	1553	2025-01-18 06:10:46.385938	120.08	t
1036	1554	2025-04-20 19:27:42.496209	4578.02	t
1037	1556	2024-07-10 01:14:03.777306	1642.51	t
1038	1557	2024-07-04 13:10:42.280147	1750.25	t
1039	1559	2024-08-26 07:32:26.623795	2219.41	t
1040	1560	2025-05-13 17:10:12.616198	5043.82	t
1041	1562	2025-04-26 19:59:17.896479	2148.09	t
1042	1563	2025-05-23 01:06:45.49164	3453.70	t
1043	1565	2024-12-20 16:58:37.047177	1720.67	t
1044	1566	2025-02-27 16:03:58.597505	4210.30	t
1045	1568	2025-06-25 19:36:27.045848	1498.74	t
1046	1569	2024-07-18 19:01:19.922357	1569.68	t
1047	1571	2025-01-11 06:58:59.29935	875.53	t
1048	1572	2025-06-04 00:04:21.511337	3207.64	t
1049	1574	2024-10-23 02:43:15.904584	1477.93	t
1050	1575	2025-05-07 14:57:48.594446	1956.47	t
1051	1577	2025-03-12 21:04:38.857328	491.29	t
1052	1578	2025-04-19 16:27:32.194914	3086.60	t
1053	1580	2024-09-21 22:04:22.780657	2466.90	t
1054	1581	2025-04-04 16:33:34.44357	448.29	t
1055	1583	2024-11-09 19:13:48.986488	700.05	t
1056	1584	2025-02-25 13:52:13.746606	4319.23	t
1057	1586	2024-07-24 11:56:56.800936	1434.11	t
1058	1587	2025-02-17 14:31:58.2136	3638.80	t
1059	1589	2025-02-16 06:56:18.531924	949.17	t
1060	1590	2025-05-20 22:33:24.95881	4511.92	t
1061	1592	2024-09-14 04:01:20.478463	862.31	t
1062	1593	2024-11-19 02:04:45.332598	1714.81	t
1063	1595	2024-12-23 06:08:59.054905	2225.73	t
1064	1596	2025-02-12 06:12:22.261146	106.11	t
1065	1598	2024-09-21 03:25:32.763883	1575.55	t
1066	1599	2025-05-20 17:59:17.033601	1015.40	t
1067	1601	2024-07-25 01:01:37.880749	1571.32	t
1068	1602	2024-11-02 07:42:51.450625	2603.50	t
1069	1604	2025-01-21 18:01:36.466471	1707.27	t
1070	1605	2024-11-13 22:14:02.280333	997.38	t
1071	1607	2025-06-19 13:29:46.459108	419.11	t
1072	1608	2024-07-22 01:10:04.64932	3551.60	t
1073	1610	2025-01-11 07:29:27.661817	1014.87	t
1074	1611	2025-03-23 09:31:10.660168	3507.84	t
1075	1613	2025-06-06 22:11:39.090848	174.43	t
1076	1614	2024-08-29 08:01:25.01635	4252.47	t
1077	1616	2024-07-29 01:31:20.057257	1787.88	t
1078	1617	2025-07-01 03:27:02.888134	4802.21	t
1079	1619	2025-05-05 09:41:04.791645	1312.12	t
1080	1620	2024-11-21 02:19:37.985843	4261.29	t
1081	1622	2025-02-21 16:18:42.0316	984.74	t
1082	1623	2024-07-16 19:56:09.838857	2335.35	t
1083	1625	2025-05-28 02:46:37.10267	1053.49	t
1084	1626	2025-02-23 09:52:26.008876	4317.53	t
1085	1628	2024-09-16 19:54:22.448365	644.20	t
1086	1629	2025-06-01 17:40:24.079955	1047.96	t
1087	1631	2024-11-21 04:21:27.921309	1516.87	t
1088	1632	2024-08-26 22:35:47.825246	2966.26	t
1089	1634	2025-04-26 21:49:47.928385	875.51	t
1090	1635	2024-10-02 05:54:06.778247	2214.33	t
1091	1637	2024-10-15 16:08:36.145075	740.00	t
1092	1638	2025-06-23 00:13:02.09055	101.85	t
1093	1640	2025-06-14 02:36:30.452554	1034.77	t
1094	1641	2024-09-29 03:57:46.876065	1308.42	t
1095	1643	2025-06-06 12:54:07.937141	2408.89	t
1096	1644	2024-12-07 15:29:34.635843	3018.35	t
1097	1646	2024-12-02 06:53:05.276846	2224.09	t
1098	1647	2025-03-14 17:14:34.236555	815.21	t
1099	1649	2024-11-13 18:12:10.683431	1660.62	t
1100	1650	2025-02-24 13:25:26.483832	821.79	t
1101	1652	2025-05-07 09:29:56.426899	2282.99	t
1102	1653	2024-12-31 03:24:09.117287	990.04	t
1103	1655	2024-08-26 02:59:07.153563	1182.53	t
1104	1656	2024-07-24 11:51:32.991744	2916.54	t
1105	1658	2024-08-17 16:18:55.909519	2286.98	t
1106	1659	2025-04-12 19:52:20.957153	4083.70	t
1107	1661	2025-04-09 12:15:42.128053	1272.29	t
1108	1662	2024-11-30 13:38:28.73967	4326.24	t
1109	1664	2024-07-11 02:01:33.936236	1702.67	t
1110	1665	2025-02-05 22:53:59.327763	3008.16	t
1111	1667	2025-03-24 12:10:48.182951	662.34	t
1112	1668	2024-10-06 23:13:27.114339	1525.08	t
1113	1670	2024-12-20 21:33:58.19785	1773.69	t
1114	1671	2025-06-21 19:30:32.923638	1831.03	t
1115	1673	2025-01-07 06:44:48.082976	728.03	t
1116	1674	2025-04-05 17:31:00.969502	3591.78	t
1117	1676	2024-10-20 15:53:00.084223	2375.51	t
1118	1677	2024-11-28 05:24:58.767212	2437.28	t
1119	1679	2025-04-27 20:24:30.013425	603.46	t
1120	1680	2024-11-16 12:00:20.495995	1565.43	t
1121	1682	2025-03-23 14:02:53.311444	2174.97	t
1122	1683	2025-01-05 14:08:50.964368	431.35	t
1123	1685	2025-03-13 19:26:08.289261	1536.30	t
1124	1686	2025-01-25 18:52:48.506659	2066.87	t
1125	1688	2024-12-10 23:08:27.983903	1415.72	t
1126	1689	2024-10-08 00:28:49.129435	884.78	t
1127	1691	2024-08-26 07:49:06.004622	773.36	t
1128	1692	2024-11-04 20:07:14.540394	329.14	t
1129	1694	2025-05-23 08:27:01.349575	2443.16	t
1130	1695	2024-11-06 07:44:49.317596	3686.44	t
1131	1697	2025-02-05 13:23:59.894445	2230.47	t
1132	1698	2025-01-20 19:22:15.451941	4674.15	t
1133	1700	2025-06-14 06:52:47.241069	101.97	t
1134	1701	2025-04-22 10:41:14.892869	3729.46	t
1135	1703	2024-11-21 08:20:20.464603	1313.05	t
1136	1704	2025-04-27 17:59:17.595165	3910.90	t
1137	1706	2025-03-23 15:41:16.724238	451.95	t
1138	1707	2024-08-13 07:41:35.297317	945.93	t
1139	1709	2024-07-26 07:31:53.968088	168.03	t
1140	1710	2024-09-28 23:50:50.299491	4142.76	t
1141	1712	2024-08-20 07:16:03.734209	1946.44	t
1142	1713	2025-02-08 20:22:08.862838	4502.72	t
1143	1715	2025-02-19 12:23:16.079549	1369.00	t
1144	1716	2024-09-07 03:46:05.54753	2138.13	t
1145	1718	2024-10-03 20:07:33.790767	536.56	t
1146	1719	2024-12-05 20:08:15.03897	2969.08	t
1147	1721	2024-08-30 03:34:30.810314	210.10	t
1148	1722	2025-01-16 22:43:26.472542	3542.56	t
1149	1724	2025-02-14 05:37:02.540168	2016.03	t
1150	1725	2024-10-18 01:55:58.037378	841.40	t
1151	1727	2025-03-10 17:08:02.818112	1563.08	t
1152	1728	2025-03-15 03:34:09.382903	1742.59	t
1153	1730	2024-10-02 08:53:48.728575	1024.83	t
1154	1731	2024-10-28 17:40:01.422216	3092.89	t
1155	1733	2024-10-14 04:58:58.467997	2489.00	t
1156	1734	2025-04-03 16:00:19.783339	1767.41	t
1157	1736	2024-12-20 00:22:28.514318	2449.22	t
1158	1737	2024-07-27 15:07:43.311796	2160.24	t
1159	1739	2024-12-27 17:19:08.125455	1902.94	t
1160	1740	2024-08-18 00:26:39.046409	4021.11	t
1161	1742	2024-08-13 03:21:46.458465	1308.13	t
1162	1743	2024-11-23 21:18:43.61334	4848.73	t
1163	1745	2024-08-07 21:14:03.978863	222.12	t
1164	1746	2025-03-03 07:20:13.607793	2928.53	t
1165	1748	2025-02-17 01:10:29.469194	44.35	t
1166	1749	2025-01-02 04:46:42.022913	2318.34	t
1167	1751	2024-09-11 14:56:41.76147	1352.65	t
1168	1752	2024-11-08 10:24:52.33341	2186.06	t
1169	1754	2025-01-07 17:51:31.894348	1471.59	t
1170	1755	2024-08-01 19:13:53.773697	2415.94	t
1171	1757	2025-05-21 08:44:07.40864	1867.36	t
1172	1758	2025-02-10 11:18:46.140231	3156.34	t
1173	1760	2025-05-29 04:47:42.503875	2313.05	t
1174	1761	2024-07-21 22:08:01.235066	3549.03	t
1175	1763	2024-09-27 22:46:20.935938	1772.23	t
1176	1764	2025-03-04 05:54:08.19355	3165.28	t
1177	1766	2024-11-23 15:59:26.813936	2183.74	t
1178	1767	2025-03-08 14:02:53.340574	4786.56	t
1179	1769	2025-02-15 00:51:18.711764	227.82	t
1180	1770	2025-02-18 19:40:38.250837	2044.75	t
1181	1772	2025-05-19 17:11:38.326492	2512.69	t
1182	1773	2024-12-20 23:00:00.279995	3371.23	t
1183	1775	2024-08-28 03:46:52.031347	1639.90	t
1184	1776	2025-01-01 21:25:04.880047	1964.35	t
1185	1778	2025-06-20 23:08:03.577607	992.89	t
1186	1779	2024-07-22 14:47:27.945436	439.03	t
1187	1781	2024-11-18 04:28:40.22926	1405.42	t
1188	1782	2025-02-25 02:42:46.065134	1910.88	t
1189	1784	2024-09-17 09:41:22.11722	259.58	t
1190	1785	2024-09-14 11:41:25.06942	2023.78	t
1191	1787	2024-07-15 15:25:40.460902	2293.42	t
1192	1788	2025-04-18 18:17:01.023677	2348.71	t
1193	1790	2025-02-09 15:18:20.590351	2197.17	t
1194	1791	2024-09-16 23:43:10.626883	4371.06	t
1195	1793	2024-11-22 09:53:15.076827	491.60	t
1196	1794	2025-01-20 22:26:26.025793	2839.51	t
1197	1796	2025-06-13 18:24:26.022189	163.06	t
1198	1797	2024-08-26 05:27:54.825731	2245.31	t
1199	1799	2024-11-20 13:48:00.652592	1964.06	t
1200	1800	2025-05-06 11:11:06.515165	3636.17	t
\.


--
-- Data for Name: pasarelaspago; Type: TABLE DATA; Schema: public; Owner: erp_user
--

COPY public.pasarelaspago (pasarelaid, nombre, activo) FROM stdin;
\.


--
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: erp_user
--

COPY public.productos (productoid, nombre, descripcion, precio, stock, activo, categoriaid) FROM stdin;
1	Laptop Gamer	Laptop de alto rendimiento	1500.00	50	t	2
6	Smartphone Gama Alta	Smartphone última generación	1000.00	100	t	2
7	Tablet 10 pulgadas	Tablet Android 10"	300.00	150	t	2
12	Silla Gamer	Silla ergonómica de gaming	250.00	50	t	5
2	Mouse Inalámbrico	Mouse Bluetooth ergonómico	25.00	500	t	11
3	Teclado Mecánico	Teclado RGB para gaming	75.00	300	t	11
4	Monitor 24 pulgadas	Monitor FHD 24 pulgadas	200.00	100	t	11
5	Auriculares Gamer	Auriculares surround	80.00	200	t	11
16	Auriculares Bluetooth	Auriculares inalámbricos	60.00	300	t	11
17	Teclado Compacto	Teclado mini	45.00	200	t	11
18	Mousepad Gamer XL	Alfombrilla grande	20.00	350	t	11
19	Kit Teclado + Mouse	Kit combo inalámbrico	50.00	400	t	11
29	Gamepad Bluetooth	Control inalámbrico	45.00	200	t	11
31	Cargador Rápido	Cargador de pared	35.00	400	t	11
37	Luz Ring LED	Iluminación para fotografía	50.00	120	t	11
42	Cable HDMI 4K	Cable de alta definición	25.00	300	t	11
49	Hub USB 7 Puertos	Hub de expansión	35.00	120	t	11
34	Proyector Portátil	Mini proyector	250.00	40	t	12
40	Cámara de Acción	Cámara deportiva	200.00	70	t	12
43	Cámara Profesional	DSLR Full Frame	2500.00	10	t	12
45	Lente 50mm	Fotografía de retrato	500.00	15	t	12
46	Monitor Ultrawide	Monitor panorámico	600.00	20	t	12
33	Tableta Gráfica	Para diseño digital	200.00	60	t	13
36	Controlador MIDI	Instrumento musical digital	150.00	40	t	13
35	Micrófono Condensador	Micrófono para streaming	100.00	90	t	14
48	Kit Streaming	Paquete para streamers	400.00	40	t	14
9	Memoria USB 128GB	Pendrive alta velocidad	20.00	600	t	15
10	Disco Duro Externo 1TB	HDD portátil	70.00	250	t	15
38	Servidor NAS	Almacenamiento en red	500.00	20	t	15
20	SSD 500GB	Disco sólido SATA	90.00	150	t	16
21	SSD 1TB	Disco sólido alta capacidad	150.00	120	t	16
22	Placa de Video RTX 4060	Tarjeta gráfica potente	600.00	30	t	16
23	Memoria RAM 16GB	Módulo DDR4	80.00	200	t	16
24	Fuente de Poder 600W	Fuente certificada	100.00	80	t	16
25	Gabinete Gamer	Case ATX con RGB	150.00	60	t	16
14	Router WiFi 6	Router de alta velocidad	120.00	90	t	17
15	Switch de Red 8P	Switch Ethernet Gigabit	40.00	120	t	17
47	Router Mesh	Sistema WiFi extensible	200.00	30	t	17
8	Cargador Portátil	Power Bank 20000mAh	50.00	400	t	18
30	Adaptador USB-C	Multipuerto USB-C	30.00	300	t	11
11	Webcam HD	Webcam Full HD	45.00	150	t	11
26	Smartwatch	Reloj inteligente	150.00	250	t	18
39	Batería Externa Solar	Cargador solar portátil	80.00	100	t	18
44	Estabilizador Gimbal	Para cámaras o smartphones	300.00	30	t	18
27	Cámara de Seguridad	IP WiFi	90.00	180	t	19
50	Batería de Respaldo UPS	UPS 600VA para PC	120.00	40	t	20
41	Kit de Herramientas PC	Kit técnico de mantenimiento	60.00	80	t	21
13	Impresora Multifunción	Impresora 3 en 1	180.00	70	t	22
32	Auriculares Studio	Audio de alta fidelidad	120.00	80	t	23
28	Mochila Laptop	Mochila acolchada	70.00	180	t	24
51	Teclado Láser Virtual Pro	Proyector láser que emite un teclado sobre cualquier superficie	350.00	25	t	11
52	Batería Portatil 30w	Recarga el celular de manera rápida con su capacidad de 150000mAh.	150.00	8	f	20
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: erp_user
--

COPY public.roles (roleid, nombre, descripcion, activo) FROM stdin;
1	ADMINISTRADOR	Acceso total al sistema	t
2	VENDEDOR	Gestión de ventas y clientes	t
3	INVENTARIO	Gestión de productos e inventario	t
4	CONTADOR	Acceso a reportes financieros	t
\.


--
-- Data for Name: transaccionespasarela; Type: TABLE DATA; Schema: public; Owner: erp_user
--

COPY public.transaccionespasarela (transaccionid, ventaid, pasarelaid, estado, fechatransaccion, monto, referenciatransaccion, iniciadaporusuarioid, activo) FROM stdin;
\.


--
-- Data for Name: usuarioroles; Type: TABLE DATA; Schema: public; Owner: erp_user
--

COPY public.usuarioroles (usuarioroleid, usuarioid, roleid, fechaasignacion, activo) FROM stdin;
1	1	1	2025-06-17 15:28:30.561679	t
2	2	2	2025-06-17 15:28:30.561679	t
3	3	2	2025-06-17 15:28:30.561679	t
4	4	2	2025-06-17 15:28:30.561679	t
5	5	2	2025-06-17 15:28:30.561679	t
6	6	2	2025-06-17 15:28:30.561679	t
7	7	2	2025-06-17 15:28:30.561679	t
8	8	2	2025-06-17 15:28:30.561679	t
9	9	2	2025-06-17 15:28:30.561679	t
10	10	2	2025-06-17 15:28:30.561679	t
11	11	1	2025-06-17 15:28:30.561679	t
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: erp_user
--

COPY public.usuarios (usuarioid, nombreusuario, password, email, is2faenabled, secret2fa, fecharegistro, activo) FROM stdin;
1	admin	hashed_admin_pass	admin@example.com	f	\N	2025-06-12 17:56:52.304924	t
3	vendedor2	hashed_pass2	vendedor2@example.com	f	\N	2025-06-12 17:56:52.304924	t
4	vendedor3	hashed_pass3	vendedor3@example.com	f	\N	2025-06-12 17:56:52.304924	t
5	vendedor4	hashed_pass4	vendedor4@example.com	f	\N	2025-06-12 17:56:52.304924	t
6	vendedor5	hashed_pass5	vendedor5@example.com	f	\N	2025-06-12 17:56:52.304924	t
7	vendedor6	hashed_pass6	vendedor6@example.com	f	\N	2025-06-12 17:56:52.304924	t
8	vendedor7	hashed_pass7	vendedor7@example.com	f	\N	2025-06-12 17:56:52.304924	t
9	vendedor8	hashed_pass8	vendedor8@example.com	f	\N	2025-06-12 17:56:52.304924	t
10	vendedor9	hashed_pass9	vendedor9@example.com	f	\N	2025-06-12 17:56:52.304924	t
2	vendedor1	$2a$10$G6bkBhrGN.4qfYBY2WCl5e1K5beGYQu4Ic9Fg0LrD3PRKQrJwjwyG	vendedor1@example.com	f	\N	2025-06-12 17:56:52.304924	t
12	LEDS	$2a$10$YTkoPlGej.ExsxkWmzrEae7ybDh7fWfiHVOTlpNI/ejlIwZnqF7c.	elias@test2.com	f	LVL63Y7QCGBDOB4W	2025-06-12 19:46:52.05803	t
13	MADS	$2a$10$ClaN1aPh6Q03SFXGODOo0eAr5medXSkOpZ3hgHtWQGBaAzastJa/q	elias@test3.com	f	CCCSJBEY23BW6A6G	2025-06-12 20:01:42.246953	t
14	prueba	$2a$10$/npe.X9BHJZDJSbuslOqDebMRKyQzJEeQuwCu9yC6XnEGQL6E5wMm	prueba123@gmail.com	f	\N	2025-06-17 08:11:50.034547	t
15	prueba2	$2a$10$Rnfe9QUdUp/WEsOO7DSuI.u0I82iDzb58Hg/Ah47AvzUs//9VZFJO	prueba2@gmail.com	f	\N	2025-06-17 08:36:40.798765	t
16	Probar	$2a$10$7oZ0FSqFvIAdOyW27RiI3ey6uaiaKUduJ/4q7QOxIGmPry3.mfsqK	elias@test4.com	f	UNXDXU5B7OF2VE4G	2025-06-17 09:49:44.361777	t
11	EEDS	$2a$10$8Ah8DR1/rmF2lQEvU6ubpOzPOVu1zgYgfwjjKBK3qECLabV32PAEq	elias@test1.com	f	PHGWHQVJYYA7KIYQ	2025-06-12 18:00:12.890268	t
\.


--
-- Data for Name: ventas; Type: TABLE DATA; Schema: public; Owner: erp_user
--

COPY public.ventas (ventaid, clienteid, fechaventa, total, metodopagoid, creadoporusuarioid, activo) FROM stdin;
1	49	2024-10-21 01:24:38.069028	4933.56	1	3	t
2	169	2025-05-06 11:54:02.280093	4175.82	1	6	t
3	1	2024-12-07 13:44:03.782775	1994.41	1	7	t
4	148	2024-08-08 06:25:26.890937	3672.18	1	5	t
5	56	2025-06-10 07:40:23.418473	224.48	1	8	t
6	152	2024-07-26 04:41:22.485605	1211.95	1	6	t
7	48	2024-08-06 17:49:12.249349	4912.50	1	9	t
8	13	2024-08-26 09:25:24.218211	755.83	1	7	t
9	85	2025-02-09 09:23:04.341216	715.35	1	6	t
10	172	2024-12-20 15:27:06.190483	648.43	1	3	t
11	160	2025-04-27 00:13:56.153278	2962.67	1	9	t
12	184	2024-09-29 03:49:16.823596	3168.26	1	9	t
13	115	2024-09-18 09:37:34.431233	2067.39	1	6	t
14	79	2024-07-21 06:28:56.033664	708.60	1	8	t
15	130	2025-02-11 02:31:46.157647	1557.87	1	7	t
16	106	2025-04-06 23:22:18.964497	1023.00	1	5	t
17	194	2024-09-15 17:31:13.81861	1956.35	1	5	t
18	189	2025-05-22 08:21:00.892579	1123.13	1	8	t
19	52	2024-12-05 14:45:50.265109	4311.57	1	8	t
20	196	2025-02-03 03:10:18.555808	1785.15	1	3	t
21	80	2024-08-13 08:29:30.680831	291.91	1	6	t
22	152	2025-04-10 21:07:48.712224	2504.14	1	9	t
23	141	2025-01-09 16:56:58.41632	361.34	1	5	t
24	140	2024-11-06 12:12:58.835839	4037.35	1	3	t
25	63	2025-06-07 10:01:02.681266	2805.46	1	2	t
26	139	2025-01-13 16:55:09.853847	2229.71	1	5	t
27	48	2024-09-06 06:56:33.751016	2718.43	1	9	t
28	109	2024-11-27 16:02:44.786223	3083.38	1	4	t
29	75	2025-02-04 01:10:02.568059	4893.01	1	6	t
30	188	2025-05-03 02:55:55.204029	2297.73	1	8	t
31	35	2024-08-25 02:26:06.901653	750.48	1	8	t
32	76	2024-11-21 06:00:40.161255	142.15	1	1	t
33	64	2024-10-04 12:40:58.369488	4215.27	1	7	t
34	108	2024-08-18 23:22:44.402727	2632.14	1	6	t
35	171	2024-11-15 03:04:05.850434	4418.45	1	7	t
36	37	2024-12-25 19:58:13.35038	1020.90	1	7	t
37	190	2024-07-09 01:16:30.435653	5049.05	1	7	t
38	189	2025-03-31 05:46:18.061187	3198.27	1	4	t
39	36	2025-03-03 11:32:59.375384	2308.34	1	7	t
40	164	2024-11-11 16:55:19.040428	657.34	1	2	t
41	12	2025-04-04 15:50:23.497701	695.23	1	3	t
42	49	2024-09-04 11:25:29.310213	4146.34	1	3	t
43	200	2025-04-20 15:53:39.430603	2426.30	1	3	t
44	143	2025-01-23 21:15:33.3895	1658.88	1	1	t
45	156	2025-06-04 19:17:04.944672	1951.64	1	10	t
46	173	2024-08-19 21:30:45.198263	1486.64	1	6	t
47	33	2025-02-06 14:25:10.048721	2058.32	1	2	t
48	43	2024-08-30 06:51:40.654376	4184.37	1	4	t
49	50	2025-03-19 00:54:16.199965	1437.19	1	4	t
50	9	2024-08-24 05:04:08.349083	3514.28	1	10	t
51	90	2024-10-17 09:48:50.616652	1060.28	1	6	t
52	24	2025-04-26 15:26:00.412434	4439.60	1	8	t
53	184	2025-06-03 02:55:43.9948	1215.28	1	9	t
54	22	2025-03-06 09:18:29.273104	5022.74	1	5	t
55	159	2024-06-19 05:03:02.447538	2075.53	1	4	t
56	191	2024-08-30 09:20:31.533823	2034.09	1	7	t
57	156	2024-11-14 06:36:38.156192	2605.76	1	8	t
58	52	2024-07-16 20:50:25.734275	2949.56	1	2	t
59	103	2024-08-21 07:49:20.48509	2537.93	1	2	t
60	101	2025-04-10 12:54:55.677497	801.64	1	2	t
61	99	2025-05-23 11:25:03.720012	4342.93	1	9	t
62	138	2025-05-14 11:04:57.845466	1100.48	1	5	t
63	122	2024-09-01 02:15:56.1114	3956.61	1	1	t
64	68	2025-05-07 19:27:10.479602	1697.52	1	1	t
65	112	2025-01-25 14:41:35.191917	1994.97	1	4	t
66	73	2024-12-19 12:49:58.475156	1948.89	1	10	t
67	166	2024-11-19 02:55:36.753641	2703.29	1	2	t
68	8	2025-02-20 18:15:23.811676	4832.14	1	3	t
69	151	2024-08-16 04:38:58.18644	3583.94	1	6	t
70	43	2025-04-11 23:21:41.166757	3749.60	1	6	t
71	14	2024-11-30 11:17:49.719509	4269.52	1	3	t
72	113	2025-02-17 19:07:52.269492	3389.71	1	2	t
73	39	2025-01-27 16:49:03.498345	4475.63	1	8	t
74	54	2025-03-27 10:44:01.185891	258.41	1	8	t
75	174	2025-03-27 20:21:13.511128	168.86	1	4	t
76	49	2024-11-26 20:18:04.068113	1614.23	1	5	t
77	65	2025-04-20 20:45:37.48267	4575.99	1	3	t
78	180	2024-11-13 21:30:31.454707	2500.03	1	8	t
79	145	2024-08-14 09:02:12.980273	4642.96	1	1	t
80	88	2024-08-02 06:06:11.061152	484.87	1	3	t
81	86	2024-10-30 09:11:24.222474	2588.73	1	10	t
82	120	2024-11-19 23:00:16.822292	3867.15	1	8	t
83	43	2024-12-07 06:43:34.035926	4022.00	1	9	t
84	160	2025-04-14 10:08:04.057696	1844.74	1	8	t
85	166	2025-01-16 17:40:11.751796	506.74	1	6	t
86	14	2025-05-20 04:42:08.654658	2216.89	1	9	t
87	84	2024-10-10 04:32:32.308309	4930.83	1	2	t
88	134	2024-11-30 14:38:07.750399	2803.27	1	2	t
89	55	2024-07-10 12:24:52.308748	2227.30	1	6	t
90	144	2025-02-02 01:28:55.435968	3884.94	1	3	t
91	163	2024-11-15 23:40:03.990536	2304.07	1	5	t
92	139	2024-12-27 02:57:41.915086	140.57	1	10	t
93	5	2025-05-01 01:07:37.829804	4864.31	1	8	t
94	88	2024-10-06 11:41:03.685724	1282.21	1	2	t
95	36	2025-06-09 13:35:59.255167	3546.09	1	5	t
96	6	2025-02-06 14:51:49.458025	4297.65	1	4	t
97	191	2024-06-21 16:01:51.928668	931.15	1	4	t
98	66	2024-10-18 17:34:32.708914	3632.00	1	5	t
99	101	2025-06-06 09:46:24.881154	4311.43	1	4	t
100	132	2025-01-08 16:42:59.394224	717.13	1	3	t
101	163	2025-06-07 05:58:56.915714	1199.66	1	7	t
102	84	2024-11-01 20:12:51.709855	3837.13	1	2	t
103	184	2024-10-03 11:18:57.801846	976.62	1	3	t
104	76	2024-07-09 08:39:25.562199	2309.94	1	3	t
105	73	2025-05-04 08:13:40.636177	270.80	1	1	t
106	75	2024-06-26 03:53:54.294991	2937.22	1	2	t
107	34	2025-05-21 19:23:30.673326	4169.37	1	3	t
108	167	2024-10-17 22:17:49.986058	82.45	1	9	t
109	64	2024-07-22 11:36:50.544079	1194.52	1	6	t
110	61	2024-12-21 15:31:50.928486	1808.87	1	9	t
111	137	2025-02-26 03:17:57.385619	3964.02	1	5	t
112	45	2025-05-28 12:25:31.252621	2628.37	1	4	t
113	175	2024-09-06 17:30:10.341387	3099.56	1	9	t
114	47	2024-08-17 13:10:58.915161	4769.89	1	7	t
115	123	2025-03-28 17:37:16.359342	4815.51	1	1	t
116	99	2025-03-23 01:33:08.811424	3219.36	1	4	t
117	52	2024-09-20 21:13:44.178926	1794.61	1	8	t
118	52	2024-11-07 09:28:39.534308	744.21	1	9	t
119	38	2024-08-18 19:47:24.954631	4081.76	1	2	t
120	38	2025-02-21 09:48:16.047071	1249.01	1	9	t
121	67	2024-10-09 20:51:38.185013	3642.22	1	10	t
122	197	2024-12-04 09:12:14.50805	1716.79	1	8	t
123	152	2024-07-09 17:22:48.653762	3071.82	1	8	t
124	36	2025-03-11 04:28:49.315107	1264.07	1	3	t
125	47	2025-02-12 04:50:47.117042	2571.89	1	5	t
126	173	2024-11-25 05:38:08.742028	2467.02	1	8	t
127	27	2024-06-24 09:18:54.808434	1074.44	1	1	t
128	150	2025-04-08 10:48:42.127627	316.82	1	3	t
129	198	2024-07-09 14:36:17.028378	248.53	1	6	t
130	21	2024-07-20 10:31:25.649127	3287.60	1	6	t
131	153	2024-09-14 20:41:29.211508	4955.70	1	4	t
132	59	2025-01-31 19:34:27.566603	1791.92	1	7	t
133	103	2024-12-19 13:25:43.525985	2333.14	1	2	t
134	111	2024-10-10 02:13:45.166173	898.71	1	8	t
135	36	2024-06-23 02:44:35.126114	3845.03	1	2	t
136	12	2025-01-12 01:01:20.469237	4158.13	1	10	t
137	96	2025-03-10 11:17:24.953732	2400.75	1	5	t
138	31	2024-12-14 01:01:27.212123	3717.79	1	9	t
139	159	2025-04-09 02:03:58.45374	901.40	1	5	t
140	80	2024-11-07 03:50:05.006368	4730.94	1	5	t
141	102	2025-01-13 10:20:25.080094	2439.05	1	7	t
142	3	2024-11-10 04:48:43.042172	4223.53	1	9	t
143	45	2025-03-26 04:24:16.552493	1286.84	1	8	t
144	92	2024-06-26 13:09:32.109905	4698.76	1	9	t
145	21	2024-11-19 22:22:10.292134	3248.42	1	3	t
146	129	2025-06-07 18:44:43.248257	3749.37	1	1	t
147	100	2024-07-29 05:22:12.312986	2206.35	1	8	t
148	73	2024-08-15 16:42:51.420877	643.34	1	6	t
149	122	2024-08-28 03:52:28.628484	1043.51	1	1	t
150	113	2025-02-08 21:40:16.639511	2352.67	1	3	t
151	76	2024-07-31 12:03:41.884275	1733.23	1	5	t
152	161	2024-07-04 06:02:52.404961	335.08	1	2	t
153	8	2024-08-21 21:56:35.023792	141.12	1	5	t
154	26	2024-08-06 13:28:24.037395	4515.33	1	8	t
155	109	2025-02-26 17:50:04.123343	4018.39	1	3	t
156	138	2024-11-04 15:57:08.420987	2637.44	1	9	t
157	104	2024-10-15 22:01:21.167082	3632.84	1	6	t
158	115	2025-05-05 08:06:22.560916	2075.99	1	1	t
159	185	2024-10-03 04:42:52.884499	3796.38	1	1	t
160	91	2025-06-01 22:52:26.853225	839.53	1	1	t
161	166	2024-06-21 06:48:36.625867	1069.69	1	2	t
162	155	2025-02-18 06:40:57.725218	1975.86	1	2	t
163	169	2025-04-11 15:20:01.272668	2283.01	1	9	t
164	72	2024-09-18 23:43:16.194872	4234.39	1	8	t
165	110	2024-12-21 03:34:23.632134	148.00	1	9	t
166	190	2025-05-28 08:59:45.329243	1140.85	1	5	t
167	15	2025-03-15 15:51:03.110279	4289.29	1	2	t
168	143	2025-03-02 00:44:08.770402	4225.32	1	8	t
169	150	2024-10-16 23:22:57.139919	2608.16	1	10	t
170	80	2024-10-06 05:12:03.364991	1124.40	1	7	t
171	151	2024-07-29 20:04:10.454221	1815.50	1	8	t
172	42	2025-05-26 22:27:09.075399	1096.75	1	2	t
173	161	2025-05-06 19:01:02.461161	924.86	1	2	t
174	65	2024-07-07 11:44:22.609224	1744.70	1	3	t
175	170	2024-08-22 14:54:04.332603	3645.31	1	8	t
176	93	2025-05-24 12:34:52.712164	4594.73	1	4	t
177	129	2025-01-04 02:57:43.864003	3091.75	1	1	t
178	72	2024-08-02 20:56:03.817983	2753.85	1	5	t
179	104	2024-12-27 09:27:33.141259	424.51	1	8	t
180	82	2025-03-13 14:44:43.115328	4985.66	1	9	t
181	196	2025-01-18 22:27:11.135593	1719.88	1	1	t
182	170	2025-04-20 09:40:24.835541	2941.84	1	6	t
183	96	2025-06-01 08:10:05.884777	187.60	1	3	t
184	147	2024-11-06 04:41:18.026316	636.53	1	8	t
185	13	2024-11-18 11:04:58.574533	1303.89	1	7	t
186	55	2025-05-26 22:29:54.80587	2374.73	1	4	t
187	57	2024-09-11 09:00:28.033859	604.07	1	8	t
188	50	2025-04-02 09:24:26.653493	4386.74	1	4	t
189	189	2025-06-12 16:14:52.393582	4421.39	1	2	t
190	199	2024-10-28 13:57:08.556443	3886.43	1	7	t
191	87	2025-01-31 19:04:17.742236	5009.65	1	6	t
192	95	2025-06-03 18:59:42.696486	1448.15	1	8	t
193	106	2025-06-09 19:46:09.649024	2060.21	1	8	t
194	186	2024-07-09 23:21:08.641878	2748.35	1	5	t
195	178	2025-05-01 06:58:35.607183	4535.10	1	1	t
196	82	2024-12-27 22:42:12.311564	2559.23	1	8	t
197	21	2024-07-07 13:37:26.292084	1006.69	1	6	t
198	174	2024-09-18 06:54:42.661777	3794.07	1	3	t
199	110	2024-06-24 05:07:29.941689	2023.17	1	7	t
200	64	2024-08-08 00:45:36.406473	4048.43	1	8	t
201	57	2025-05-03 02:27:05.380306	1002.55	1	4	t
202	17	2025-01-13 22:55:37.99433	3316.12	1	3	t
203	144	2024-12-14 11:24:17.827269	4034.06	1	2	t
204	151	2024-09-24 16:59:21.47458	4297.48	1	5	t
205	117	2025-01-03 23:46:39.558289	2271.04	1	4	t
206	137	2024-08-16 15:06:26.742452	4122.80	1	2	t
207	193	2024-09-15 15:04:39.574911	3812.34	1	4	t
208	187	2024-06-19 04:40:23.096177	3940.21	1	4	t
209	137	2024-12-18 05:21:45.53193	539.81	1	7	t
210	34	2024-12-25 22:46:18.802099	4598.29	1	7	t
211	163	2024-10-29 03:34:53.292809	2674.27	1	4	t
212	128	2024-12-07 21:44:18.520615	2444.89	1	9	t
213	144	2024-07-12 02:58:00.166674	2989.80	1	10	t
214	167	2024-08-08 00:19:23.478214	901.36	1	9	t
215	154	2025-03-24 23:59:26.089749	212.46	1	7	t
216	177	2025-01-05 11:28:37.65197	281.83	1	2	t
217	82	2025-03-31 00:26:42.002721	3431.51	1	2	t
218	51	2024-09-16 05:27:20.903079	4342.09	1	7	t
219	39	2024-11-09 20:39:08.492549	3239.14	1	6	t
220	98	2024-12-08 05:13:47.697811	4621.71	1	10	t
221	37	2024-08-05 12:41:34.907822	2674.98	1	1	t
222	124	2024-12-14 00:19:18.736552	1942.56	1	8	t
223	105	2025-05-22 15:11:55.34519	2653.33	1	4	t
224	146	2024-12-19 00:47:31.688788	1290.27	1	7	t
225	19	2024-08-21 10:16:05.07805	589.13	1	4	t
226	160	2025-02-04 19:11:46.306149	1296.33	1	1	t
227	8	2024-09-15 18:05:02.795048	1916.89	1	6	t
228	39	2024-11-17 20:16:51.515267	4142.81	1	1	t
229	29	2024-10-19 08:23:03.056405	936.60	1	3	t
230	119	2025-04-03 08:36:48.820269	3447.97	1	7	t
231	123	2024-08-02 07:13:22.119695	1048.74	1	10	t
232	58	2025-03-14 13:39:02.776455	1295.05	1	10	t
233	6	2025-05-31 08:51:48.029413	119.32	1	4	t
234	88	2024-08-05 12:53:56.666096	4322.55	1	6	t
235	120	2024-11-01 20:03:24.193463	4849.80	1	7	t
236	169	2024-07-04 05:08:15.279798	4516.69	1	2	t
237	194	2024-12-23 09:46:36.6023	718.26	1	9	t
238	148	2025-03-06 11:50:01.505697	4520.70	1	7	t
239	193	2024-07-17 18:51:41.710221	1904.72	1	3	t
240	148	2025-04-17 02:36:43.359354	309.01	1	1	t
241	71	2024-09-23 09:13:56.5905	1145.28	1	4	t
242	198	2025-02-07 14:24:44.399331	4744.85	1	6	t
243	89	2025-03-21 17:58:33.096818	4517.69	1	9	t
244	171	2024-07-27 20:33:50.478679	1640.72	1	6	t
245	89	2024-09-16 22:28:36.574908	2768.81	1	8	t
246	189	2025-05-11 18:23:12.315656	3966.43	1	9	t
247	62	2024-07-05 20:14:38.349282	3301.56	1	4	t
248	44	2025-01-18 17:55:22.903342	2237.85	1	5	t
249	31	2025-05-07 19:00:57.767271	2608.45	1	8	t
250	31	2025-02-26 10:30:12.35493	314.74	1	4	t
251	164	2025-04-16 10:25:18.781479	3727.65	1	9	t
252	59	2024-12-05 01:07:50.390422	4974.30	1	1	t
253	159	2025-05-09 02:42:12.122837	4728.26	1	5	t
254	184	2024-08-14 11:37:21.202322	1268.92	1	6	t
255	7	2025-05-05 05:13:10.493817	919.11	1	7	t
256	126	2025-01-01 06:59:26.136857	2051.63	1	8	t
257	145	2024-10-14 09:30:38.326024	1219.41	1	4	t
258	55	2024-10-07 16:54:10.993358	4749.27	1	8	t
259	172	2025-03-09 21:56:11.512755	1241.57	1	3	t
260	178	2025-01-10 00:06:52.999171	1793.56	1	1	t
261	18	2025-01-12 20:10:00.317767	2296.58	1	10	t
262	42	2025-02-19 00:27:28.022376	4525.31	1	4	t
263	165	2025-03-16 01:44:54.551534	4624.80	1	7	t
264	12	2025-02-11 19:49:23.42701	4537.59	1	3	t
265	17	2024-09-18 05:44:40.818518	2302.61	1	4	t
266	145	2024-12-17 11:43:49.956443	3057.07	1	7	t
267	11	2024-12-30 02:10:42.952456	2861.20	1	9	t
268	130	2025-02-10 10:06:10.496953	1113.17	1	3	t
269	99	2025-05-16 04:56:29.514645	2223.74	1	4	t
270	75	2025-03-11 19:10:04.476437	1037.58	1	7	t
271	33	2024-07-10 10:46:59.78503	622.22	1	8	t
272	109	2025-05-13 17:24:29.188613	733.13	1	6	t
273	158	2024-11-26 01:13:17.795406	2747.29	1	6	t
274	77	2024-08-15 22:01:26.267453	2920.86	1	9	t
275	138	2025-02-26 09:44:23.469252	2708.97	1	2	t
276	3	2025-02-06 21:55:20.84371	4712.36	1	7	t
277	86	2025-02-27 14:20:07.465663	605.83	1	1	t
278	12	2024-12-21 15:26:10.294068	656.60	1	4	t
279	113	2025-01-11 07:29:17.05373	1339.75	1	7	t
280	83	2024-07-20 16:59:09.671926	4691.86	1	1	t
281	188	2025-01-04 10:26:48.872544	152.09	1	9	t
282	96	2025-03-14 01:31:27.530514	4816.05	1	7	t
283	175	2024-10-25 00:56:31.580408	477.74	1	9	t
284	21	2024-08-18 16:12:31.662164	3265.25	1	9	t
285	146	2024-08-01 21:10:30.295159	2888.41	1	3	t
286	141	2025-05-22 16:44:01.81562	4808.99	1	5	t
287	110	2024-07-07 00:20:47.450865	4140.29	1	9	t
288	196	2024-08-02 22:02:56.982838	4229.64	1	9	t
289	73	2024-07-08 01:24:19.875325	4555.98	1	6	t
290	126	2024-12-12 08:49:28.261706	3222.38	1	9	t
291	134	2024-11-30 03:48:46.812144	1453.03	1	4	t
292	66	2024-11-13 09:49:04.726954	3358.18	1	6	t
293	28	2024-07-24 10:18:38.930085	4837.05	1	10	t
294	13	2024-11-14 03:43:16.736719	556.46	1	5	t
295	177	2024-08-31 14:58:26.157828	1503.14	1	6	t
296	160	2024-11-11 09:56:42.082897	3588.44	1	9	t
297	144	2024-08-03 16:53:43.328025	765.04	1	3	t
298	177	2024-12-27 05:43:53.190824	1204.14	1	6	t
299	92	2025-02-01 04:49:50.963233	1937.87	1	7	t
300	65	2024-09-26 13:27:06.578663	4241.11	1	9	t
301	186	2024-11-03 15:52:31.405077	4465.12	1	5	t
302	63	2024-10-18 07:41:25.545334	1017.81	1	5	t
303	63	2025-05-11 05:26:18.884905	3290.26	1	7	t
304	14	2025-01-13 08:10:17.992268	3997.52	1	7	t
305	28	2025-01-23 16:42:15.238683	1996.28	1	1	t
306	35	2025-02-19 22:32:10.054534	3045.68	1	7	t
307	55	2025-05-14 07:41:34.730901	4434.03	1	2	t
308	105	2024-10-18 00:46:41.037727	2240.18	1	7	t
309	15	2024-08-18 11:43:50.359468	2801.51	1	5	t
310	140	2024-08-25 01:02:42.87603	4055.92	1	4	t
311	97	2024-11-22 22:16:46.203345	426.08	1	4	t
312	22	2025-01-06 19:57:46.89449	1804.17	1	6	t
313	100	2024-12-28 14:45:14.41455	2991.31	1	3	t
314	174	2024-09-19 15:43:29.632694	4058.69	1	6	t
315	165	2024-12-14 00:55:41.202223	1874.09	1	9	t
316	26	2024-09-09 18:36:46.147356	4234.68	1	5	t
317	6	2024-07-16 20:27:23.966388	3596.13	1	2	t
318	15	2025-01-30 14:13:48.645505	1615.31	1	9	t
319	175	2025-03-17 14:28:46.440953	1626.72	1	2	t
320	151	2024-10-02 17:06:43.393289	1614.13	1	2	t
321	164	2025-05-22 20:35:17.722371	4267.60	1	8	t
322	171	2025-04-18 12:28:23.046761	1477.46	1	7	t
323	99	2025-04-11 21:35:26.107591	4201.66	1	7	t
324	142	2025-01-21 11:21:07.667168	484.06	1	3	t
325	21	2024-10-23 11:51:02.565824	3477.76	1	9	t
326	160	2025-02-22 18:40:22.976042	4451.27	1	7	t
327	158	2024-10-18 02:04:08.666164	3431.37	1	4	t
328	177	2024-07-07 11:28:52.03979	4281.45	1	7	t
329	146	2024-06-28 10:49:04.63924	4576.28	1	3	t
330	48	2024-06-16 18:17:39.887064	2339.76	1	6	t
331	76	2025-03-18 17:35:02.472688	2518.39	1	10	t
332	76	2024-07-14 23:14:45.394591	2207.90	1	7	t
333	71	2025-05-07 18:21:17.9597	4882.12	1	3	t
334	114	2025-06-06 21:22:49.1857	1434.15	1	6	t
335	157	2025-02-19 07:59:06.880985	3444.89	1	3	t
336	65	2025-05-23 07:48:41.465381	1637.35	1	1	t
337	47	2024-10-22 03:50:00.884953	4069.80	1	2	t
338	102	2025-04-11 20:51:25.410246	4712.71	1	2	t
339	170	2024-10-17 08:20:14.459883	2701.86	1	6	t
340	165	2024-07-28 10:41:01.850345	1592.26	1	6	t
341	171	2025-04-01 20:14:58.265653	4482.88	1	10	t
342	122	2025-04-11 21:06:22.495846	1646.18	1	3	t
343	169	2025-03-23 14:15:57.158203	3210.96	1	6	t
344	32	2024-07-08 16:45:53.8324	1652.53	1	5	t
345	73	2024-07-17 01:58:57.49504	760.04	1	5	t
346	9	2024-12-08 23:22:48.735615	2346.83	1	7	t
347	81	2024-11-29 18:39:23.277732	172.83	1	9	t
348	5	2024-07-28 04:20:43.015296	1768.56	1	1	t
349	168	2025-01-05 08:27:50.183847	3404.68	1	6	t
350	110	2024-08-23 02:09:30.976879	4640.61	1	3	t
351	77	2025-05-21 09:58:50.629136	4689.66	1	9	t
352	58	2024-08-03 07:13:55.686974	946.87	1	3	t
353	69	2025-03-31 01:25:21.105092	3848.27	1	2	t
354	112	2024-12-01 23:55:06.16551	2666.71	1	6	t
355	79	2024-11-02 04:14:33.365246	1397.48	1	7	t
356	36	2024-10-26 05:25:33.840627	975.24	1	9	t
357	67	2025-03-15 01:30:03.531267	585.97	1	8	t
358	43	2024-11-22 10:31:45.360889	2149.62	1	8	t
359	63	2024-08-18 00:10:42.004516	3810.25	1	7	t
360	131	2024-09-21 03:30:41.005469	1310.39	1	2	t
361	182	2024-06-14 04:21:27.590976	3494.32	1	8	t
362	160	2025-01-24 17:56:51.196333	3092.02	1	5	t
363	143	2024-11-21 00:41:27.423931	575.51	1	5	t
364	194	2024-10-29 19:54:05.505961	3075.96	1	6	t
365	70	2024-08-12 15:01:44.334384	1139.62	1	4	t
366	113	2025-03-30 15:01:37.992485	2952.81	1	10	t
367	4	2025-04-08 17:03:10.710455	3077.61	1	4	t
368	3	2024-08-03 06:08:06.221688	3047.88	1	7	t
369	33	2025-02-16 02:24:01.521278	3647.23	1	4	t
370	117	2024-11-15 21:05:03.537456	3082.45	1	8	t
371	178	2025-03-05 15:11:41.679933	2660.61	1	2	t
372	199	2025-04-30 01:47:19.564812	3979.58	1	6	t
373	96	2024-07-28 23:39:21.436157	862.72	1	2	t
374	4	2025-06-07 05:21:15.658701	3363.92	1	8	t
375	121	2024-09-23 16:57:40.457254	1960.51	1	8	t
376	98	2025-02-09 12:43:19.142094	1424.27	1	3	t
377	59	2025-05-23 11:37:28.804801	3364.29	1	6	t
378	89	2025-01-11 10:39:30.499069	2625.60	1	8	t
379	31	2025-05-01 20:59:39.277236	1062.94	1	9	t
380	71	2024-09-08 17:01:13.472663	2731.52	1	3	t
381	45	2025-04-15 13:18:25.671268	2590.64	1	8	t
382	183	2024-10-08 21:20:17.478711	4101.18	1	9	t
383	148	2025-01-09 00:13:42.302845	3623.84	1	8	t
384	178	2024-12-23 12:25:42.229758	2998.67	1	6	t
385	18	2025-05-05 15:45:10.794467	222.97	1	5	t
386	90	2025-01-01 14:41:08.865974	803.85	1	2	t
387	24	2024-10-25 21:56:53.178081	1617.09	1	2	t
388	64	2024-11-20 04:59:06.060783	2561.71	1	5	t
389	162	2025-02-21 11:01:22.44974	3693.88	1	9	t
390	61	2024-12-10 06:30:09.069002	1335.23	1	7	t
391	26	2025-05-16 04:49:15.513067	2021.09	1	2	t
392	46	2025-06-04 18:43:00.892966	2028.72	1	7	t
393	77	2025-06-03 03:30:10.069902	2086.76	1	5	t
394	200	2025-04-18 22:48:07.67426	819.39	1	10	t
395	194	2024-10-28 21:06:10.788855	2248.92	1	5	t
396	176	2024-09-13 05:35:49.066823	4386.20	1	6	t
397	119	2025-03-28 07:43:15.037904	2163.07	1	2	t
398	181	2024-07-28 07:45:28.457788	3425.47	1	2	t
399	114	2024-07-12 04:15:38.919317	2644.17	1	9	t
400	133	2024-11-04 01:11:22.960719	3938.74	1	3	t
401	111	2024-07-05 21:47:11.61699	1719.07	1	4	t
402	113	2024-09-16 12:54:00.471344	1316.73	1	10	t
403	173	2025-01-25 14:37:13.743749	2362.48	1	8	t
404	156	2024-09-10 00:48:07.275218	3996.05	1	4	t
405	163	2025-01-13 16:10:07.094017	4145.72	1	4	t
406	158	2024-12-04 20:24:38.175715	1262.11	1	4	t
407	92	2024-12-26 17:13:29.53636	1628.36	1	4	t
408	190	2025-01-22 06:44:06.781574	1704.13	1	5	t
409	41	2025-04-14 12:56:17.839316	4035.65	1	8	t
410	46	2024-12-09 11:55:44.231523	3185.93	1	4	t
411	47	2024-12-06 05:35:24.757919	4962.68	1	2	t
412	118	2024-09-28 09:23:24.369469	4567.02	1	2	t
413	130	2024-11-04 11:57:39.872113	3104.21	1	3	t
414	109	2024-09-09 21:00:20.747576	4596.85	1	1	t
415	116	2024-12-05 01:58:38.634878	166.17	1	6	t
416	21	2025-02-05 10:26:10.399138	3131.82	1	4	t
417	43	2024-09-20 07:42:06.465365	404.91	1	4	t
418	120	2024-10-09 03:08:14.084892	4901.83	1	7	t
419	154	2024-12-03 21:30:19.833446	4953.08	1	3	t
420	144	2024-10-18 17:42:33.055173	3756.64	1	4	t
421	164	2024-08-03 22:01:59.445788	3512.09	1	7	t
422	43	2025-05-29 13:11:05.060605	2216.31	1	4	t
423	22	2024-07-11 07:21:46.537923	5040.35	1	2	t
424	59	2025-02-19 08:46:21.646991	1511.70	1	4	t
425	62	2025-01-31 01:53:46.971347	2864.71	1	7	t
426	150	2025-03-15 15:32:11.705786	1677.91	1	9	t
427	148	2025-01-06 08:40:39.612624	4957.61	1	3	t
428	111	2024-07-09 08:15:45.659471	2298.54	1	4	t
429	49	2024-09-22 18:14:37.507033	2943.23	1	7	t
430	80	2024-09-13 00:00:16.950284	4542.91	1	4	t
431	77	2025-01-04 14:48:21.903902	917.65	1	9	t
432	124	2024-12-06 00:51:16.320039	1916.75	1	8	t
433	156	2025-04-16 15:41:23.10086	762.47	1	3	t
434	59	2024-06-27 01:48:36.575047	1964.43	1	9	t
435	68	2025-04-03 07:03:46.779366	4176.89	1	8	t
436	140	2024-10-15 05:26:09.728798	168.58	1	1	t
437	96	2025-04-24 12:11:35.590435	1617.72	1	3	t
438	25	2024-06-23 15:42:31.360195	1824.83	1	6	t
439	107	2025-05-09 12:24:48.666901	4242.10	1	6	t
440	70	2024-12-29 20:19:35.826663	2108.27	1	9	t
441	35	2024-11-27 03:59:26.795702	1899.03	1	6	t
442	189	2024-06-13 02:47:27.070535	3623.42	1	5	t
443	160	2025-03-20 21:30:51.774943	4030.71	1	6	t
444	182	2025-05-17 09:23:15.473387	2153.67	1	7	t
445	20	2025-04-14 23:02:33.349654	3831.85	1	4	t
446	121	2024-09-23 10:58:12.974964	3556.56	1	9	t
447	76	2025-02-15 03:18:18.783227	484.74	1	6	t
448	179	2025-06-05 06:37:24.415272	402.57	1	8	t
449	185	2024-09-05 22:22:57.598698	1335.63	1	4	t
450	70	2025-03-11 04:44:15.494469	3823.58	1	6	t
451	11	2024-12-01 19:45:40.123173	5039.43	1	9	t
452	161	2024-09-29 13:49:58.991668	3755.80	1	8	t
453	108	2024-09-10 08:35:50.540735	2775.67	1	5	t
454	188	2025-02-22 14:40:05.462208	3695.84	1	9	t
455	98	2024-12-07 19:30:21.597241	4318.23	1	4	t
456	8	2024-10-07 09:46:57.642949	1646.73	1	2	t
457	142	2025-02-03 12:25:56.13271	2970.22	1	1	t
458	108	2024-07-26 18:22:18.28396	3118.80	1	3	t
459	128	2024-12-27 09:19:08.777883	2815.79	1	8	t
460	21	2024-08-14 05:35:47.819194	1867.98	1	3	t
461	160	2025-04-20 05:37:39.808657	3683.54	1	8	t
462	101	2024-09-02 02:47:30.492729	4274.23	1	8	t
463	187	2024-11-20 16:58:07.15825	4633.31	1	6	t
464	199	2025-03-02 02:56:19.576924	1497.06	1	6	t
465	56	2025-01-19 21:33:57.722358	2332.18	1	10	t
466	149	2024-11-14 23:51:21.950763	770.86	1	7	t
467	139	2024-07-27 01:26:18.476607	554.47	1	9	t
468	143	2024-09-13 04:46:18.742159	2236.93	1	2	t
469	160	2024-10-30 04:48:14.044486	3041.69	1	3	t
470	178	2025-01-06 18:54:01.707041	1308.54	1	6	t
471	7	2024-07-14 07:39:48.882539	444.96	1	9	t
472	18	2025-01-06 15:45:58.001711	3262.77	1	10	t
473	10	2025-05-13 20:59:53.161336	829.97	1	9	t
474	169	2024-12-28 23:52:44.511521	3685.77	1	5	t
475	15	2025-03-22 12:56:15.284416	1164.63	1	8	t
476	167	2024-10-19 11:19:56.800343	4416.17	1	10	t
477	70	2024-08-06 10:09:57.92629	4205.67	1	10	t
478	22	2024-11-29 05:38:37.918097	1382.45	1	4	t
479	189	2024-12-04 10:07:50.229252	847.50	1	4	t
480	73	2025-04-14 02:51:47.769014	431.95	1	6	t
481	171	2025-04-07 08:34:25.835245	2226.90	1	5	t
482	4	2024-11-28 15:14:36.02839	3878.47	1	5	t
483	114	2024-06-26 10:51:49.797845	2067.96	1	6	t
484	200	2024-12-31 02:20:26.64526	3056.46	1	1	t
485	74	2024-08-10 09:29:59.813243	3273.70	1	5	t
486	170	2025-06-09 04:38:38.304246	3994.39	1	10	t
487	194	2024-11-09 16:59:54.690964	63.42	1	7	t
488	128	2024-09-13 07:26:00.360024	3674.06	1	10	t
489	139	2024-09-27 23:11:44.67223	3923.17	1	6	t
490	95	2024-11-03 11:08:46.683016	4540.65	1	6	t
491	129	2025-04-18 04:15:04.380744	4540.88	1	6	t
492	82	2025-02-12 05:16:29.977869	2170.25	1	7	t
493	195	2025-05-24 21:23:32.283074	3289.71	1	8	t
494	89	2024-07-01 17:10:34.491805	338.81	1	5	t
495	14	2024-07-29 01:23:10.253051	3111.26	1	1	t
496	24	2024-07-28 21:27:18.286868	3969.53	1	4	t
497	115	2024-11-08 13:20:31.502211	3818.66	1	3	t
498	144	2024-07-21 20:49:06.580043	2227.27	1	8	t
499	189	2025-01-27 13:08:17.682113	1724.37	1	8	t
500	29	2024-12-15 15:50:35.591933	3702.05	1	9	t
501	94	2025-04-16 10:07:29.889492	2613.37	1	2	t
502	54	2024-07-03 00:09:19.378701	4837.44	1	2	t
503	167	2024-10-01 06:36:44.38881	3397.34	1	4	t
504	200	2025-01-09 16:25:08.698888	4341.37	1	2	t
505	93	2024-12-15 21:12:35.058677	947.34	1	10	t
506	122	2025-05-07 19:20:19.227598	5039.13	1	8	t
507	69	2024-12-27 15:43:32.123155	1994.60	1	4	t
508	63	2025-03-03 02:17:38.529995	1970.60	1	8	t
509	126	2024-07-28 10:42:10.625621	1790.72	1	5	t
510	47	2024-11-13 22:36:42.531075	3785.73	1	5	t
511	139	2025-02-18 11:06:37.184834	2730.03	1	3	t
512	33	2025-04-07 11:11:25.371081	3749.82	1	3	t
513	117	2024-10-19 22:46:31.628925	2988.52	1	1	t
514	39	2025-02-21 22:34:45.576354	2417.72	1	5	t
515	87	2024-08-24 21:56:32.707864	4484.80	1	7	t
516	10	2024-07-19 01:45:27.923021	4050.27	1	7	t
517	77	2025-03-14 09:37:51.834054	827.21	1	7	t
518	161	2025-03-19 22:20:27.185845	4196.01	1	5	t
519	46	2025-02-04 15:26:43.959187	208.55	1	8	t
520	60	2024-09-26 10:55:49.161172	4537.57	1	4	t
521	197	2025-01-08 00:21:52.833971	2364.94	1	4	t
522	156	2024-12-21 09:41:55.695006	434.43	1	2	t
523	102	2024-07-02 07:03:46.515686	4435.64	1	8	t
524	140	2024-07-24 00:32:57.834306	2456.09	1	1	t
525	41	2025-02-20 09:32:33.75986	1889.98	1	5	t
526	146	2024-11-20 00:00:28.5054	3487.70	1	8	t
527	85	2025-05-22 20:34:44.812775	458.26	1	3	t
528	4	2024-07-06 18:40:50.229362	3464.95	1	6	t
529	62	2024-06-29 07:22:19.504167	3877.96	1	5	t
530	42	2024-10-11 20:54:36.401408	656.22	1	9	t
531	190	2025-03-25 17:47:52.761853	4514.72	1	9	t
532	38	2025-01-15 14:54:32.576618	2252.63	1	2	t
533	105	2024-06-24 18:22:46.573253	1634.80	1	9	t
534	1	2025-04-15 12:46:00.007647	3627.58	1	3	t
535	60	2024-07-14 17:51:10.997291	3854.45	1	8	t
536	136	2025-01-21 07:25:46.192746	572.20	1	9	t
537	72	2025-05-15 01:21:42.012592	3563.27	1	3	t
538	28	2025-03-25 22:35:09.417855	4409.84	1	10	t
539	31	2024-10-09 04:34:34.792045	4429.10	1	2	t
540	32	2024-08-30 17:13:03.809121	3151.13	1	4	t
541	174	2024-10-15 17:02:22.966778	4035.91	1	8	t
542	81	2024-08-22 16:31:24.660763	1525.72	1	2	t
543	99	2024-11-23 06:14:24.415552	513.52	1	7	t
544	81	2024-12-14 02:56:02.969336	549.27	1	3	t
545	76	2024-11-13 00:00:18.237262	2775.23	1	6	t
546	167	2024-11-08 16:28:20.494662	795.56	1	7	t
547	182	2024-10-03 04:05:46.768001	1560.55	1	3	t
548	29	2024-10-28 23:12:57.391325	2607.07	1	1	t
549	99	2025-02-27 12:11:57.873677	1166.91	1	2	t
550	140	2025-02-09 13:32:46.511732	100.49	1	10	t
551	41	2024-10-06 02:44:54.221681	2941.52	1	8	t
552	169	2025-06-01 22:29:38.551416	845.23	1	8	t
553	10	2025-04-16 01:15:58.984036	498.47	1	8	t
554	74	2025-06-11 14:31:48.29327	4693.91	1	3	t
555	192	2024-11-24 19:20:49.699118	4647.16	1	4	t
556	84	2025-01-06 12:49:28.020685	2185.99	1	8	t
557	131	2025-05-04 13:12:54.294466	4221.01	1	4	t
558	15	2024-11-14 03:53:43.150329	4302.98	1	8	t
559	192	2024-08-31 18:53:03.769342	600.34	1	5	t
560	57	2024-06-15 08:27:41.199109	1591.91	1	5	t
561	162	2025-05-31 16:34:12.783292	1176.85	1	2	t
562	93	2025-03-08 09:50:51.906752	1984.73	1	4	t
563	181	2024-10-10 01:14:09.506612	2959.53	1	7	t
564	109	2024-09-11 02:47:25.794446	705.43	1	1	t
565	17	2024-07-07 02:30:10.134787	458.58	1	9	t
566	9	2024-07-27 04:24:00.140889	2695.77	1	8	t
567	6	2024-11-01 23:03:13.159037	4591.32	1	3	t
568	21	2024-08-18 15:25:11.963855	1019.85	1	7	t
569	42	2025-05-29 17:16:26.944897	1397.98	1	4	t
570	168	2024-08-25 09:59:27.177435	3636.17	1	6	t
571	119	2025-03-08 09:59:32.996636	974.91	1	3	t
572	103	2024-12-11 09:53:46.095513	4440.25	1	3	t
573	55	2025-01-09 11:27:45.682774	2391.31	1	4	t
574	139	2024-12-02 23:05:12.182035	4352.27	1	9	t
575	44	2025-02-03 12:44:40.688613	768.85	1	4	t
576	92	2024-08-20 21:48:01.133582	4391.17	1	6	t
577	195	2025-01-24 20:05:33.21563	2950.41	1	5	t
578	85	2024-11-19 06:05:38.692007	2966.60	1	8	t
579	28	2025-03-26 03:32:33.975925	4276.61	1	8	t
580	199	2025-02-24 13:15:53.512989	4559.94	1	5	t
581	112	2025-01-31 13:25:28.754245	2412.71	1	10	t
582	167	2025-05-31 15:57:06.679725	2836.81	1	3	t
583	197	2024-07-08 18:27:58.274045	4374.28	1	4	t
584	51	2024-12-03 21:42:42.728073	2987.69	1	1	t
585	141	2024-08-23 11:21:29.755666	1796.84	1	5	t
586	76	2025-03-27 20:55:59.703279	106.10	1	1	t
587	88	2025-04-13 04:29:27.675426	4736.05	1	2	t
588	150	2025-03-07 21:52:59.719729	568.07	1	8	t
589	139	2024-09-26 14:34:12.220326	2190.43	1	2	t
590	42	2024-08-14 13:02:48.135016	4718.40	1	1	t
591	184	2024-11-23 04:39:28.239129	5018.98	1	1	t
592	171	2025-02-26 12:34:51.710067	1602.46	1	3	t
593	178	2024-09-17 14:58:55.118626	1668.67	1	9	t
594	147	2024-06-22 03:07:26.853197	3298.54	1	2	t
595	87	2024-07-12 17:49:23.881537	4116.99	1	5	t
596	61	2025-01-06 11:02:58.018933	895.15	1	5	t
597	99	2024-09-01 21:22:38.195006	2484.80	1	8	t
598	150	2024-07-15 03:07:53.765865	525.36	1	6	t
599	195	2025-03-10 14:12:46.065599	1762.66	1	5	t
600	108	2025-03-29 21:07:03.662513	3791.03	1	7	t
601	26	2025-02-25 04:17:38.522959	52.65	1	8	t
602	111	2024-06-17 18:08:01.213716	1516.79	1	6	t
603	28	2024-12-31 07:50:28.187526	3829.94	1	7	t
604	144	2024-11-07 20:44:39.914646	2454.12	1	2	t
605	113	2025-01-21 09:28:20.292808	4213.90	1	5	t
606	3	2024-06-17 08:54:47.658245	4024.14	1	5	t
607	129	2024-07-08 04:58:58.72225	3086.25	1	10	t
608	163	2024-12-11 13:31:25.649164	4574.71	1	1	t
609	148	2024-11-13 04:08:27.571045	2922.68	1	9	t
610	121	2025-02-17 18:18:11.484787	3957.27	1	7	t
611	113	2025-01-10 08:56:48.685019	2019.55	1	2	t
612	81	2025-05-08 11:13:27.555028	1444.03	1	7	t
613	154	2024-06-30 16:33:54.925746	4846.42	1	7	t
614	123	2025-01-29 12:48:57.549487	332.79	1	4	t
615	72	2024-10-22 04:48:44.523155	2625.63	1	7	t
616	136	2024-11-08 17:27:00.270486	3307.95	1	2	t
617	195	2024-12-01 12:57:58.151959	1913.83	1	10	t
618	181	2025-01-22 19:21:36.277656	1006.50	1	8	t
619	58	2025-04-04 16:05:29.295319	410.24	1	8	t
620	185	2024-11-26 09:15:10.361566	507.85	1	6	t
621	195	2025-05-24 12:47:03.998601	1927.05	1	9	t
622	153	2025-05-27 22:42:59.050896	3322.95	1	7	t
623	61	2024-07-07 16:57:55.178516	624.49	1	6	t
624	106	2025-05-30 10:19:18.138349	1810.92	1	5	t
625	74	2025-01-31 02:43:15.542052	4438.67	1	10	t
626	190	2025-03-21 12:34:59.629764	135.54	1	6	t
627	143	2024-07-23 22:12:13.500637	5048.21	1	10	t
628	187	2024-09-28 08:58:48.057858	3267.77	1	6	t
629	60	2024-12-20 12:56:02.502908	2794.77	1	1	t
630	164	2024-10-02 15:33:18.58379	2086.98	1	3	t
631	81	2024-06-21 09:42:45.749853	534.58	1	6	t
632	135	2025-01-07 02:50:51.050083	1146.97	1	7	t
633	31	2024-12-17 22:26:10.709754	2386.93	1	7	t
634	98	2024-09-27 02:21:48.869064	615.51	1	2	t
635	136	2024-12-17 22:41:50.48512	946.19	1	9	t
636	179	2025-02-18 22:13:50.087829	2207.39	1	5	t
637	188	2024-10-18 13:21:01.743298	1387.46	1	3	t
638	36	2025-03-01 01:07:08.954593	884.06	1	4	t
639	48	2024-09-22 09:57:13.777768	2994.21	1	7	t
640	83	2025-05-06 13:46:21.368042	637.74	1	5	t
641	189	2024-06-23 16:10:40.97823	2250.84	1	2	t
642	63	2024-12-10 02:17:23.285993	4983.90	1	4	t
643	87	2025-01-26 09:13:39.241469	3232.15	1	7	t
644	7	2024-08-01 12:01:24.279936	971.88	1	8	t
645	84	2024-08-17 17:14:32.907696	1835.73	1	3	t
646	109	2024-10-04 07:02:25.944674	1124.53	1	4	t
647	16	2025-06-06 22:55:37.149245	2027.90	1	6	t
648	163	2024-12-13 18:27:19.145245	3331.26	1	2	t
649	175	2025-01-30 09:08:47.081785	4055.88	1	7	t
650	27	2024-09-29 20:54:17.383158	2635.53	1	4	t
651	34	2025-01-05 06:18:22.245596	1574.34	1	8	t
652	130	2025-01-08 03:14:46.469475	3414.18	1	5	t
653	88	2024-08-24 20:49:03.576056	1297.94	1	3	t
654	143	2024-07-12 09:22:52.722592	4963.99	1	3	t
655	142	2024-09-02 18:40:24.658545	906.53	1	5	t
656	141	2024-09-17 03:24:02.421424	908.61	1	6	t
657	27	2024-11-28 02:49:50.583703	2256.65	1	6	t
658	2	2024-09-27 11:26:24.386166	3241.33	1	6	t
659	51	2024-11-28 05:04:22.860628	2473.64	1	5	t
660	78	2025-04-16 19:52:23.754699	2340.93	1	4	t
661	159	2024-08-31 02:45:10.403143	3155.94	1	9	t
662	119	2025-03-09 01:09:30.223826	973.59	1	4	t
663	199	2025-03-24 23:57:17.226302	2128.45	1	2	t
664	148	2024-08-30 01:10:34.180341	2593.34	1	5	t
665	24	2025-03-01 04:48:21.159341	3794.98	1	5	t
666	17	2025-04-28 15:18:07.597908	3214.93	1	6	t
667	48	2025-06-01 12:43:00.462415	658.24	1	9	t
668	94	2024-11-27 22:00:16.510878	4433.02	1	3	t
669	6	2025-04-20 14:25:43.605053	3135.24	1	5	t
670	79	2025-05-22 03:03:40.001219	2361.09	1	7	t
671	129	2025-05-13 08:19:10.995025	186.91	1	9	t
672	178	2025-05-02 19:03:44.161285	332.60	1	3	t
673	10	2024-11-05 07:50:24.64322	1903.56	1	5	t
674	164	2024-09-10 01:32:50.510007	5022.30	1	3	t
675	134	2024-09-05 16:38:33.587967	4858.11	1	5	t
676	77	2024-11-10 06:13:48.232411	632.41	1	8	t
677	43	2024-09-27 08:20:35.382602	2238.26	1	2	t
678	93	2024-06-13 19:19:02.348498	4639.85	1	9	t
679	77	2024-12-12 02:28:47.050435	3693.57	1	10	t
680	37	2025-02-19 08:09:02.175717	3407.73	1	7	t
681	73	2025-05-02 16:30:44.262211	3429.11	1	9	t
682	37	2025-06-03 05:17:32.869613	76.00	1	3	t
683	176	2024-09-30 05:00:49.039948	2594.37	1	8	t
684	120	2024-09-27 14:46:27.528543	4443.97	1	3	t
685	115	2025-01-11 21:43:35.165477	2445.18	1	8	t
686	77	2025-05-22 05:00:20.914175	4188.74	1	3	t
687	55	2025-01-02 05:54:23.722126	1475.33	1	9	t
688	115	2024-10-22 02:13:25.779817	2318.86	1	4	t
689	150	2024-10-20 07:59:53.204974	1690.52	1	6	t
690	121	2025-02-03 00:39:59.902258	1470.32	1	5	t
691	110	2024-12-13 04:03:37.695589	3947.16	1	8	t
692	87	2025-03-10 01:36:26.725792	4582.68	1	3	t
693	102	2025-01-22 21:49:14.28235	4208.08	1	2	t
694	80	2024-11-20 04:12:22.355112	932.02	1	1	t
695	178	2025-02-10 11:45:00.562109	3089.84	1	2	t
696	26	2024-11-29 01:40:32.911417	2927.78	1	8	t
697	70	2024-10-05 00:45:46.291186	4284.21	1	7	t
698	67	2025-03-25 07:36:22.699265	5040.79	1	6	t
699	135	2024-11-27 05:25:32.832257	2370.96	1	4	t
700	3	2025-02-06 07:39:46.436154	4950.47	1	6	t
701	100	2024-08-04 20:24:34.702874	2405.05	1	9	t
702	75	2024-07-17 23:59:17.090835	2856.82	1	5	t
703	4	2024-07-22 06:47:53.622434	3979.87	1	9	t
704	78	2025-01-08 15:08:50.565079	852.74	1	5	t
705	70	2025-05-02 01:32:20.386954	641.38	1	7	t
706	143	2024-09-17 15:51:33.389502	4910.90	1	6	t
707	27	2025-05-26 00:07:56.857101	834.43	1	3	t
708	56	2024-12-25 11:55:44.681358	2103.04	1	5	t
709	30	2024-08-08 16:23:36.54947	1836.71	1	10	t
710	190	2024-10-13 11:19:19.970748	2278.08	1	6	t
711	157	2024-07-26 11:45:23.663265	2006.35	1	2	t
712	71	2025-06-09 12:46:30.714375	2866.71	1	7	t
713	83	2025-01-10 06:33:27.227271	2926.35	1	5	t
714	34	2024-10-20 10:41:50.052503	4328.70	1	7	t
715	11	2024-10-05 08:22:11.219084	1043.45	1	9	t
716	147	2024-11-07 12:04:23.340577	4644.55	1	8	t
717	152	2025-02-17 12:01:37.855047	520.97	1	4	t
718	79	2025-01-11 17:36:53.875266	1298.82	1	4	t
719	160	2025-03-02 00:48:53.468075	1895.45	1	7	t
720	47	2025-01-14 08:29:44.1226	4965.63	1	4	t
721	3	2024-07-06 00:03:37.207734	694.85	1	6	t
722	77	2025-03-04 16:42:16.39389	4265.57	1	9	t
723	143	2024-10-16 02:29:11.141728	2175.72	1	8	t
724	35	2024-10-18 10:16:14.716032	2931.32	1	3	t
725	77	2024-12-12 12:06:59.33408	330.88	1	2	t
726	187	2024-09-25 18:06:38.93978	4280.62	1	1	t
727	177	2024-12-25 14:52:31.500414	863.70	1	4	t
728	46	2024-07-28 20:44:14.614763	2247.37	1	9	t
729	94	2024-09-04 01:18:22.551132	4752.75	1	3	t
730	138	2025-01-05 22:11:51.348024	3094.77	1	3	t
731	198	2025-02-26 01:09:55.442321	4883.46	1	4	t
732	85	2024-07-11 18:41:27.323773	1553.99	1	8	t
733	98	2024-07-20 07:47:11.189722	354.81	1	10	t
734	37	2025-05-14 00:10:21.118246	4481.09	1	10	t
735	198	2025-06-07 17:00:54.015095	330.16	1	6	t
736	78	2025-05-16 15:47:37.147061	1922.55	1	7	t
737	156	2025-01-14 08:49:04.259857	3304.40	1	2	t
738	125	2025-03-25 01:24:46.44164	1837.81	1	7	t
739	73	2024-11-23 22:59:07.075107	1376.85	1	5	t
740	56	2024-08-20 19:10:25.202352	945.01	1	4	t
741	2	2024-07-19 18:05:29.336048	4652.37	1	5	t
742	21	2024-07-22 02:21:20.746697	2917.55	1	5	t
743	160	2025-05-31 12:19:36.485003	1326.75	1	5	t
744	32	2024-10-21 04:35:31.315619	4748.27	1	5	t
745	131	2025-02-05 04:02:27.444844	2953.54	1	5	t
746	52	2025-04-01 05:44:12.599892	4833.35	1	5	t
747	62	2025-06-11 14:29:30.088685	1673.38	1	4	t
748	123	2025-03-28 19:13:09.520041	1218.92	1	9	t
749	38	2024-06-23 08:54:49.805061	2072.75	1	8	t
750	140	2024-12-07 05:32:25.429349	1193.73	1	6	t
751	197	2024-07-12 04:04:38.218159	2125.44	1	9	t
752	116	2025-01-11 02:44:24.874475	3082.09	1	2	t
753	81	2025-02-28 20:54:55.26304	2412.58	1	9	t
754	20	2025-04-13 15:09:14.988399	4532.98	1	6	t
755	93	2024-06-25 23:37:50.67789	4601.91	1	8	t
756	50	2024-11-05 10:29:33.039005	1179.88	1	6	t
757	143	2025-01-29 04:43:30.093101	1102.54	1	5	t
758	37	2024-07-02 07:04:13.070365	3548.16	1	3	t
759	169	2024-07-25 14:01:32.925716	4427.71	1	2	t
760	95	2025-03-05 15:57:40.787708	2304.89	1	8	t
761	114	2025-01-30 03:58:37.740348	2485.09	1	5	t
762	148	2025-01-25 05:08:30.792522	3390.28	1	3	t
763	93	2025-03-08 22:36:51.775524	2638.40	1	5	t
764	187	2025-04-15 02:55:09.083778	1580.97	1	6	t
765	120	2024-08-27 17:24:07.097179	4571.92	1	6	t
766	68	2024-06-15 21:09:26.007899	411.61	1	6	t
767	191	2025-05-11 17:50:57.982162	721.03	1	3	t
768	200	2025-01-13 15:26:05.457989	2713.53	1	8	t
769	186	2024-10-24 15:11:46.336571	4807.67	1	8	t
770	189	2024-10-02 13:22:39.812783	4868.04	1	10	t
771	2	2024-07-22 20:05:10.562733	5010.31	1	4	t
772	132	2025-03-11 04:45:19.628086	841.61	1	3	t
773	99	2024-07-06 13:57:43.809482	1684.76	1	2	t
774	138	2024-07-29 17:57:44.683457	2307.01	1	8	t
775	37	2024-08-20 05:26:27.36098	843.11	1	8	t
776	88	2024-12-28 12:15:09.203358	4784.59	1	2	t
777	99	2024-07-30 01:48:13.701368	3025.17	1	10	t
778	114	2025-05-21 18:15:20.241125	1036.04	1	3	t
779	135	2024-07-25 06:46:56.701654	3480.57	1	5	t
780	80	2025-01-31 20:56:59.532981	3169.01	1	4	t
781	122	2024-08-12 16:19:04.692786	550.22	1	4	t
782	106	2025-02-05 14:37:36.789816	722.83	1	7	t
783	57	2025-05-15 14:20:59.371516	4210.53	1	7	t
784	38	2025-03-11 15:17:16.031276	2590.06	1	7	t
785	101	2024-12-06 19:37:14.310613	2178.39	1	1	t
786	4	2025-06-02 12:08:59.758678	1454.89	1	4	t
787	138	2024-10-26 18:51:31.524591	2959.49	1	8	t
788	23	2024-07-27 15:10:18.780096	4044.88	1	7	t
789	23	2024-08-01 10:54:47.452626	4061.69	1	9	t
790	119	2025-04-26 16:43:11.440794	4035.40	1	3	t
791	55	2025-05-15 19:43:23.561061	4082.68	1	2	t
792	51	2024-10-23 01:30:35.857103	3480.19	1	10	t
793	52	2024-10-13 01:18:42.111316	3965.95	1	9	t
794	72	2025-01-16 14:24:50.915787	504.60	1	1	t
795	156	2024-11-30 09:15:34.816731	1946.81	1	2	t
796	66	2025-02-23 20:31:19.040529	3801.63	1	6	t
797	114	2024-09-10 16:28:53.960897	2196.04	1	6	t
798	112	2024-06-23 23:41:14.624863	1265.70	1	2	t
799	150	2025-04-09 04:48:33.78225	1108.35	1	6	t
800	187	2024-07-04 20:17:28.86588	4300.88	1	7	t
801	149	2025-05-04 12:29:43.972968	568.41	1	3	t
802	164	2025-01-11 07:24:15.191116	3037.11	1	2	t
803	85	2024-07-21 19:59:20.972529	3317.76	1	9	t
804	120	2025-03-24 19:01:20.047421	2387.94	1	7	t
805	46	2025-05-29 14:32:16.281957	3164.52	1	1	t
806	190	2024-09-26 04:48:37.400136	4349.92	1	3	t
807	108	2024-12-14 02:13:57.646462	3183.78	1	4	t
808	52	2024-08-24 01:21:53.117348	435.73	1	5	t
809	116	2024-07-30 18:40:31.304815	3446.30	1	8	t
810	31	2025-05-08 03:13:07.911683	3306.88	1	3	t
811	117	2024-11-12 19:18:35.711075	3561.31	1	3	t
812	80	2025-01-21 01:51:25.201995	3520.15	1	5	t
813	176	2024-12-13 08:02:39.827291	2046.75	1	6	t
814	6	2025-04-29 00:03:58.92788	2039.40	1	5	t
815	194	2024-08-15 00:58:51.894141	916.46	1	10	t
816	165	2024-10-22 14:30:33.259391	2670.47	1	4	t
817	94	2024-09-08 05:09:26.998159	999.48	1	2	t
818	181	2025-01-04 08:16:31.739835	629.95	1	9	t
819	145	2025-04-16 19:12:33.622788	2167.61	1	2	t
820	99	2025-05-30 19:03:33.942121	1926.12	1	2	t
821	41	2025-02-27 09:24:56.629433	1615.08	1	4	t
822	99	2025-04-14 12:14:23.815123	4452.95	1	9	t
823	169	2024-11-28 22:29:48.36347	2986.81	1	9	t
824	127	2024-09-25 05:54:48.100257	3721.45	1	5	t
825	59	2025-04-16 17:41:18.267292	4001.64	1	1	t
826	19	2024-12-23 11:19:09.925487	2823.88	1	1	t
827	56	2024-09-15 15:27:07.345674	3516.35	1	5	t
828	89	2024-11-14 07:28:48.999225	1831.30	1	3	t
829	130	2024-09-27 01:33:23.436454	4628.59	1	7	t
830	70	2025-01-17 18:50:58.670615	3564.51	1	5	t
831	175	2024-06-16 09:03:20.623997	4876.43	1	4	t
832	140	2025-02-01 08:46:27.89273	290.99	1	7	t
833	59	2024-09-17 23:35:09.839498	3106.71	1	9	t
834	150	2024-11-12 06:27:40.215049	3584.53	1	3	t
835	175	2024-07-07 05:55:21.315481	940.31	1	10	t
836	21	2025-02-14 01:40:41.18674	1242.54	1	10	t
837	34	2025-06-11 02:57:52.38182	2391.81	1	6	t
838	6	2025-01-03 17:20:08.7482	1588.47	1	1	t
839	192	2024-12-01 03:03:12.137166	2841.14	1	6	t
840	187	2025-05-02 13:24:26.031785	3341.37	1	8	t
841	3	2024-12-08 02:34:08.656206	1400.16	1	7	t
842	42	2025-03-30 09:28:53.161823	350.16	1	10	t
843	133	2024-07-15 12:18:34.371353	3226.81	1	2	t
844	105	2025-01-16 08:50:39.706549	2121.70	1	4	t
845	101	2024-08-17 23:20:16.174001	4817.71	1	10	t
846	58	2024-10-18 21:38:16.454641	1910.20	1	7	t
847	5	2025-03-21 02:36:30.310379	3764.79	1	4	t
848	92	2024-08-05 03:38:09.692835	4504.24	1	5	t
849	24	2025-05-01 13:51:54.274788	3356.19	1	9	t
850	59	2024-07-15 13:31:43.002713	188.53	1	6	t
851	198	2024-08-07 22:01:26.828881	937.04	1	2	t
852	29	2025-01-02 22:41:35.784237	1041.79	1	4	t
853	71	2025-01-21 17:52:48.093639	1065.53	1	6	t
854	123	2025-03-15 19:22:01.958389	346.58	1	1	t
855	182	2025-04-25 00:43:00.28376	1791.72	1	5	t
856	134	2025-03-05 12:16:35.004799	2294.04	1	5	t
857	32	2024-08-17 17:16:17.538739	2730.42	1	3	t
858	15	2025-05-10 14:16:55.447879	668.97	1	10	t
859	33	2024-08-09 18:43:38.524274	2270.12	1	5	t
860	76	2024-09-26 03:04:24.681906	4783.19	1	9	t
861	8	2025-05-26 00:31:13.552359	2695.62	1	7	t
862	109	2025-06-08 09:43:30.188823	488.51	1	9	t
863	135	2024-11-05 13:40:13.787704	1189.80	1	2	t
864	113	2024-11-06 00:44:25.471377	2968.35	1	5	t
865	91	2025-04-02 08:18:23.95541	2688.12	1	4	t
866	156	2025-01-18 13:30:17.063065	269.95	1	2	t
867	189	2025-06-12 13:39:16.013764	1775.57	1	3	t
868	13	2024-06-20 11:55:55.272408	4157.49	1	1	t
869	32	2025-04-19 16:39:17.315384	667.14	1	10	t
870	70	2024-09-08 09:34:55.16902	435.50	1	4	t
871	188	2025-03-23 16:17:16.946393	210.71	1	6	t
872	118	2024-09-11 02:10:37.572442	3238.79	1	9	t
873	71	2024-07-07 14:29:19.784977	4692.13	1	8	t
874	135	2024-09-12 23:52:21.577678	150.36	1	5	t
875	196	2025-02-07 14:09:26.325501	2684.73	1	8	t
876	198	2025-02-01 02:13:20.711258	900.78	1	6	t
877	147	2025-06-01 12:10:07.002999	2415.96	1	5	t
878	122	2024-12-30 04:07:37.706631	2540.21	1	10	t
879	123	2024-09-18 07:56:08.930961	1765.52	1	9	t
880	19	2024-10-11 01:25:56.274002	3299.23	1	5	t
881	36	2025-04-03 07:09:49.577677	1334.98	1	5	t
882	86	2024-08-31 16:34:40.327148	2935.51	1	1	t
883	154	2025-03-08 11:39:28.756977	413.50	1	6	t
884	88	2025-03-07 19:10:44.437496	562.72	1	8	t
885	52	2025-05-29 11:54:26.065268	2727.09	1	8	t
886	63	2025-03-31 23:34:49.358291	4350.65	1	4	t
887	159	2024-10-28 22:50:14.266608	2614.06	1	3	t
888	92	2025-01-26 21:14:54.44681	2472.18	1	7	t
889	6	2025-06-05 16:17:09.511856	3139.97	1	8	t
890	29	2025-04-26 05:54:26.02702	2179.09	1	2	t
891	157	2024-06-23 07:06:21.670649	541.45	1	5	t
892	133	2024-12-25 07:46:16.187923	496.55	1	1	t
893	63	2025-04-15 12:40:41.703261	1315.37	1	7	t
894	77	2025-03-16 12:44:03.2399	1113.28	1	10	t
895	179	2025-01-18 21:16:16.946013	2530.07	1	10	t
896	7	2025-03-13 11:38:46.11685	4219.03	1	5	t
897	44	2025-03-06 15:58:00.29646	2014.19	1	8	t
898	81	2025-01-27 21:21:11.014862	3149.39	1	4	t
899	144	2024-12-14 00:32:54.942373	703.73	1	1	t
900	44	2024-08-16 19:05:55.194271	4612.40	1	8	t
901	166	2024-06-17 01:22:32.416183	4555.04	1	9	t
902	146	2024-10-25 17:02:25.191277	1638.53	1	2	t
903	143	2025-04-28 02:03:02.315203	1850.74	1	7	t
904	104	2024-09-30 18:50:40.625867	3471.33	1	7	t
905	144	2024-08-09 14:05:02.400695	1867.25	1	9	t
906	69	2025-04-22 22:26:19.516188	2161.10	1	3	t
907	193	2024-08-02 19:55:12.337376	290.25	1	4	t
908	154	2025-02-25 09:06:22.230489	1717.53	1	7	t
909	14	2025-01-07 13:52:08.688269	1357.97	1	1	t
910	6	2024-08-31 10:32:12.964199	1510.28	1	3	t
911	141	2025-01-19 11:56:20.716243	1096.86	1	2	t
912	108	2024-11-25 08:37:52.412902	811.92	1	8	t
913	200	2025-03-30 03:11:14.764762	578.13	1	4	t
914	5	2024-09-11 16:43:05.777134	2177.54	1	9	t
915	161	2024-11-08 02:46:02.30467	2887.97	1	2	t
916	160	2025-05-10 21:35:00.504671	4141.78	1	8	t
917	138	2024-09-13 11:23:15.758012	2040.25	1	7	t
918	190	2025-05-05 06:00:00.208409	537.53	1	7	t
919	196	2025-02-06 04:26:21.186373	536.06	1	9	t
920	11	2024-08-15 11:35:08.614171	1920.20	1	9	t
921	177	2024-06-22 09:23:10.010879	2217.72	1	7	t
922	126	2025-01-01 15:33:17.098689	3991.68	1	5	t
923	172	2025-04-26 19:55:31.967074	4315.07	1	5	t
924	144	2024-11-15 21:17:44.344905	2639.76	1	1	t
925	160	2025-05-10 03:40:50.628835	1584.97	1	9	t
926	196	2024-09-21 20:16:16.133805	1317.79	1	6	t
927	156	2025-04-22 13:09:29.363791	2115.02	1	3	t
928	129	2025-05-22 10:57:28.401727	3912.36	1	7	t
929	138	2025-02-22 18:18:20.23467	2918.31	1	3	t
930	152	2024-12-28 22:47:23.545002	220.89	1	8	t
931	67	2024-09-12 17:12:17.106402	3046.32	1	4	t
932	187	2025-04-11 02:27:11.271925	1464.74	1	2	t
933	50	2025-05-22 06:26:03.854972	3392.73	1	1	t
934	171	2025-04-10 15:27:59.822084	2763.28	1	5	t
935	157	2025-01-21 22:53:47.937782	459.30	1	3	t
936	28	2024-07-12 11:34:05.594794	2250.16	1	5	t
937	126	2025-01-17 16:56:44.576015	3916.07	1	1	t
938	104	2025-01-31 01:04:56.345502	5043.74	1	1	t
939	183	2025-04-04 21:50:27.474779	1243.01	1	2	t
940	80	2024-08-31 02:13:34.128054	1831.46	1	6	t
941	189	2024-07-07 16:54:02.976946	853.85	1	10	t
942	41	2025-02-26 13:10:45.014508	2772.36	1	8	t
943	186	2025-01-17 17:23:29.605151	171.02	1	7	t
944	167	2025-01-15 08:08:46.251405	855.03	1	1	t
945	115	2024-11-09 13:50:19.532175	4110.73	1	5	t
946	11	2025-05-01 21:26:33.334021	4189.25	1	6	t
947	111	2025-04-26 20:33:38.195175	4707.29	1	6	t
948	167	2024-11-02 11:47:13.033553	4973.29	1	5	t
949	168	2024-12-02 01:55:45.355681	4253.72	1	8	t
950	71	2024-10-23 15:45:51.872267	1442.37	1	3	t
951	104	2024-07-18 02:39:09.125496	4867.94	1	9	t
952	171	2024-10-14 18:00:11.149426	1705.41	1	1	t
953	43	2024-06-30 15:49:24.420296	1172.37	1	7	t
954	21	2024-10-14 15:33:27.788316	950.69	1	5	t
955	128	2024-08-20 12:48:59.658281	2494.58	1	7	t
956	97	2024-09-25 11:26:40.258812	2677.28	1	4	t
957	154	2025-05-31 19:58:25.718291	489.80	1	6	t
958	200	2024-08-04 04:37:42.537905	2640.38	1	9	t
959	99	2024-07-01 10:46:00.63781	3519.35	1	3	t
960	68	2024-09-07 17:44:25.891874	4400.43	1	3	t
961	189	2024-10-05 06:46:00.034511	4154.06	1	9	t
962	62	2025-04-27 05:47:05.584898	2380.59	1	9	t
963	43	2024-11-07 16:27:19.951403	1288.05	1	4	t
964	44	2025-01-18 21:39:04.453716	1884.11	1	2	t
965	109	2024-09-18 05:20:59.446459	2975.28	1	6	t
966	6	2024-11-19 09:10:03.748083	1593.22	1	8	t
967	14	2025-03-16 16:21:14.6554	1836.27	1	8	t
968	96	2024-06-17 07:50:26.819737	466.25	1	6	t
969	30	2024-08-24 18:39:36.575038	549.64	1	2	t
970	103	2024-12-08 11:45:32.205961	4033.03	1	10	t
971	136	2025-02-18 18:06:56.68109	3605.89	1	9	t
972	80	2024-10-29 14:40:45.410147	158.18	1	5	t
973	16	2024-12-31 17:44:48.502915	4581.38	1	7	t
974	30	2024-06-24 04:21:10.878774	2089.20	1	7	t
975	186	2024-12-19 19:16:06.075777	402.23	1	10	t
976	188	2024-09-26 16:12:28.066615	1637.84	1	2	t
977	68	2024-12-05 02:05:57.108677	2437.70	1	6	t
978	58	2024-10-15 00:28:30.882048	2102.54	1	6	t
979	25	2024-09-06 01:04:06.79614	3538.83	1	3	t
980	140	2024-06-22 21:23:18.061199	1797.35	1	6	t
981	28	2025-04-22 07:20:32.092872	4290.48	1	8	t
982	78	2025-03-13 15:03:40.497858	59.11	1	4	t
983	137	2025-03-30 06:42:50.261694	4076.59	1	3	t
984	61	2025-02-08 14:06:18.438315	2764.93	1	8	t
985	153	2024-06-28 21:14:54.670474	4368.09	1	8	t
986	32	2025-05-30 02:16:03.525314	2557.78	1	6	t
987	163	2025-05-04 16:27:34.111749	2964.81	1	2	t
988	42	2024-09-05 20:12:43.758877	3589.61	1	6	t
989	123	2024-07-10 05:12:14.183157	4538.96	1	5	t
990	89	2025-01-14 04:12:56.934352	1655.71	1	3	t
991	122	2024-08-11 18:03:19.324194	2139.63	1	8	t
992	22	2024-07-11 02:42:01.982442	4125.37	1	8	t
993	25	2025-03-03 14:13:52.180414	4326.52	1	4	t
994	178	2024-10-02 04:40:37.934587	4945.13	1	10	t
995	183	2024-08-30 15:38:34.74578	1664.69	1	2	t
996	143	2024-11-06 03:05:37.182496	2520.84	1	1	t
997	64	2024-09-05 00:51:50.497932	4860.09	1	4	t
998	29	2024-12-11 18:07:45.587061	2624.87	1	7	t
999	60	2025-01-27 08:30:21.213131	3377.17	1	2	t
1000	175	2025-05-26 05:42:25.163856	4480.54	1	7	t
1001	113	2024-12-29 14:38:00.595968	1324.30	1	3	t
1002	59	2024-11-19 18:59:33.4707	333.81	1	2	t
1003	196	2025-03-02 22:10:00.710931	1990.27	1	10	t
1004	131	2025-02-24 13:52:07.653661	517.39	1	3	t
1005	36	2025-06-10 00:28:52.457784	4630.10	1	5	t
1006	174	2024-10-30 08:53:32.552254	4054.30	1	4	t
1007	70	2025-04-06 01:09:43.383278	4120.96	1	8	t
1008	181	2024-09-29 18:11:45.883141	3623.18	1	8	t
1009	24	2024-09-10 21:31:06.204156	4132.82	1	5	t
1010	34	2025-04-28 02:49:54.394396	4770.83	1	4	t
1011	16	2025-03-23 00:26:27.667744	4023.23	1	10	t
1012	148	2024-06-24 02:01:58.976004	4159.01	1	8	t
1013	9	2024-09-10 08:57:32.940064	1374.76	1	3	t
1014	56	2024-07-29 05:30:16.143439	2308.81	1	7	t
1015	175	2024-12-22 23:54:51.219084	3763.40	1	9	t
1016	199	2024-10-02 08:05:51.391758	597.70	1	1	t
1017	15	2024-12-27 13:47:25.671121	634.72	1	2	t
1018	194	2024-09-15 12:39:06.146099	2034.94	1	2	t
1019	72	2025-04-13 04:37:01.452452	86.99	1	6	t
1020	184	2025-04-13 01:11:48.819172	4089.85	1	5	t
1021	72	2025-01-01 03:44:56.439023	4451.02	1	1	t
1022	196	2025-02-04 23:46:17.411026	1888.95	1	3	t
1023	24	2025-01-15 10:32:57.787247	4829.40	1	4	t
1024	93	2025-04-13 06:58:13.339288	2879.96	1	8	t
1025	67	2025-03-28 10:50:17.102498	4600.97	1	2	t
1026	10	2024-10-01 16:04:26.894677	1357.62	1	2	t
1027	84	2025-05-05 12:13:26.233673	2297.43	1	2	t
1028	61	2025-01-07 00:06:24.305235	755.93	1	7	t
1029	191	2024-10-06 10:46:19.937445	4365.87	1	6	t
1030	42	2025-04-28 07:14:24.310938	2413.73	1	5	t
1031	176	2024-10-26 06:53:11.601186	1985.57	1	9	t
1032	2	2024-12-18 00:27:25.506121	2764.62	1	10	t
1033	139	2024-10-27 04:09:30.481282	3820.33	1	8	t
1034	140	2024-11-24 22:28:56.60552	3587.62	1	5	t
1035	30	2024-09-13 15:43:09.80009	231.98	1	7	t
1036	156	2025-03-22 19:57:17.650763	2263.66	1	3	t
1037	131	2024-09-21 20:30:07.635579	3646.42	1	6	t
1038	51	2024-07-23 12:40:49.576675	691.71	1	3	t
1039	43	2024-08-21 19:46:18.699242	4071.48	1	4	t
1040	20	2024-12-11 23:53:02.891022	4329.82	1	7	t
1041	25	2024-07-15 14:26:22.810708	4199.49	1	2	t
1042	18	2025-01-15 21:01:42.234235	1894.76	1	1	t
1043	120	2025-02-21 18:21:45.548658	2385.22	1	5	t
1044	4	2025-05-29 10:58:37.078531	4351.80	1	10	t
1045	81	2025-02-15 21:02:40.27736	2900.39	1	8	t
1046	154	2024-09-06 23:10:31.594218	2883.47	1	9	t
1047	136	2025-05-26 22:30:37.721006	3426.06	1	4	t
1048	55	2024-08-29 07:06:52.357366	1340.90	1	4	t
1049	5	2024-07-25 17:11:13.891938	3167.87	1	3	t
1050	135	2024-11-29 02:43:00.348326	161.72	1	5	t
1051	87	2024-12-23 09:43:01.913104	168.52	1	2	t
1052	136	2024-11-05 09:07:45.053591	3530.69	1	5	t
1053	2	2025-05-10 13:30:53.811368	2538.68	1	4	t
1054	2	2025-01-29 03:18:03.924692	421.42	1	1	t
1055	77	2024-06-23 00:33:23.44695	4740.20	1	6	t
1056	142	2024-11-16 13:02:51.398162	4990.01	1	9	t
1057	193	2024-10-23 23:51:22.705441	139.12	1	4	t
1058	21	2024-12-17 22:06:53.814328	3107.69	1	8	t
1059	13	2024-09-19 21:31:49.19151	2935.34	1	8	t
1060	89	2024-07-08 19:57:32.441269	2525.96	1	8	t
1061	45	2025-05-14 02:50:39.568623	3209.01	1	1	t
1062	118	2024-09-06 17:25:39.506316	4629.71	1	3	t
1063	131	2024-07-26 06:46:03.472771	1142.02	1	2	t
1064	73	2024-11-06 05:45:15.107414	435.51	1	7	t
1065	150	2024-09-29 19:09:12.947428	3611.83	1	8	t
1066	73	2025-03-05 02:17:54.206735	4581.32	1	5	t
1067	167	2025-05-05 02:37:23.130877	4679.16	1	10	t
1068	73	2025-01-11 20:38:51.192633	4392.27	1	9	t
1069	189	2025-05-14 00:15:06.902139	5044.14	1	2	t
1070	163	2024-08-06 22:12:46.618583	2489.95	1	2	t
1071	128	2025-05-23 17:24:03.145171	3191.73	1	9	t
1072	59	2025-06-05 12:18:08.95174	429.64	1	3	t
1073	61	2025-01-12 01:15:31.834038	987.65	1	3	t
1074	74	2024-06-26 01:09:50.614547	2465.05	1	7	t
1075	54	2024-11-22 08:25:25.642795	1400.51	1	4	t
1076	93	2024-11-14 13:17:27.04053	4871.30	1	3	t
1077	139	2024-07-16 19:12:00.663968	4769.90	1	7	t
1078	68	2024-11-04 15:25:42.569691	3199.44	1	10	t
1079	130	2025-01-14 06:00:16.332351	3379.09	1	10	t
1080	60	2024-06-18 07:21:24.385196	1742.34	1	9	t
1081	51	2025-06-05 07:11:08.047489	2869.73	1	5	t
1082	140	2024-09-10 00:54:01.18067	1016.80	1	4	t
1083	76	2025-05-31 01:04:16.962388	1087.00	1	8	t
1084	192	2024-10-28 00:46:29.981691	3650.72	1	4	t
1085	38	2024-09-02 15:29:22.825646	1797.82	1	4	t
1086	110	2024-08-17 22:03:00.671496	2652.43	1	5	t
1087	75	2025-02-10 04:05:19.376235	4291.61	1	4	t
1088	170	2024-07-08 11:36:37.056377	2395.10	1	5	t
1089	138	2024-07-23 16:25:52.257342	2700.83	1	9	t
1090	163	2025-04-23 01:03:54.863339	2078.74	1	3	t
1091	120	2024-12-30 17:47:52.940023	664.98	1	8	t
1092	143	2024-07-06 14:05:15.687702	3590.96	1	2	t
1093	186	2024-11-24 10:34:58.768624	3766.55	1	4	t
1094	68	2024-09-23 08:08:15.061733	502.72	1	5	t
1095	200	2025-03-26 00:18:54.481375	941.29	1	1	t
1096	90	2024-07-15 05:28:15.53257	510.40	1	5	t
1097	116	2024-08-04 15:25:39.361671	1219.45	1	8	t
1098	8	2024-09-18 15:45:13.868837	682.11	1	5	t
1099	140	2025-01-18 14:48:03.434153	1478.99	1	1	t
1100	107	2024-07-12 20:53:01.4125	889.82	1	6	t
1101	181	2024-10-29 22:59:14.131385	1671.11	1	7	t
1102	189	2025-03-20 00:16:18.004177	2564.37	1	7	t
1103	135	2025-02-16 04:38:31.809992	3788.51	1	7	t
1104	185	2024-08-28 05:00:18.576065	1916.23	1	3	t
1105	194	2024-11-27 10:27:03.548502	1441.75	1	6	t
1106	44	2024-10-02 05:16:52.828713	3612.80	1	6	t
1107	168	2024-07-31 04:26:08.18889	768.28	1	1	t
1108	174	2024-08-29 19:28:59.906877	4149.38	1	5	t
1109	167	2025-06-07 03:00:44.659475	818.21	1	6	t
1110	187	2024-10-16 23:41:39.453222	2750.76	1	3	t
1111	74	2025-01-07 21:21:20.386534	1807.16	1	2	t
1112	26	2025-04-16 17:10:02.726262	4638.95	1	10	t
1113	135	2024-07-21 20:07:04.286243	4662.12	1	5	t
1114	114	2024-06-29 21:34:31.055213	1343.61	1	5	t
1115	142	2024-10-16 18:11:30.9162	4520.92	1	3	t
1116	63	2025-05-11 05:26:09.487458	1161.55	1	3	t
1117	55	2024-08-10 03:47:49.813201	3143.69	1	8	t
1118	126	2024-09-22 21:29:15.636639	721.05	1	4	t
1119	33	2025-04-22 00:19:37.279644	1038.31	1	8	t
1120	63	2025-01-11 04:03:58.558302	2067.52	1	7	t
1121	49	2025-05-26 12:05:15.348518	298.94	1	6	t
1122	94	2024-06-20 11:45:53.56727	1688.15	1	2	t
1123	14	2024-11-14 15:51:34.722143	75.49	1	9	t
1124	46	2025-02-24 21:35:08.774467	4113.67	1	7	t
1125	35	2024-11-07 17:55:43.22369	2833.37	1	3	t
1126	131	2025-03-20 06:09:56.601995	1334.32	1	4	t
1127	62	2024-06-22 12:48:26.348651	1565.60	1	5	t
1128	58	2024-12-15 06:59:30.103451	917.22	1	4	t
1129	41	2025-05-19 20:39:22.820742	3734.37	1	6	t
1130	177	2024-06-24 01:06:21.190749	1063.27	1	2	t
1131	4	2025-03-09 11:04:25.542595	1502.54	1	7	t
1132	154	2025-03-02 07:14:23.795287	4596.91	1	6	t
1133	117	2024-10-04 22:02:30.976339	3774.49	1	6	t
1134	166	2025-01-21 15:37:17.417859	1624.10	1	10	t
1135	54	2025-05-08 02:15:53.891656	940.26	1	5	t
1136	29	2024-08-14 20:25:48.112573	1317.59	1	4	t
1137	122	2025-05-24 12:22:35.435384	5024.44	1	5	t
1138	38	2024-09-18 03:21:07.81708	2815.58	1	4	t
1139	168	2024-06-28 21:29:16.36263	2207.19	1	7	t
1140	181	2024-10-10 19:16:05.118433	668.89	1	6	t
1141	127	2024-09-05 17:32:53.422124	786.35	1	8	t
1142	149	2025-04-07 03:24:39.078912	1592.55	1	8	t
1143	40	2024-07-20 04:26:56.437638	1924.02	1	2	t
1144	190	2024-10-12 00:10:48.447244	1947.92	1	4	t
1145	3	2024-10-13 12:30:14.774574	2742.87	1	1	t
1146	97	2025-01-21 03:03:07.383703	4009.61	1	6	t
1147	183	2024-12-29 17:55:55.743098	887.89	1	8	t
1148	62	2025-02-06 20:36:09.454383	4313.17	1	7	t
1149	23	2024-06-19 09:54:01.955079	1705.69	1	6	t
1150	194	2025-03-15 14:27:25.21542	1766.76	1	10	t
1151	159	2024-11-03 10:28:42.646325	229.38	1	7	t
1152	116	2024-07-29 08:44:58.509502	996.85	1	7	t
1153	176	2024-10-07 21:02:50.239826	4449.88	1	3	t
1154	28	2024-10-29 22:39:35.02582	4146.94	1	7	t
1155	38	2025-04-29 02:15:31.571923	3239.93	1	5	t
1156	38	2025-02-20 22:50:15.626829	4053.99	1	1	t
1157	164	2024-11-17 21:45:03.278994	1021.95	1	3	t
1158	40	2024-09-29 11:04:17.616783	1941.06	1	4	t
1159	124	2024-10-22 23:43:43.897297	1083.28	1	8	t
1160	70	2024-11-08 16:47:19.026016	3687.25	1	4	t
1161	136	2025-03-31 04:33:25.852453	2422.21	1	6	t
1162	78	2024-06-16 22:19:40.634325	2114.21	1	1	t
1163	170	2025-05-30 14:50:56.777168	4134.78	1	3	t
1164	75	2024-06-30 08:07:53.528472	3466.68	1	5	t
1165	103	2025-04-13 10:54:10.342179	4312.04	1	9	t
1166	164	2025-02-02 00:38:31.126553	2162.73	1	9	t
1167	148	2025-06-06 04:33:02.020718	3222.72	1	9	t
1168	44	2024-07-12 17:19:38.623042	815.91	1	3	t
1169	59	2025-02-28 10:52:19.877104	4415.70	1	9	t
1170	168	2024-07-13 05:02:52.492133	1512.03	1	1	t
1171	72	2024-08-28 11:37:24.455253	671.05	1	4	t
1172	121	2024-10-18 02:01:38.357962	3353.90	1	5	t
1173	135	2025-01-08 10:44:54.099931	887.87	1	5	t
1174	85	2024-12-15 02:50:58.601355	2346.81	1	8	t
1175	164	2024-11-09 16:49:42.290048	2657.97	1	5	t
1176	43	2025-05-03 21:54:48.06593	593.38	1	7	t
1177	89	2025-06-11 04:13:27.868716	2503.35	1	2	t
1178	60	2025-05-26 22:39:05.254813	580.12	1	10	t
1179	115	2024-10-08 08:40:57.637825	1591.40	1	4	t
1180	186	2025-04-20 00:04:10.19894	587.71	1	6	t
1181	179	2024-10-08 11:14:50.479501	3770.55	1	3	t
1182	11	2024-12-24 05:02:19.019624	4843.48	1	10	t
1183	7	2024-12-23 17:02:17.49158	2891.00	1	3	t
1184	29	2025-03-08 08:34:21.230196	4907.67	1	8	t
1185	110	2025-04-20 22:15:25.256804	1384.82	1	4	t
1186	75	2025-05-11 20:16:18.259612	1788.55	1	7	t
1187	25	2024-12-01 23:47:12.647021	4245.51	1	4	t
1188	138	2024-07-25 14:55:36.82073	4201.39	1	8	t
1189	199	2025-03-28 19:47:20.121434	2420.57	1	5	t
1190	42	2025-01-12 07:50:47.293382	2111.23	1	7	t
1191	103	2024-10-14 13:35:47.525959	4208.85	1	4	t
1192	170	2024-12-18 19:34:44.344386	2119.26	1	5	t
1193	4	2024-07-31 00:46:30.283116	4367.58	1	9	t
1194	163	2024-11-04 17:26:43.964013	3624.87	1	9	t
1195	16	2024-07-10 17:06:13.17592	1770.54	1	8	t
1196	30	2025-01-23 00:42:45.056958	4262.09	1	6	t
1197	74	2025-03-09 18:52:56.696639	4030.26	1	3	t
1198	184	2025-03-01 10:25:01.484031	4396.02	1	4	t
1199	136	2024-09-05 12:51:57.98033	3287.59	1	3	t
1200	133	2025-01-28 19:52:19.49634	4904.16	1	9	t
1201	198	2024-11-27 00:03:26.430522	1506.89	1	2	t
1202	73	2025-02-10 11:53:49.538173	478.83	1	8	t
1203	133	2024-12-23 21:19:42.222684	4466.40	1	10	t
1204	33	2024-06-28 08:39:22.735134	1290.53	1	8	t
1205	66	2025-04-22 07:20:46.547427	4370.79	1	3	t
1206	138	2024-08-26 13:21:40.148881	1120.47	1	5	t
1207	83	2025-01-20 05:30:23.012008	1884.12	1	10	t
1208	157	2024-12-16 10:12:21.017958	2185.26	1	6	t
1209	15	2025-06-11 06:11:50.838896	1927.28	1	8	t
1210	191	2025-02-03 03:04:00.663794	3035.85	1	10	t
1211	31	2025-01-17 15:07:11.313818	1783.31	1	4	t
1212	88	2024-12-10 03:25:22.827939	4569.96	1	1	t
1213	57	2024-11-04 16:33:49.35184	4205.48	1	6	t
1214	129	2024-07-28 23:18:20.432779	1519.82	1	8	t
1215	56	2025-05-01 19:57:15.238793	2649.98	1	7	t
1216	148	2025-03-12 11:02:40.387335	2559.85	1	3	t
1217	66	2024-06-26 16:51:01.014417	4810.91	1	3	t
1218	174	2024-07-23 21:39:36.960115	4358.23	1	5	t
1219	158	2024-09-10 03:23:21.147279	1105.91	1	9	t
1220	185	2025-02-01 01:09:51.002197	3779.42	1	3	t
1221	97	2025-02-21 00:14:47.683139	1663.60	1	7	t
1222	165	2024-06-22 01:45:43.18929	3708.72	1	4	t
1223	159	2024-10-07 02:23:44.156032	2800.36	1	10	t
1224	19	2024-11-25 22:06:44.527118	3217.48	1	8	t
1225	134	2024-06-16 12:50:22.819438	687.68	1	7	t
1226	111	2024-08-20 03:10:52.747612	3242.18	1	3	t
1227	142	2024-12-17 22:41:11.638439	2162.04	1	3	t
1228	9	2024-06-13 18:27:39.168682	4379.20	1	6	t
1229	172	2024-08-28 17:16:49.767194	2018.54	1	3	t
1230	6	2024-11-13 02:49:38.75128	2788.54	1	4	t
1231	105	2024-10-08 02:08:43.19074	3630.58	1	5	t
1232	62	2024-07-01 12:29:22.860247	492.73	1	4	t
1233	22	2024-07-20 22:11:15.307208	448.49	1	2	t
1234	82	2024-10-15 23:24:40.001107	3043.11	1	8	t
1235	128	2025-04-27 12:25:39.144959	1664.71	1	4	t
1236	173	2024-11-20 11:34:13.530462	4510.37	1	4	t
1237	13	2024-08-09 08:45:49.33803	675.86	1	9	t
1238	122	2024-08-06 09:59:25.303285	2195.72	1	2	t
1239	187	2025-05-01 00:10:58.851798	2595.52	1	7	t
1240	53	2024-07-28 15:34:27.172191	316.58	1	5	t
1241	35	2025-01-05 15:30:14.616306	3064.11	1	6	t
1242	3	2025-05-31 17:31:06.885357	154.36	1	2	t
1243	21	2024-09-07 17:20:35.664737	2259.66	1	5	t
1244	108	2024-07-09 04:42:57.644505	4986.52	1	6	t
1245	3	2025-06-01 03:28:02.169661	459.49	1	3	t
1246	141	2024-12-27 00:42:48.889094	1369.82	1	5	t
1247	96	2025-04-06 10:55:43.766302	1450.56	1	2	t
1248	156	2024-10-15 11:30:36.515273	131.50	1	1	t
1249	131	2025-01-20 18:49:06.295325	710.13	1	2	t
1250	13	2024-10-28 05:15:03.493578	720.39	1	5	t
1251	56	2024-07-21 10:47:00.060311	2940.17	1	8	t
1252	91	2025-04-06 11:35:04.576654	3137.69	1	7	t
1253	134	2024-09-12 03:44:28.044968	3037.11	1	3	t
1254	44	2024-06-17 20:07:54.944373	862.77	1	4	t
1255	43	2024-07-03 16:56:53.417922	4508.11	1	3	t
1256	123	2024-12-21 19:49:01.873271	3227.03	1	8	t
1257	163	2025-01-02 19:42:49.310421	3590.07	1	4	t
1258	8	2024-09-25 04:47:03.59622	3036.91	1	10	t
1259	110	2024-12-07 22:13:44.250508	5005.65	1	9	t
1260	58	2025-04-07 18:21:54.59146	1475.31	1	6	t
1261	180	2024-10-15 23:44:01.825088	3714.54	1	4	t
1262	61	2024-09-16 06:57:10.721966	2963.37	1	6	t
1263	4	2025-06-02 15:53:51.377573	3764.83	1	9	t
1264	46	2025-02-21 09:39:51.257988	985.85	1	2	t
1265	143	2025-03-03 01:11:35.536254	4979.09	1	4	t
1266	178	2024-12-21 13:42:27.793222	3546.08	1	7	t
1267	6	2024-06-26 07:55:13.766399	3295.64	1	3	t
1268	133	2024-11-27 14:48:17.296974	3013.18	1	5	t
1269	137	2025-02-01 10:12:24.937957	962.01	1	3	t
1270	170	2024-07-22 03:13:51.966617	4180.50	1	3	t
1271	100	2024-06-21 19:23:34.75385	3351.48	1	7	t
1272	52	2025-02-11 08:52:20.895539	4211.63	1	2	t
1273	141	2024-06-26 00:33:54.547025	4980.36	1	6	t
1274	168	2024-09-09 12:00:23.507187	5006.38	1	7	t
1275	65	2025-01-26 01:08:13.373696	4647.55	1	10	t
1276	30	2025-01-25 06:24:06.665479	1390.64	1	4	t
1277	47	2025-02-02 00:30:23.699801	1518.23	1	6	t
1278	16	2024-08-20 17:49:27.483468	686.07	1	7	t
1279	192	2025-04-29 12:50:43.797051	3979.29	1	3	t
1280	167	2024-09-12 17:33:43.749289	4065.74	1	7	t
1281	139	2024-06-30 20:35:10.059207	2460.81	1	6	t
1282	4	2024-07-09 14:28:41.59565	4374.07	1	5	t
1283	2	2024-07-29 06:17:34.118859	491.48	1	5	t
1284	44	2025-02-22 02:11:57.335106	2929.35	1	9	t
1285	138	2024-09-21 09:55:58.976483	1997.56	1	2	t
1286	140	2025-05-13 13:19:25.418533	3865.21	1	5	t
1287	87	2025-04-23 10:45:37.813556	1058.46	1	7	t
1288	49	2025-03-20 23:40:21.724207	3598.14	1	3	t
1289	5	2025-05-03 13:10:39.098706	414.16	1	2	t
1290	28	2025-03-16 10:38:22.40259	1358.37	1	3	t
1291	21	2025-04-06 07:54:27.798183	2193.84	1	2	t
1292	34	2025-02-18 08:23:15.956329	4182.26	1	2	t
1293	14	2024-11-05 04:31:02.851294	2512.57	1	4	t
1294	36	2024-11-01 15:33:11.0978	301.49	1	9	t
1295	44	2025-02-21 00:25:04.881273	3529.90	1	7	t
1296	65	2024-06-14 06:56:56.537669	3261.48	1	4	t
1297	88	2024-11-18 13:08:04.495367	1218.72	1	8	t
1298	180	2024-12-02 19:35:22.731914	3711.08	1	3	t
1299	26	2024-08-22 18:27:40.524127	3966.14	1	5	t
1300	135	2024-08-19 16:51:04.726719	818.35	1	7	t
1301	141	2025-02-01 05:11:08.462712	4815.78	1	10	t
1302	13	2024-07-31 23:10:00.164736	238.99	1	2	t
1303	42	2024-11-13 11:48:05.213387	1365.47	1	6	t
1304	21	2025-03-22 04:05:44.358104	4632.54	1	6	t
1305	48	2024-11-11 18:49:06.221322	3028.00	1	5	t
1306	125	2024-12-10 05:23:35.952514	2370.57	1	7	t
1307	171	2024-07-01 02:37:33.692115	151.58	1	1	t
1308	200	2024-12-21 07:00:23.214829	1955.09	1	8	t
1309	200	2024-09-18 00:58:23.350175	2650.23	1	3	t
1310	140	2024-08-17 05:01:11.237825	609.97	1	7	t
1311	192	2024-08-14 14:44:49.939579	1420.27	1	10	t
1312	155	2025-05-04 02:04:42.865901	1949.08	1	2	t
1313	181	2025-04-19 18:24:56.026745	921.21	1	1	t
1314	65	2024-10-08 17:39:41.71711	681.14	1	2	t
1315	140	2024-12-29 00:20:17.999046	3148.51	1	6	t
1316	82	2024-12-16 12:54:14.607512	3421.46	1	8	t
1317	200	2025-03-03 14:53:50.933421	4802.54	1	10	t
1318	117	2025-01-30 15:35:40.247253	2944.63	1	10	t
1319	38	2025-03-15 10:54:39.072722	1348.34	1	7	t
1320	161	2024-12-06 17:39:01.363856	393.15	1	7	t
1321	27	2025-04-21 00:06:08.856053	3622.60	1	5	t
1322	34	2024-10-25 22:01:00.264954	4077.19	1	6	t
1323	117	2024-10-13 04:09:37.604546	3043.45	1	2	t
1324	98	2025-04-23 03:25:30.437942	4767.26	1	1	t
1325	115	2024-09-14 21:24:48.375957	2640.56	1	5	t
1326	168	2025-04-12 18:30:59.157967	2599.02	1	5	t
1327	35	2025-02-18 10:37:18.6374	3886.59	1	1	t
1328	173	2024-11-03 13:55:30.50621	2970.80	1	5	t
1329	160	2024-06-24 07:32:14.387648	3917.01	1	8	t
1330	4	2025-03-03 14:44:30.193829	2967.66	1	8	t
1331	92	2025-03-17 00:22:21.480925	3263.09	1	1	t
1332	132	2024-08-07 02:23:43.597679	3816.25	1	6	t
1333	55	2025-06-07 05:36:44.565245	4663.45	1	6	t
1334	44	2024-11-07 23:42:46.056352	118.90	1	4	t
1335	173	2024-12-06 15:25:02.264323	1602.05	1	6	t
1336	114	2025-05-15 14:42:30.260993	3666.29	1	6	t
1337	157	2024-07-03 21:19:20.306813	3367.63	1	8	t
1338	99	2024-10-27 05:15:35.725559	3952.96	1	2	t
1339	40	2025-02-21 14:26:53.649159	1445.98	1	10	t
1340	117	2024-08-18 04:20:58.139449	2492.84	1	6	t
1341	168	2024-08-19 21:53:22.260136	4171.58	1	5	t
1342	166	2025-01-15 00:43:29.320961	2739.92	1	4	t
1343	150	2025-01-10 14:55:15.090702	4024.98	1	5	t
1344	51	2024-10-17 17:59:09.244494	2567.64	1	5	t
1345	26	2024-07-10 00:48:42.083935	1994.83	1	6	t
1346	78	2024-11-14 14:12:06.611914	1149.93	1	6	t
1347	8	2024-08-14 20:45:40.792374	444.46	1	6	t
1348	68	2024-06-27 19:21:28.556177	3242.29	1	2	t
1349	10	2025-06-01 11:19:31.136672	4727.67	1	7	t
1350	145	2025-02-14 16:03:57.004538	336.35	1	2	t
1351	78	2024-10-04 02:25:14.196323	732.72	1	5	t
1352	10	2024-10-16 04:42:45.379189	989.67	1	6	t
1353	44	2025-01-19 05:36:04.075922	3766.46	1	9	t
1354	111	2024-06-26 03:03:16.682984	156.40	1	3	t
1355	61	2025-04-30 05:44:58.097371	2359.04	1	4	t
1356	78	2024-06-14 00:26:57.063471	3185.09	1	3	t
1357	97	2024-11-06 06:23:40.131538	2423.08	1	5	t
1358	193	2025-05-19 14:20:43.493996	1975.27	1	4	t
1359	41	2024-09-12 07:43:42.042295	415.59	1	7	t
1360	186	2024-07-16 19:13:19.574277	754.47	1	9	t
1361	184	2025-01-23 20:34:34.137144	4854.28	1	5	t
1362	55	2025-01-27 21:15:50.003028	3528.83	1	10	t
1363	112	2024-11-24 06:05:18.543857	1860.34	1	4	t
1364	11	2025-02-26 04:38:34.618576	1730.33	1	6	t
1365	72	2024-09-02 16:14:15.654592	4086.53	1	9	t
1366	178	2024-12-09 05:35:27.123045	870.49	1	6	t
1367	140	2025-06-05 02:23:18.891509	4441.04	1	10	t
1368	101	2024-07-27 14:23:28.51934	1083.33	1	9	t
1369	99	2024-10-17 04:05:29.040038	985.37	1	8	t
1370	85	2024-08-23 00:58:49.690658	4209.94	1	10	t
1371	142	2024-07-16 12:32:16.543405	3915.17	1	1	t
1372	25	2024-10-18 10:04:21.814632	3518.21	1	9	t
1373	32	2025-06-12 15:49:14.516017	3191.09	1	9	t
1374	190	2024-07-04 11:18:53.182611	4435.91	1	4	t
1375	71	2025-03-17 04:46:35.943573	2061.75	1	4	t
1376	105	2025-03-09 20:06:58.393237	929.27	1	6	t
1377	3	2024-12-23 12:44:17.162463	2692.01	1	2	t
1378	39	2024-11-21 15:08:00.45081	275.56	1	3	t
1379	183	2025-04-15 08:53:35.685264	837.53	1	6	t
1380	193	2024-11-01 14:34:16.334963	560.04	1	5	t
1381	26	2024-12-26 16:22:03.876329	1624.36	1	2	t
1382	157	2025-01-12 04:49:52.619726	3625.20	1	1	t
1383	13	2024-11-26 06:04:59.817354	4924.66	1	5	t
1384	92	2025-01-21 12:04:59.72927	2158.73	1	5	t
1385	116	2024-07-28 19:31:03.194037	3962.57	1	6	t
1386	47	2024-06-23 07:24:50.378724	1389.14	1	9	t
1387	61	2024-06-16 19:12:35.290781	2420.16	1	4	t
1388	139	2025-02-28 12:17:22.952062	345.95	1	3	t
1389	143	2024-08-13 10:44:12.692195	77.85	1	1	t
1390	157	2024-10-20 09:19:53.208779	143.56	1	3	t
1391	166	2024-09-17 08:49:50.950685	452.41	1	3	t
1392	138	2024-07-13 13:28:51.252366	328.56	1	2	t
1393	91	2024-08-15 08:57:56.125534	3599.86	1	1	t
1394	86	2025-04-02 11:48:42.789134	3168.49	1	7	t
1395	65	2024-07-07 09:54:57.470107	947.18	1	9	t
1396	108	2024-11-30 05:50:13.679629	893.50	1	5	t
1397	6	2024-12-15 22:00:55.871136	874.89	1	6	t
1398	38	2024-11-22 10:31:53.04505	405.87	1	4	t
1399	88	2024-10-23 01:34:07.41203	1451.82	1	6	t
1400	13	2025-01-06 04:03:58.925792	4604.17	1	10	t
1401	35	2025-01-16 00:26:25.758652	2590.47	1	3	t
1402	171	2025-06-12 08:21:23.145783	1825.48	1	3	t
1403	56	2024-06-23 01:23:35.062547	4770.96	1	9	t
1404	156	2024-12-04 07:30:31.060904	5030.45	1	6	t
1405	159	2024-10-10 06:07:49.690668	2571.88	1	2	t
1406	77	2025-01-16 00:37:25.952967	3456.27	1	7	t
1407	156	2024-12-02 01:19:34.718199	3418.10	1	9	t
1408	22	2024-07-17 11:52:07.25848	313.78	1	4	t
1409	79	2025-01-17 15:13:20.35097	2619.48	1	10	t
1410	18	2024-08-24 12:35:27.798792	634.87	1	5	t
1411	52	2024-11-23 07:37:52.046292	4891.20	1	1	t
1412	110	2025-01-03 11:23:53.617465	2018.49	1	5	t
1413	14	2024-10-16 00:34:19.27031	3106.35	1	7	t
1414	117	2024-09-08 14:34:23.859058	1774.96	1	8	t
1415	136	2024-12-14 07:34:35.550764	1494.58	1	4	t
1416	132	2024-09-20 12:50:35.534703	3255.43	1	4	t
1417	26	2024-10-01 15:57:38.686775	1534.82	1	10	t
1418	190	2025-06-05 16:46:36.536344	4665.17	1	7	t
1419	33	2025-04-08 06:47:33.4146	1843.01	1	2	t
1420	103	2025-05-17 11:47:53.831818	4299.31	1	7	t
1421	40	2025-05-09 23:05:02.647281	2580.08	1	7	t
1422	165	2024-08-04 22:16:36.756754	1334.91	1	5	t
1423	34	2024-11-09 23:05:18.247655	4759.40	1	2	t
1424	117	2024-12-09 08:05:34.982606	1815.18	1	5	t
1425	66	2024-06-19 02:26:20.925125	2726.35	1	9	t
1426	113	2025-05-01 04:47:15.075866	5038.73	1	4	t
1427	7	2024-06-29 16:27:43.339248	1359.65	1	10	t
1428	132	2025-05-17 00:36:55.80904	4034.38	1	3	t
1429	172	2024-12-03 10:42:37.455306	1477.85	1	3	t
1430	30	2024-10-26 10:50:28.471696	921.33	1	4	t
1431	40	2024-12-21 20:31:53.840265	4515.74	1	10	t
1432	72	2024-11-04 08:17:57.37613	636.87	1	7	t
1433	153	2025-06-07 21:45:55.355109	4996.57	1	4	t
1434	17	2025-03-30 21:18:44.958063	1099.00	1	4	t
1435	30	2024-12-10 16:36:59.921761	159.13	1	4	t
1436	152	2025-05-22 18:49:07.057439	3187.56	1	9	t
1437	52	2025-06-09 17:28:25.166983	468.47	1	2	t
1438	114	2024-06-18 16:58:08.405649	4380.44	1	6	t
1439	7	2024-09-16 10:39:17.797377	2833.48	1	9	t
1440	183	2024-08-04 01:09:55.837657	1558.00	1	7	t
1441	23	2024-12-29 22:48:05.453724	3332.64	1	6	t
1442	61	2025-01-26 18:44:04.366688	613.00	1	9	t
1443	90	2024-11-10 05:08:21.524004	50.86	1	1	t
1444	126	2025-05-30 21:03:19.796117	2619.37	1	4	t
1445	135	2025-01-13 13:20:41.843146	3680.04	1	4	t
1446	38	2025-04-11 16:25:05.042681	4483.66	1	9	t
1447	148	2024-11-04 02:21:00.512379	1098.21	1	9	t
1448	55	2025-03-09 07:48:00.867281	685.56	1	4	t
1449	179	2025-04-15 03:38:10.744667	3878.56	1	8	t
1450	40	2025-04-13 18:53:20.969963	166.44	1	3	t
1451	161	2024-09-12 20:09:37.315703	1041.08	1	9	t
1452	152	2024-12-06 02:09:42.61201	4596.31	1	8	t
1453	79	2024-07-06 23:25:31.564381	5019.50	1	3	t
1454	75	2024-10-29 18:26:29.51482	4178.31	1	6	t
1455	8	2024-12-02 16:40:14.952171	3487.98	1	2	t
1456	66	2024-09-09 00:12:20.001511	2705.75	1	7	t
1457	81	2024-10-25 03:07:33.283373	5003.29	1	4	t
1458	83	2025-01-31 12:30:50.392535	2841.36	1	4	t
1459	180	2024-08-10 11:45:20.82015	5014.37	1	7	t
1460	127	2025-05-26 11:52:29.942734	1085.12	1	3	t
1461	110	2025-01-12 00:19:05.163932	3263.86	1	3	t
1462	65	2024-10-07 23:23:12.566403	3521.70	1	4	t
1463	153	2025-05-10 18:37:17.935074	3621.68	1	5	t
1464	116	2024-06-18 05:14:33.429057	3979.16	1	5	t
1465	22	2024-08-08 23:29:57.046871	3332.03	1	10	t
1466	25	2024-08-08 20:48:41.928386	1336.85	1	6	t
1467	23	2024-09-08 09:28:22.782995	407.43	1	4	t
1468	155	2024-10-21 18:50:59.165498	477.10	1	8	t
1469	183	2024-08-31 07:06:22.98952	128.63	1	2	t
1470	101	2024-07-13 04:20:26.925525	1707.80	1	10	t
1471	7	2025-05-07 12:15:07.812232	69.01	1	9	t
1472	4	2025-06-05 22:51:59.784227	1115.52	1	5	t
1473	28	2024-07-01 04:01:00.94576	4809.45	1	1	t
1474	199	2024-10-25 13:32:10.865062	2002.75	1	6	t
1475	136	2024-07-21 22:06:11.390512	4984.73	1	6	t
1476	128	2024-10-31 02:59:52.611533	1808.77	1	3	t
1477	144	2024-08-16 00:44:22.537762	324.14	1	8	t
1478	136	2024-07-23 19:35:43.876811	1960.06	1	2	t
1479	31	2025-05-01 04:02:39.707544	411.73	1	10	t
1480	191	2024-12-05 00:28:31.628618	2822.23	1	4	t
1481	21	2024-06-21 11:30:59.261621	62.02	1	8	t
1482	39	2025-05-20 05:46:11.222207	3351.89	1	3	t
1483	198	2024-08-30 15:33:59.318692	2317.42	1	6	t
1484	108	2024-11-24 10:15:59.261862	2634.48	1	3	t
1485	23	2024-11-07 13:41:22.871616	605.89	1	9	t
1486	63	2025-02-24 10:58:17.060517	192.60	1	10	t
1487	9	2025-05-02 04:36:27.684918	3923.16	1	10	t
1488	15	2025-04-05 19:52:32.300978	3621.70	1	6	t
1489	165	2024-08-26 20:02:54.916666	106.87	1	7	t
1490	119	2025-02-28 21:21:50.436783	3675.21	1	2	t
1491	43	2025-01-22 22:39:18.748764	2255.71	1	4	t
1492	171	2025-01-07 13:23:30.583975	2328.74	1	3	t
1493	150	2025-02-07 08:06:20.473539	2150.07	1	7	t
1494	168	2025-03-26 04:36:42.794475	730.33	1	2	t
1495	57	2024-07-09 01:49:51.880569	2435.32	1	6	t
1496	133	2024-10-17 11:21:20.136831	4004.84	1	2	t
1497	3	2025-02-05 18:58:56.437061	4873.36	1	2	t
1498	49	2024-10-30 01:52:46.356096	4407.80	1	10	t
1499	198	2024-12-06 10:16:02.342662	1229.17	1	5	t
1500	172	2024-12-26 00:11:50.160681	3282.30	1	3	t
1501	51	2024-10-30 12:56:09.699976	3183.98	1	6	t
1502	185	2024-09-20 00:59:42.747849	1420.73	1	6	t
1503	83	2025-05-08 18:32:54.563902	1582.39	1	2	t
1504	154	2024-09-19 11:51:50.145661	3970.02	1	2	t
1505	134	2024-10-15 05:38:38.855805	3643.90	1	10	t
1506	105	2025-05-25 03:27:38.962036	1708.23	1	6	t
1507	51	2024-12-29 10:22:05.364109	485.84	1	3	t
1508	144	2025-06-04 21:41:31.526517	4672.91	1	7	t
1509	184	2024-11-04 22:15:09.748329	4262.58	1	7	t
1510	8	2024-09-20 21:10:22.323197	1013.35	1	9	t
1511	102	2024-10-04 14:31:21.858504	4442.44	1	9	t
1512	185	2025-02-16 11:26:03.872494	3156.96	1	4	t
1513	102	2025-04-13 16:19:07.087598	1562.12	1	2	t
1514	190	2025-02-01 21:12:17.064434	2266.14	1	3	t
1515	170	2024-11-10 13:40:56.033457	3642.99	1	9	t
1516	119	2024-12-17 16:11:43.546818	4454.19	1	1	t
1517	71	2024-09-20 06:06:38.204899	805.19	1	9	t
1518	29	2024-10-03 16:36:32.868616	3550.83	1	2	t
1519	55	2024-12-06 17:31:59.533484	1870.82	1	7	t
1520	196	2024-08-26 11:00:12.762405	4360.90	1	7	t
1521	57	2024-09-08 02:53:42.670269	3535.93	1	4	t
1522	26	2024-12-24 00:17:16.645511	2092.29	1	9	t
1523	7	2025-02-10 03:45:25.227516	484.89	1	6	t
1524	30	2024-09-07 07:25:19.376338	780.16	1	2	t
1525	185	2025-03-06 17:23:23.635054	3379.11	1	7	t
1526	74	2025-05-22 00:57:54.91931	4723.74	1	1	t
1527	89	2025-01-28 21:33:50.993261	4457.98	1	4	t
1528	22	2024-08-17 11:50:38.975753	1449.76	1	2	t
1529	96	2024-09-13 06:10:32.078275	929.73	1	4	t
1530	193	2024-10-26 17:25:37.701623	748.97	1	10	t
1531	33	2025-04-09 23:53:47.310354	2123.64	1	6	t
1532	123	2024-07-15 11:57:05.052663	1803.99	1	3	t
1533	101	2024-12-16 03:13:30.231165	4413.93	1	4	t
1534	89	2025-04-13 23:13:32.293482	890.04	1	9	t
1535	118	2024-12-30 14:07:22.732722	3091.83	1	7	t
1536	108	2024-12-26 15:13:33.373475	3248.71	1	5	t
1537	66	2024-06-13 18:21:10.285311	751.23	1	10	t
1538	6	2025-01-04 13:08:22.159274	1856.01	1	8	t
1539	124	2024-08-08 10:15:21.764369	3196.07	1	4	t
1540	141	2024-11-26 14:17:49.581956	4660.25	1	10	t
1541	173	2024-12-03 08:09:50.31426	4521.87	1	9	t
1542	167	2024-06-16 09:24:00.391761	1994.71	1	4	t
1543	117	2025-03-23 23:14:01.830334	1657.62	1	8	t
1544	7	2024-12-05 13:17:45.848514	135.73	1	1	t
1545	48	2024-10-28 20:47:04.84351	2868.54	1	2	t
1546	109	2024-10-15 21:56:47.798125	1160.14	1	7	t
1547	77	2024-07-20 14:04:30.861811	3303.29	1	7	t
1548	120	2024-06-21 06:36:32.911221	4100.48	1	7	t
1549	63	2025-03-15 16:31:43.890823	3228.10	1	7	t
1550	99	2024-10-27 10:46:14.726934	1796.69	1	2	t
1551	115	2025-04-05 07:00:46.804537	2704.59	1	10	t
1552	72	2024-06-24 07:27:30.008329	2608.33	1	9	t
1553	125	2024-12-29 06:10:46.385938	240.15	1	7	t
1554	72	2025-03-31 19:27:42.496209	4578.02	1	2	t
1555	120	2024-08-05 12:45:27.104746	1942.49	1	10	t
1556	48	2024-06-20 01:14:03.777306	3285.02	1	3	t
1557	159	2024-06-14 13:10:42.280147	1750.25	1	9	t
1558	140	2024-07-11 12:51:24.451231	616.05	1	7	t
1559	62	2024-08-06 07:32:26.623795	4438.82	1	4	t
1560	69	2025-04-23 17:10:12.616198	5043.82	1	5	t
1561	196	2025-04-20 00:12:20.003047	2764.32	1	5	t
1562	9	2025-04-06 19:59:17.896479	4296.18	1	7	t
1563	86	2025-05-03 01:06:45.49164	3453.70	1	4	t
1564	6	2024-10-04 15:18:52.200982	1796.09	1	7	t
1565	87	2024-11-30 16:58:37.047177	3441.34	1	1	t
1566	59	2025-02-07 16:03:58.597505	4210.30	1	6	t
1567	144	2025-05-06 00:32:34.06183	4825.83	1	9	t
1568	90	2025-06-05 19:36:27.045848	2997.47	1	7	t
1569	91	2024-06-28 19:01:19.922357	1569.68	1	8	t
1570	122	2024-09-10 00:05:47.700177	4211.06	1	4	t
1571	103	2024-12-22 06:58:59.29935	1751.06	1	8	t
1572	66	2025-05-15 00:04:21.511337	3207.64	1	8	t
1573	41	2024-10-11 01:18:31.422607	3032.28	1	5	t
1574	119	2024-10-03 02:43:15.904584	2955.86	1	4	t
1575	96	2025-04-17 14:57:48.594446	1956.47	1	2	t
1576	100	2025-01-15 18:02:09.591354	2711.18	1	3	t
1577	14	2025-02-20 21:04:38.857328	982.57	1	9	t
1578	186	2025-03-30 16:27:32.194914	3086.60	1	9	t
1579	34	2025-01-16 18:33:12.279945	2652.66	1	6	t
1580	77	2024-09-01 22:04:22.780657	4933.80	1	3	t
1581	184	2025-03-15 16:33:34.44357	448.29	1	7	t
1582	77	2024-07-07 17:23:23.344524	848.03	1	1	t
1583	190	2024-10-20 19:13:48.986488	1400.10	1	5	t
1584	167	2025-02-05 13:52:13.746606	4319.23	1	4	t
1585	97	2024-09-15 04:59:58.428708	2773.31	1	4	t
1586	87	2024-07-04 11:56:56.800936	2868.21	1	7	t
1587	85	2025-01-28 14:31:58.2136	3638.80	1	9	t
1588	168	2025-02-11 14:52:03.428892	3393.92	1	1	t
1589	15	2025-01-27 06:56:18.531924	1898.33	1	2	t
1590	157	2025-04-30 22:33:24.95881	4511.92	1	8	t
1591	177	2024-12-09 19:59:09.073194	3422.87	1	5	t
1592	12	2024-08-25 04:01:20.478463	1724.61	1	9	t
1593	172	2024-10-30 02:04:45.332598	1714.81	1	5	t
1594	163	2025-04-21 14:24:32.977948	303.01	1	2	t
1595	4	2024-12-03 06:08:59.054905	4451.45	1	7	t
1596	95	2025-01-23 06:12:22.261146	106.11	1	8	t
1597	164	2025-04-15 13:22:18.459862	2899.27	1	10	t
1598	84	2024-09-01 03:25:32.763883	3151.09	1	3	t
1599	155	2025-04-30 17:59:17.033601	1015.40	1	3	t
1600	7	2025-06-09 11:30:48.815919	4154.69	1	4	t
1601	109	2024-07-05 01:01:37.880749	3142.64	1	8	t
1602	196	2024-10-13 07:42:51.450625	2603.50	1	8	t
1603	93	2024-12-17 16:41:00.617441	4544.00	1	3	t
1604	118	2025-01-01 18:01:36.466471	3414.54	1	6	t
1605	8	2024-10-24 22:14:02.280333	997.38	1	2	t
1606	142	2025-05-09 21:05:54.863452	3960.30	1	7	t
1607	58	2025-05-30 13:29:46.459108	838.22	1	7	t
1608	196	2024-07-02 01:10:04.64932	3551.60	1	3	t
1609	93	2024-06-26 07:50:22.415382	730.00	1	4	t
1610	163	2024-12-22 07:29:27.661817	2029.73	1	9	t
1611	106	2025-03-03 09:31:10.660168	3507.84	1	7	t
1612	169	2024-06-30 01:32:04.282252	1389.46	1	5	t
1613	198	2025-05-17 22:11:39.090848	348.86	1	7	t
1614	22	2024-08-09 08:01:25.01635	4252.47	1	10	t
1615	66	2024-12-11 21:57:28.761097	86.57	1	5	t
1616	150	2024-07-09 01:31:20.057257	3575.76	1	2	t
1617	38	2025-06-11 03:27:02.888134	4802.21	1	3	t
1618	44	2025-01-16 12:57:11.05868	5038.02	1	3	t
1619	25	2025-04-15 09:41:04.791645	2624.23	1	9	t
1620	61	2024-11-01 02:19:37.985843	4261.29	1	3	t
1621	147	2024-06-20 07:22:55.424754	1110.74	1	3	t
1622	168	2025-02-01 16:18:42.0316	1969.48	1	4	t
1623	127	2024-06-26 19:56:09.838857	2335.35	1	10	t
1624	160	2025-04-20 03:47:03.577083	2645.72	1	3	t
1625	184	2025-05-08 02:46:37.10267	2106.98	1	10	t
1626	9	2025-02-03 09:52:26.008876	4317.53	1	10	t
1627	174	2024-07-10 04:01:21.890212	4335.39	1	9	t
1628	129	2024-08-27 19:54:22.448365	1288.39	1	10	t
1629	46	2025-05-12 17:40:24.079955	1047.96	1	4	t
1630	197	2025-01-14 20:55:44.661944	2359.66	1	2	t
1631	124	2024-11-01 04:21:27.921309	3033.74	1	4	t
1632	85	2024-08-06 22:35:47.825246	2966.26	1	8	t
1633	107	2024-08-01 14:41:04.334321	3094.02	1	6	t
1634	62	2025-04-06 21:49:47.928385	1751.01	1	10	t
1635	20	2024-09-12 05:54:06.778247	2214.33	1	2	t
1636	195	2025-06-04 18:31:07.658301	3991.37	1	2	t
1637	190	2024-09-25 16:08:36.145075	1480.00	1	4	t
1638	128	2025-06-03 00:13:02.09055	101.85	1	1	t
1639	57	2025-05-24 06:37:12.403654	2092.38	1	5	t
1640	160	2025-05-25 02:36:30.452554	2069.54	1	8	t
1641	199	2024-09-09 03:57:46.876065	1308.42	1	6	t
1642	18	2025-01-11 08:27:06.490171	912.64	1	5	t
1643	12	2025-05-17 12:54:07.937141	4817.78	1	4	t
1644	48	2024-11-17 15:29:34.635843	3018.35	1	6	t
1645	180	2024-08-13 17:57:42.866225	4293.05	1	8	t
1646	69	2024-11-12 06:53:05.276846	4448.18	1	8	t
1647	127	2025-02-22 17:14:34.236555	815.21	1	7	t
1648	102	2025-02-22 06:39:27.739469	2288.93	1	2	t
1649	151	2024-10-24 18:12:10.683431	3321.23	1	9	t
1650	173	2025-02-04 13:25:26.483832	821.79	1	7	t
1651	48	2025-03-22 16:07:49.897599	4922.79	1	6	t
1652	45	2025-04-17 09:29:56.426899	4565.98	1	5	t
1653	86	2024-12-11 03:24:09.117287	990.04	1	6	t
1654	161	2024-09-08 10:55:45.286486	620.07	1	5	t
1655	19	2024-08-06 02:59:07.153563	2365.05	1	6	t
1656	162	2024-07-04 11:51:32.991744	2916.54	1	2	t
1657	104	2025-04-20 23:42:46.112498	2622.54	1	6	t
1658	167	2024-07-28 16:18:55.909519	4573.96	1	8	t
1659	124	2025-03-23 19:52:20.957153	4083.70	1	9	t
1660	66	2025-05-01 15:15:11.139079	1756.08	1	7	t
1661	24	2025-03-20 12:15:42.128053	2544.58	1	3	t
1662	33	2024-11-10 13:38:28.73967	4326.24	1	6	t
1663	58	2025-03-22 23:28:58.573221	282.89	1	4	t
1664	80	2024-06-21 02:01:33.936236	3405.34	1	6	t
1665	32	2025-01-16 22:53:59.327763	3008.16	1	4	t
1666	79	2025-04-20 05:11:37.953551	103.19	1	8	t
1667	137	2025-03-04 12:10:48.182951	1324.67	1	3	t
1668	162	2024-09-16 23:13:27.114339	1525.08	1	6	t
1669	10	2025-03-10 05:06:13.153165	847.47	1	4	t
1670	85	2024-11-30 21:33:58.19785	3547.38	1	8	t
1671	87	2025-06-01 19:30:32.923638	1831.03	1	7	t
1672	186	2025-01-01 18:32:09.639096	469.19	1	4	t
1673	34	2024-12-18 06:44:48.082976	1456.06	1	6	t
1674	102	2025-03-16 17:31:00.969502	3591.78	1	6	t
1675	44	2025-05-17 18:35:26.764007	2900.54	1	4	t
1676	158	2024-09-30 15:53:00.084223	4751.01	1	10	t
1677	120	2024-11-08 05:24:58.767212	2437.28	1	10	t
1678	169	2024-09-06 02:10:40.507952	4301.24	1	7	t
1679	145	2025-04-07 20:24:30.013425	1206.92	1	6	t
1680	186	2024-10-27 12:00:20.495995	1565.43	1	6	t
1681	159	2025-03-06 08:32:33.064935	3535.30	1	5	t
1682	182	2025-03-03 14:02:53.311444	4349.94	1	3	t
1683	142	2024-12-16 14:08:50.964368	431.35	1	6	t
1684	11	2024-08-23 07:14:33.697806	1071.25	1	6	t
1685	182	2025-02-21 19:26:08.289261	3072.59	1	4	t
1686	23	2025-01-05 18:52:48.506659	2066.87	1	6	t
1687	35	2025-06-02 23:52:08.700315	234.47	1	1	t
1688	186	2024-11-20 23:08:27.983903	2831.44	1	9	t
1689	31	2024-09-18 00:28:49.129435	884.78	1	4	t
1690	141	2024-06-30 23:08:02.458997	3307.43	1	8	t
1691	189	2024-08-06 07:49:06.004622	1546.71	1	3	t
1692	28	2024-10-15 20:07:14.540394	329.14	1	8	t
1693	157	2025-06-07 11:37:14.858571	220.01	1	9	t
1694	87	2025-05-03 08:27:01.349575	4886.31	1	6	t
1695	183	2024-10-17 07:44:49.317596	3686.44	1	10	t
1696	38	2025-04-09 04:11:17.660129	1448.87	1	8	t
1697	56	2025-01-16 13:23:59.894445	4460.94	1	4	t
1698	17	2024-12-31 19:22:15.451941	4674.15	1	9	t
1699	53	2024-07-29 20:01:41.047585	1872.12	1	2	t
1700	160	2025-05-25 06:52:47.241069	203.94	1	9	t
1701	76	2025-04-02 10:41:14.892869	3729.46	1	1	t
1702	143	2025-04-28 05:49:42.009502	2739.81	1	5	t
1703	68	2024-11-01 08:20:20.464603	2626.09	1	4	t
1704	44	2025-04-07 17:59:17.595165	3910.90	1	9	t
1705	52	2025-01-02 04:44:13.245533	1483.88	1	3	t
1706	49	2025-03-03 15:41:16.724238	903.90	1	3	t
1707	37	2024-07-24 07:41:35.297317	945.93	1	5	t
1708	85	2024-11-02 00:26:02.217692	5032.47	1	7	t
1709	42	2024-07-06 07:31:53.968088	336.06	1	10	t
1710	129	2024-09-08 23:50:50.299491	4142.76	1	4	t
1711	120	2025-03-28 07:55:10.760997	4920.89	1	10	t
1712	26	2024-07-31 07:16:03.734209	3892.88	1	4	t
1713	15	2025-01-19 20:22:08.862838	4502.72	1	9	t
1714	189	2024-07-08 18:49:36.924795	1583.81	1	8	t
1715	4	2025-01-30 12:23:16.079549	2737.99	1	2	t
1716	182	2024-08-18 03:46:05.54753	2138.13	1	7	t
1717	103	2025-03-13 06:51:23.786906	4245.04	1	10	t
1718	63	2024-09-13 20:07:33.790767	1073.12	1	7	t
1719	139	2024-11-15 20:08:15.03897	2969.08	1	8	t
1720	50	2025-01-19 02:57:22.15234	3681.08	1	7	t
1721	33	2024-08-10 03:34:30.810314	420.20	1	5	t
1722	138	2024-12-27 22:43:26.472542	3542.56	1	5	t
1723	190	2025-04-04 07:14:45.693219	1998.16	1	8	t
1724	197	2025-01-25 05:37:02.540168	4032.05	1	10	t
1725	185	2024-09-28 01:55:58.037378	841.40	1	8	t
1726	198	2025-04-22 01:49:08.012391	4259.66	1	4	t
1727	10	2025-02-18 17:08:02.818112	3126.16	1	3	t
1728	2	2025-02-23 03:34:09.382903	1742.59	1	3	t
1729	153	2025-02-22 21:34:20.352336	1303.65	1	10	t
1730	122	2024-09-12 08:53:48.728575	2049.65	1	8	t
1731	147	2024-10-08 17:40:01.422216	3092.89	1	9	t
1732	119	2025-05-06 07:12:19.311706	1063.90	1	2	t
1733	146	2024-09-24 04:58:58.467997	4977.99	1	6	t
1734	137	2025-03-14 16:00:19.783339	1767.41	1	6	t
1735	119	2025-04-15 15:47:44.60357	1349.45	1	9	t
1736	19	2024-11-30 00:22:28.514318	4898.43	1	7	t
1737	192	2024-07-07 15:07:43.311796	2160.24	1	3	t
1738	165	2024-08-27 10:46:31.441425	1404.19	1	4	t
1739	93	2024-12-07 17:19:08.125455	3805.88	1	2	t
1740	136	2024-07-29 00:26:39.046409	4021.11	1	9	t
1741	114	2025-04-14 04:44:59.456193	4609.24	1	1	t
1742	12	2024-07-24 03:21:46.458465	2616.25	1	7	t
1743	63	2024-11-03 21:18:43.61334	4848.73	1	5	t
1744	95	2025-05-24 05:24:37.236628	2830.53	1	8	t
1745	2	2024-07-18 21:14:03.978863	444.24	1	4	t
1746	7	2025-02-11 07:20:13.607793	2928.53	1	4	t
1747	182	2024-08-11 09:20:59.172862	4747.97	1	1	t
1748	81	2025-01-28 01:10:29.469194	88.69	1	7	t
1749	165	2024-12-13 04:46:42.022913	2318.34	1	4	t
1750	79	2025-04-05 06:35:02.992495	1859.51	1	7	t
1751	152	2024-08-22 14:56:41.76147	2705.30	1	4	t
1752	130	2024-10-19 10:24:52.33341	2186.06	1	3	t
1753	193	2024-09-29 05:44:35.794259	4445.13	1	8	t
1754	62	2024-12-18 17:51:31.894348	2943.18	1	2	t
1755	200	2024-07-12 19:13:53.773697	2415.94	1	2	t
1756	67	2024-12-09 05:23:40.526528	522.26	1	6	t
1757	154	2025-05-01 08:44:07.40864	3734.72	1	8	t
1758	23	2025-01-21 11:18:46.140231	3156.34	1	3	t
1759	159	2024-12-06 01:24:48.610167	2360.83	1	2	t
1760	9	2025-05-09 04:47:42.503875	4626.10	1	8	t
1761	98	2024-07-01 22:08:01.235066	3549.03	1	8	t
1762	20	2024-07-30 04:35:08.289502	1700.04	1	5	t
1763	163	2024-09-07 22:46:20.935938	3544.46	1	6	t
1764	60	2025-02-12 05:54:08.19355	3165.28	1	5	t
1765	63	2025-05-14 04:57:59.645229	288.71	1	10	t
1766	12	2024-11-03 15:59:26.813936	4367.47	1	4	t
1767	25	2025-02-16 14:02:53.340574	4786.56	1	7	t
1768	109	2024-12-01 18:11:48.843808	130.48	1	1	t
1769	113	2025-01-26 00:51:18.711764	455.63	1	3	t
1770	161	2025-01-29 19:40:38.250837	2044.75	1	6	t
1771	55	2024-11-28 17:22:29.036448	4492.11	1	8	t
1772	40	2025-04-29 17:11:38.326492	5025.38	1	4	t
1773	143	2024-11-30 23:00:00.279995	3371.23	1	7	t
1774	114	2024-08-24 03:54:13.520137	51.62	1	7	t
1775	157	2024-08-08 03:46:52.031347	3279.79	1	3	t
1776	178	2024-12-12 21:25:04.880047	1964.35	1	3	t
1777	31	2024-07-13 19:05:46.562038	680.02	1	8	t
1778	117	2025-05-31 23:08:03.577607	1985.78	1	3	t
1779	90	2024-07-02 14:47:27.945436	439.03	1	8	t
1780	32	2025-01-02 22:20:46.981123	3905.24	1	10	t
1781	19	2024-10-29 04:28:40.22926	2810.83	1	7	t
1782	116	2025-02-05 02:42:46.065134	1910.88	1	5	t
1783	32	2024-06-20 23:04:37.678548	1510.31	1	5	t
1784	24	2024-08-28 09:41:22.11722	519.15	1	6	t
1785	124	2024-08-25 11:41:25.06942	2023.78	1	1	t
1786	177	2024-09-04 04:29:55.75602	4275.72	1	4	t
1787	170	2024-06-25 15:25:40.460902	4586.84	1	10	t
1788	67	2025-03-29 18:17:01.023677	2348.71	1	5	t
1789	106	2025-01-19 04:53:53.919994	3964.81	1	9	t
1790	189	2025-01-20 15:18:20.590351	4394.33	1	3	t
1791	109	2024-08-27 23:43:10.626883	4371.06	1	1	t
1792	73	2024-12-29 23:38:08.036017	2435.26	1	7	t
1793	11	2024-11-02 09:53:15.076827	983.20	1	6	t
1794	70	2024-12-31 22:26:26.025793	2839.51	1	10	t
1795	10	2024-11-05 12:09:28.705306	328.44	1	2	t
1796	105	2025-05-24 18:24:26.022189	326.11	1	2	t
1797	73	2024-08-06 05:27:54.825731	2245.31	1	4	t
1798	132	2024-12-09 20:53:40.055924	1095.82	1	6	t
1799	181	2024-10-31 13:48:00.652592	3928.11	1	7	t
1800	7	2025-04-16 11:11:06.515165	3636.17	1	3	t
1801	97	2024-11-08 23:19:30.682719	219.62	1	2	t
1802	132	2024-10-21 01:07:53.979349	3165.36	1	10	t
1803	83	2025-06-10 23:27:22.721696	4416.60	1	4	t
1804	69	2024-09-15 07:50:24.552523	4313.45	1	10	t
1805	160	2024-08-22 08:32:13.776001	970.25	1	2	t
1806	91	2024-07-31 04:18:39.255074	2799.63	1	5	t
1807	96	2024-12-04 14:53:18.778786	4151.75	1	3	t
1808	15	2024-12-20 23:04:15.391918	555.95	1	7	t
1809	67	2024-10-14 22:47:39.213639	3445.24	1	8	t
1810	155	2024-09-03 04:56:19.597977	3269.01	1	8	t
1811	12	2025-06-02 05:10:08.24093	249.00	1	2	t
1812	22	2024-11-02 17:10:29.202486	2417.53	1	7	t
1813	134	2024-10-24 02:52:29.282485	3605.00	1	9	t
1814	125	2024-06-20 08:11:53.772099	553.48	1	1	t
1815	3	2024-08-27 21:49:13.426448	1215.66	1	10	t
1816	75	2024-07-02 21:03:13.391618	3184.25	1	7	t
1817	118	2025-01-16 23:43:23.689807	340.44	1	10	t
1818	94	2025-02-26 20:01:46.480152	2316.30	1	3	t
1819	144	2024-07-20 11:59:16.274126	4339.09	1	4	t
1820	104	2024-08-17 03:05:30.938639	4044.17	1	3	t
1821	168	2025-01-30 11:05:41.695312	369.07	1	9	t
1822	164	2024-10-04 14:02:44.830165	3876.31	1	8	t
1823	53	2025-03-17 15:01:04.443794	4168.50	1	9	t
1824	75	2024-11-08 05:26:29.335552	4537.88	1	4	t
1825	5	2025-04-14 20:13:46.770199	4482.81	1	3	t
1826	56	2024-09-01 14:40:32.077613	1603.29	1	2	t
1827	39	2025-03-19 14:34:09.102869	2020.70	1	6	t
1828	59	2025-02-06 03:30:38.022561	3000.07	1	1	t
1829	52	2024-12-05 08:42:44.092998	2040.22	1	8	t
1830	14	2024-09-09 11:40:14.717686	2718.47	1	4	t
1831	127	2024-10-22 12:17:55.626882	1158.27	1	9	t
1832	78	2024-10-25 13:02:12.822287	550.11	1	9	t
1833	51	2025-03-13 00:14:30.899353	167.36	1	8	t
1834	54	2024-11-10 00:32:33.302412	4306.57	1	2	t
1835	90	2025-03-11 14:26:34.57716	2974.45	1	2	t
1836	87	2024-11-20 12:09:18.84052	2869.62	1	9	t
1837	98	2024-09-13 04:08:43.647061	223.75	1	2	t
1838	170	2025-04-11 22:39:11.532767	461.40	1	2	t
1839	130	2024-10-09 11:14:33.138506	4845.30	1	9	t
1840	117	2024-08-13 03:49:01.688304	4377.42	1	8	t
1841	14	2024-09-08 21:19:27.310944	524.40	1	7	t
1842	26	2025-02-23 11:18:18.567894	920.02	1	9	t
1843	189	2024-12-05 05:43:23.675639	1525.18	1	5	t
1844	17	2025-01-13 21:40:54.997769	540.29	1	6	t
1845	41	2025-02-19 11:27:56.647695	2984.69	1	2	t
1846	86	2025-06-04 20:30:50.389757	1045.97	1	8	t
1847	120	2025-02-05 09:56:07.166743	4299.92	1	3	t
1848	111	2025-02-15 01:41:20.186036	2178.83	1	3	t
1849	91	2024-07-25 19:28:12.064071	716.93	1	6	t
1850	83	2024-06-22 16:44:04.802566	490.91	1	3	t
1851	74	2025-01-02 17:54:57.563766	1649.40	1	4	t
1852	33	2025-04-20 15:33:27.276445	535.98	1	5	t
1853	4	2024-10-20 21:32:12.627274	1682.07	1	10	t
1854	150	2024-09-26 20:41:06.88476	2945.31	1	8	t
1855	9	2024-12-04 19:18:19.979731	2860.94	1	9	t
1856	136	2024-08-27 09:01:10.886509	1675.75	1	7	t
1857	119	2024-10-23 22:54:38.322404	962.85	1	3	t
1858	86	2024-11-15 02:32:25.61952	1576.58	1	8	t
1859	93	2025-02-28 10:50:32.791887	431.79	1	6	t
1860	59	2025-03-12 12:38:53.348198	123.99	1	6	t
1861	39	2024-07-23 23:24:05.211163	2162.04	1	6	t
1862	160	2024-12-24 04:43:30.537657	377.37	1	8	t
1863	64	2025-04-11 18:47:41.240879	2204.32	1	3	t
1864	72	2024-07-05 23:00:55.154568	1297.35	1	5	t
1865	144	2025-05-23 11:54:24.003315	3572.72	1	2	t
1866	175	2024-10-06 16:00:26.310771	946.55	1	5	t
1867	118	2025-04-27 14:04:39.700379	3563.98	1	9	t
1868	9	2024-10-02 09:47:49.640833	3326.05	1	1	t
1869	95	2025-04-03 04:11:03.262614	2280.63	1	9	t
1870	79	2024-08-24 21:02:01.98417	709.96	1	3	t
1871	139	2024-09-13 03:00:29.054305	706.66	1	8	t
1872	166	2024-07-08 03:25:02.549405	4834.47	1	3	t
1873	98	2025-05-25 12:38:17.571155	1210.92	1	5	t
1874	197	2024-11-22 13:40:06.454595	2252.26	1	8	t
1875	112	2024-07-26 05:38:09.721374	4363.32	1	4	t
1876	40	2025-01-03 13:09:36.50848	2993.55	1	8	t
1877	15	2025-03-18 17:19:22.759339	4669.29	1	9	t
1878	179	2025-05-12 01:45:37.270629	944.66	1	5	t
1879	83	2025-02-26 19:06:11.869096	2331.34	1	7	t
1880	194	2025-01-03 19:02:06.962185	3558.65	1	2	t
1881	78	2025-04-22 08:45:05.80642	4518.28	1	9	t
1882	115	2024-11-23 05:48:05.852861	4765.36	1	6	t
1883	136	2024-09-13 00:53:24.76769	898.77	1	2	t
1884	171	2025-06-05 22:52:57.829471	2402.86	1	7	t
1885	146	2024-10-02 14:06:13.364755	4173.43	1	4	t
1886	135	2024-11-18 01:23:31.36485	492.59	1	2	t
1887	74	2024-12-30 10:34:55.07305	1491.73	1	8	t
1888	80	2024-10-14 08:06:13.689522	2346.04	1	10	t
1889	132	2024-06-19 09:52:18.469143	4571.62	1	7	t
1890	155	2025-01-23 03:15:55.691449	4229.96	1	4	t
1891	108	2025-01-12 12:00:46.836889	2035.95	1	3	t
1892	186	2025-01-08 14:07:31.252139	3626.74	1	8	t
1893	79	2024-12-23 08:14:22.563276	2631.41	1	8	t
1894	50	2025-03-01 21:00:14.156555	1731.74	1	6	t
1895	150	2025-05-28 18:14:53.602519	2362.15	1	1	t
1896	71	2024-10-11 22:03:33.133192	3312.73	1	8	t
1897	57	2025-02-25 05:08:08.312327	2339.45	1	2	t
1898	179	2025-03-06 08:35:56.549257	4771.42	1	5	t
1899	165	2025-05-15 08:58:34.986696	737.39	1	2	t
1900	9	2024-09-02 06:10:05.045856	4571.60	1	6	t
1901	158	2025-06-05 22:25:55.50767	330.08	1	2	t
1902	144	2024-07-25 19:19:17.94757	1142.40	1	8	t
1903	95	2024-08-28 00:20:24.03381	1089.67	1	10	t
1904	82	2024-11-20 09:14:12.2597	1761.50	1	4	t
1905	55	2025-03-15 05:24:05.315417	2057.33	1	5	t
1906	117	2025-03-15 11:03:56.213818	3148.97	1	7	t
1907	177	2025-03-10 18:28:57.327395	3395.24	1	3	t
1908	91	2024-09-27 22:27:30.25278	4589.25	1	6	t
1909	25	2024-11-18 00:45:24.484279	1901.99	1	4	t
1910	171	2025-04-07 19:43:43.511943	1734.06	1	4	t
1911	82	2024-08-09 08:51:31.038536	4974.01	1	5	t
1912	186	2024-09-10 06:31:52.031314	859.66	1	8	t
1913	170	2024-09-01 09:21:25.591151	1480.45	1	9	t
1914	48	2024-11-11 02:05:37.278048	982.88	1	4	t
1915	99	2025-04-19 15:45:52.312854	1099.42	1	6	t
1916	21	2025-01-02 01:36:14.425053	2418.25	1	9	t
1917	176	2025-05-13 03:01:27.058781	4947.29	1	7	t
1918	56	2024-11-02 02:39:17.304874	1764.89	1	2	t
1919	46	2025-06-07 18:34:58.862717	2104.68	1	8	t
1920	18	2024-12-14 15:24:25.790692	270.27	1	3	t
1921	113	2024-10-27 01:56:36.456593	2376.79	1	8	t
1922	134	2024-09-16 11:08:45.814898	544.40	1	9	t
1923	86	2024-08-30 08:47:06.17546	3390.45	1	2	t
1924	112	2024-09-14 12:17:07.146819	4446.36	1	4	t
1925	7	2024-06-13 20:52:40.869432	4549.25	1	2	t
1926	140	2024-10-11 04:27:45.785775	3837.10	1	7	t
1927	79	2025-02-26 04:45:09.900594	2433.32	1	1	t
1928	198	2024-08-26 03:59:33.862949	1990.26	1	7	t
1929	154	2024-08-20 04:18:12.986581	1900.72	1	9	t
1930	27	2025-01-01 19:32:52.280516	1425.39	1	3	t
1931	20	2024-11-23 08:45:26.596149	4654.13	1	5	t
1932	107	2025-06-03 07:37:08.666393	2833.40	1	8	t
1933	160	2025-04-06 17:23:23.391456	1051.37	1	2	t
1934	56	2024-11-11 18:40:36.923749	2353.81	1	4	t
1935	54	2025-03-21 00:35:02.564423	3923.24	1	9	t
1936	193	2024-07-26 14:48:47.336641	3253.72	1	2	t
1937	157	2025-03-29 01:59:55.534165	4594.12	1	9	t
1938	198	2025-06-01 23:17:55.721788	88.55	1	3	t
1939	167	2024-09-08 03:24:23.911032	4785.58	1	6	t
1940	25	2024-09-09 08:55:24.346331	2590.43	1	10	t
1941	18	2025-04-27 17:54:59.669639	1289.92	1	5	t
1942	11	2024-11-25 05:10:22.78808	3062.65	1	7	t
1943	47	2024-09-17 12:31:25.585036	4463.20	1	4	t
1944	156	2024-07-29 09:05:06.35421	1512.91	1	4	t
1945	81	2025-04-11 06:57:07.9325	1623.75	1	7	t
1946	139	2024-08-26 08:32:13.695473	2196.86	1	10	t
1947	173	2025-05-18 02:21:52.246612	382.06	1	4	t
1948	24	2024-07-26 16:19:23.50623	1418.96	1	6	t
1949	29	2024-07-07 06:04:56.585518	3536.02	1	8	t
1950	173	2024-12-29 05:14:43.630321	4114.56	1	5	t
1951	137	2025-03-30 13:56:00.226256	961.51	1	4	t
1952	37	2025-01-20 17:39:58.578701	3274.75	1	10	t
1953	35	2025-02-19 18:26:04.699049	1543.34	1	10	t
1954	90	2025-06-01 17:43:37.957891	551.51	1	6	t
1955	171	2025-02-13 23:01:24.625058	2140.19	1	7	t
1956	72	2025-01-21 06:29:32.954386	4766.33	1	4	t
1957	135	2024-11-18 10:34:21.623028	2255.56	1	8	t
1958	183	2024-08-17 19:29:00.380195	3362.05	1	5	t
1959	80	2025-04-11 08:46:01.965672	5040.55	1	4	t
1960	99	2024-12-29 07:42:02.387473	4603.86	1	7	t
1961	79	2024-07-08 13:20:29.321417	3305.01	1	2	t
1962	104	2024-12-31 14:10:26.676018	3614.24	1	3	t
1963	40	2025-01-21 03:42:38.608359	1221.02	1	8	t
1964	41	2025-04-18 21:44:53.109503	3951.77	1	2	t
1965	126	2024-12-31 14:52:47.697904	3375.00	1	8	t
1966	183	2024-11-02 09:50:48.450317	3964.83	1	1	t
1967	141	2024-10-11 04:22:07.410646	2172.38	1	6	t
1968	44	2024-12-23 04:11:11.147518	2105.60	1	4	t
1969	59	2025-02-22 09:15:08.952692	1983.60	1	4	t
1970	156	2025-03-15 04:35:49.504956	3309.56	1	3	t
1971	155	2024-10-09 00:47:59.681786	1894.17	1	9	t
1972	14	2025-04-25 06:20:45.946702	1709.61	1	9	t
1973	194	2024-11-23 00:23:28.542559	161.37	1	5	t
1974	24	2025-04-11 00:06:07.84615	633.41	1	2	t
1975	36	2024-08-23 20:25:34.588141	487.27	1	3	t
1976	119	2025-03-30 16:08:38.232356	66.98	1	2	t
1977	142	2024-10-06 15:29:12.688874	3074.38	1	9	t
1978	62	2025-05-14 05:34:28.723259	174.17	1	4	t
1979	156	2025-04-04 13:11:00.847877	3718.47	1	3	t
1980	155	2025-05-31 05:17:38.595682	4600.88	1	8	t
1981	35	2025-05-21 01:08:27.021519	522.94	1	5	t
1982	56	2024-08-04 00:16:07.415901	2657.48	1	7	t
1983	39	2025-02-15 08:38:36.727416	957.04	1	3	t
1984	135	2025-04-16 16:41:33.672019	4178.38	1	5	t
1985	136	2025-05-11 19:50:53.310365	2400.19	1	4	t
1986	195	2025-05-25 10:05:35.30851	983.80	1	6	t
1987	17	2025-03-02 08:18:46.488292	2281.99	1	10	t
1988	161	2025-03-12 07:13:36.708325	2938.49	1	2	t
1989	97	2024-07-06 14:59:10.674584	346.28	1	5	t
1990	49	2024-10-03 15:49:07.119821	3885.35	1	6	t
1991	27	2025-05-16 03:54:29.275209	3294.01	1	2	t
1992	133	2025-02-19 13:48:07.331477	2963.94	1	9	t
1993	92	2025-02-17 01:31:35.334089	397.22	1	9	t
1994	178	2025-01-24 01:45:56.237482	4529.31	1	4	t
1995	30	2024-07-26 12:26:10.445833	125.37	1	7	t
1996	74	2025-01-24 05:43:55.76911	464.52	1	8	t
1997	37	2024-08-26 06:17:05.560727	4361.69	1	1	t
1998	128	2024-09-22 01:17:56.664212	287.47	1	7	t
1999	99	2025-02-25 04:24:02.847561	3886.23	1	2	t
2000	131	2024-09-22 11:05:23.978022	3498.52	1	2	t
2001	1	2025-06-12 18:10:01.528261	150.00	1	1	t
2020	22	2025-06-16 18:43:33.44081	1000.00	1	11	t
2002	1	2025-06-12 21:07:14.414103	480.00	1	1	t
2003	2	2025-06-12 21:27:37.625836	240.00	4	1	f
2004	3	2025-06-12 21:43:41.658606	300.00	1	1	t
2016	14	2025-06-16 16:03:24.218269	1000.00	1	11	f
2005	4	2025-06-12 22:04:23.342816	280.00	5	1	t
2006	200	2025-06-14 03:56:41.55539	250.00	3	11	t
2007	10	2025-06-14 05:28:31.108432	380.00	1	11	t
2008	17	2025-06-14 05:34:04.908623	100.00	1	11	f
2017	9	2025-06-16 16:11:13.77885	750.00	1	11	t
2021	60	2025-06-16 23:37:14.599228	70.00	5	11	t
2013	16	2025-06-16 14:48:03.758329	200.00	1	11	f
2012	20	2025-06-16 14:04:46.012499	380.00	5	11	t
2009	4	2025-06-14 06:15:17.213889	30.00	1	11	t
2010	29	2025-06-14 18:36:03.413991	550.00	1	11	t
2011	1	2025-06-14 18:36:34.651124	500.00	1	11	t
2014	3	2025-06-16 15:03:08.041894	20.00	1	11	f
2022	31	2025-06-17 03:24:36.317438	300.00	5	11	t
2015	10	2025-06-16 15:11:38.387237	200.00	2	11	t
2023	15	2025-06-17 03:31:40.649178	600.00	5	11	t
2019	17	2025-06-16 17:03:59.017909	200.00	5	11	t
2024	28	2025-06-17 03:44:33.283134	500.00	5	11	t
2018	16	2025-06-16 16:14:36.563099	160.00	5	11	t
2025	18	2025-06-17 03:48:16.311763	350.00	5	11	t
2026	19	2025-06-17 04:10:19.546315	40.00	5	11	t
2027	31	2025-06-17 04:22:46.810762	20.00	5	11	t
2029	12	2025-06-17 05:03:06.875619	150.00	5	11	t
2028	31	2025-06-17 04:59:34.046368	1150.00	5	11	f
2030	1	2025-06-17 05:04:56.307941	200.00	5	11	t
2031	8	2025-06-17 05:10:59.518376	45.00	5	11	t
2032	10	2025-06-17 05:27:19.124639	300.00	5	11	t
2033	4	2025-06-17 05:39:17.748528	150.00	5	11	t
2034	1	2025-06-17 05:51:49.12932	300.00	5	11	t
2035	11	2025-06-17 05:59:43.863541	250.00	5	11	t
2036	3	2025-06-17 06:06:42.367532	45.00	5	11	t
2037	200	2025-06-17 06:17:58.04172	200.00	5	11	t
\.


--
-- Name: categoriasproducto_categoriaid_seq; Type: SEQUENCE SET; Schema: public; Owner: erp_user
--

SELECT pg_catalog.setval('public.categoriasproducto_categoriaid_seq', 27, true);


--
-- Name: clientes_clienteid_seq; Type: SEQUENCE SET; Schema: public; Owner: erp_user
--

SELECT pg_catalog.setval('public.clientes_clienteid_seq', 200, true);


--
-- Name: cuentasporcobrar_cuentaid_seq; Type: SEQUENCE SET; Schema: public; Owner: erp_user
--

SELECT pg_catalog.setval('public.cuentasporcobrar_cuentaid_seq', 1803, true);


--
-- Name: detalleventas_detalleid_seq; Type: SEQUENCE SET; Schema: public; Owner: erp_user
--

SELECT pg_catalog.setval('public.detalleventas_detalleid_seq', 4082, true);


--
-- Name: facturas_facturaid_seq; Type: SEQUENCE SET; Schema: public; Owner: erp_user
--

SELECT pg_catalog.setval('public.facturas_facturaid_seq', 1800, true);


--
-- Name: metodospago_metodopagoid_seq; Type: SEQUENCE SET; Schema: public; Owner: erp_user
--

SELECT pg_catalog.setval('public.metodospago_metodopagoid_seq', 5, true);


--
-- Name: pagos_pagoid_seq; Type: SEQUENCE SET; Schema: public; Owner: erp_user
--

SELECT pg_catalog.setval('public.pagos_pagoid_seq', 1200, true);


--
-- Name: pasarelaspago_pasarelaid_seq; Type: SEQUENCE SET; Schema: public; Owner: erp_user
--

SELECT pg_catalog.setval('public.pasarelaspago_pasarelaid_seq', 1, false);


--
-- Name: productos_productoid_seq; Type: SEQUENCE SET; Schema: public; Owner: erp_user
--

SELECT pg_catalog.setval('public.productos_productoid_seq', 52, true);


--
-- Name: roles_roleid_seq; Type: SEQUENCE SET; Schema: public; Owner: erp_user
--

SELECT pg_catalog.setval('public.roles_roleid_seq', 4, true);


--
-- Name: transaccionespasarela_transaccionid_seq; Type: SEQUENCE SET; Schema: public; Owner: erp_user
--

SELECT pg_catalog.setval('public.transaccionespasarela_transaccionid_seq', 1, false);


--
-- Name: usuarioroles_usuarioroleid_seq; Type: SEQUENCE SET; Schema: public; Owner: erp_user
--

SELECT pg_catalog.setval('public.usuarioroles_usuarioroleid_seq', 11, true);


--
-- Name: usuarios_usuarioid_seq; Type: SEQUENCE SET; Schema: public; Owner: erp_user
--

SELECT pg_catalog.setval('public.usuarios_usuarioid_seq', 16, true);


--
-- Name: ventas_ventaid_seq; Type: SEQUENCE SET; Schema: public; Owner: erp_user
--

SELECT pg_catalog.setval('public.ventas_ventaid_seq', 2037, true);


--
-- Name: categoriasproducto categoriasproducto_nombre_key; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.categoriasproducto
    ADD CONSTRAINT categoriasproducto_nombre_key UNIQUE (nombre);


--
-- Name: categoriasproducto categoriasproducto_pkey; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.categoriasproducto
    ADD CONSTRAINT categoriasproducto_pkey PRIMARY KEY (categoriaid);


--
-- Name: clientes clientes_correo_key; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_correo_key UNIQUE (correo);


--
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (clienteid);


--
-- Name: cuentasporcobrar cuentasporcobrar_pkey; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.cuentasporcobrar
    ADD CONSTRAINT cuentasporcobrar_pkey PRIMARY KEY (cuentaid);


--
-- Name: cuentasporcobrar cuentasporcobrar_ventaid_key; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.cuentasporcobrar
    ADD CONSTRAINT cuentasporcobrar_ventaid_key UNIQUE (ventaid);


--
-- Name: detalleventas detalleventas_pkey; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.detalleventas
    ADD CONSTRAINT detalleventas_pkey PRIMARY KEY (detalleid);


--
-- Name: facturas facturas_numerofactura_key; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT facturas_numerofactura_key UNIQUE (numerofactura);


--
-- Name: facturas facturas_pkey; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT facturas_pkey PRIMARY KEY (facturaid);


--
-- Name: facturas facturas_ventaid_key; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT facturas_ventaid_key UNIQUE (ventaid);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: metodospago metodospago_pkey; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.metodospago
    ADD CONSTRAINT metodospago_pkey PRIMARY KEY (metodopagoid);


--
-- Name: pagos pagos_pkey; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_pkey PRIMARY KEY (pagoid);


--
-- Name: pasarelaspago pasarelaspago_nombre_key; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.pasarelaspago
    ADD CONSTRAINT pasarelaspago_nombre_key UNIQUE (nombre);


--
-- Name: pasarelaspago pasarelaspago_pkey; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.pasarelaspago
    ADD CONSTRAINT pasarelaspago_pkey PRIMARY KEY (pasarelaid);


--
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (productoid);


--
-- Name: roles roles_nombre_key; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_nombre_key UNIQUE (nombre);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (roleid);


--
-- Name: transaccionespasarela transaccionespasarela_pkey; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.transaccionespasarela
    ADD CONSTRAINT transaccionespasarela_pkey PRIMARY KEY (transaccionid);


--
-- Name: usuarioroles uq_usuario_roles; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.usuarioroles
    ADD CONSTRAINT uq_usuario_roles UNIQUE (usuarioid, roleid);


--
-- Name: usuarioroles usuarioroles_pkey; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.usuarioroles
    ADD CONSTRAINT usuarioroles_pkey PRIMARY KEY (usuarioroleid);


--
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- Name: usuarios usuarios_nombreusuario_key; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_nombreusuario_key UNIQUE (nombreusuario);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (usuarioid);


--
-- Name: ventas ventas_pkey; Type: CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_pkey PRIMARY KEY (ventaid);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: erp_user
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: categoriasproducto tg_prevent_delete_categoriasproducto; Type: TRIGGER; Schema: public; Owner: erp_user
--

CREATE TRIGGER tg_prevent_delete_categoriasproducto BEFORE DELETE ON public.categoriasproducto FOR EACH ROW EXECUTE FUNCTION public.sp_prevent_delete_categoriasproducto();


--
-- Name: clientes tg_prevent_delete_clientes; Type: TRIGGER; Schema: public; Owner: erp_user
--

CREATE TRIGGER tg_prevent_delete_clientes BEFORE DELETE ON public.clientes FOR EACH ROW EXECUTE FUNCTION public.sp_prevent_delete_clientes();


--
-- Name: cuentasporcobrar tg_prevent_delete_cuentasporcobrar; Type: TRIGGER; Schema: public; Owner: erp_user
--

CREATE TRIGGER tg_prevent_delete_cuentasporcobrar BEFORE DELETE ON public.cuentasporcobrar FOR EACH ROW EXECUTE FUNCTION public.sp_prevent_delete_cuentasporcobrar();


--
-- Name: detalleventas tg_prevent_delete_detalleventas; Type: TRIGGER; Schema: public; Owner: erp_user
--

CREATE TRIGGER tg_prevent_delete_detalleventas BEFORE DELETE ON public.detalleventas FOR EACH ROW EXECUTE FUNCTION public.sp_prevent_delete_detalleventas();


--
-- Name: facturas tg_prevent_delete_facturas; Type: TRIGGER; Schema: public; Owner: erp_user
--

CREATE TRIGGER tg_prevent_delete_facturas BEFORE DELETE ON public.facturas FOR EACH ROW EXECUTE FUNCTION public.sp_prevent_delete_facturas();


--
-- Name: metodospago tg_prevent_delete_metodospago; Type: TRIGGER; Schema: public; Owner: erp_user
--

CREATE TRIGGER tg_prevent_delete_metodospago BEFORE DELETE ON public.metodospago FOR EACH ROW EXECUTE FUNCTION public.sp_prevent_delete_metodospago();


--
-- Name: pagos tg_prevent_delete_pagos; Type: TRIGGER; Schema: public; Owner: erp_user
--

CREATE TRIGGER tg_prevent_delete_pagos BEFORE DELETE ON public.pagos FOR EACH ROW EXECUTE FUNCTION public.sp_prevent_delete_pagos();


--
-- Name: pasarelaspago tg_prevent_delete_pasarelaspago; Type: TRIGGER; Schema: public; Owner: erp_user
--

CREATE TRIGGER tg_prevent_delete_pasarelaspago BEFORE DELETE ON public.pasarelaspago FOR EACH ROW EXECUTE FUNCTION public.sp_prevent_delete_pasarelaspago();


--
-- Name: productos tg_prevent_delete_productos; Type: TRIGGER; Schema: public; Owner: erp_user
--

CREATE TRIGGER tg_prevent_delete_productos BEFORE DELETE ON public.productos FOR EACH ROW EXECUTE FUNCTION public.sp_prevent_delete_productos();


--
-- Name: roles tg_prevent_delete_roles; Type: TRIGGER; Schema: public; Owner: erp_user
--

CREATE TRIGGER tg_prevent_delete_roles BEFORE DELETE ON public.roles FOR EACH ROW EXECUTE FUNCTION public.sp_prevent_delete_roles();


--
-- Name: transaccionespasarela tg_prevent_delete_transaccionespasarela; Type: TRIGGER; Schema: public; Owner: erp_user
--

CREATE TRIGGER tg_prevent_delete_transaccionespasarela BEFORE DELETE ON public.transaccionespasarela FOR EACH ROW EXECUTE FUNCTION public.sp_prevent_delete_transaccionespasarela();


--
-- Name: usuarioroles tg_prevent_delete_usuarioroles; Type: TRIGGER; Schema: public; Owner: erp_user
--

CREATE TRIGGER tg_prevent_delete_usuarioroles BEFORE DELETE ON public.usuarioroles FOR EACH ROW EXECUTE FUNCTION public.sp_prevent_delete_usuarioroles();


--
-- Name: usuarios tg_prevent_delete_usuarios; Type: TRIGGER; Schema: public; Owner: erp_user
--

CREATE TRIGGER tg_prevent_delete_usuarios BEFORE DELETE ON public.usuarios FOR EACH ROW EXECUTE FUNCTION public.sp_prevent_delete_usuarios();


--
-- Name: ventas tg_prevent_delete_ventas; Type: TRIGGER; Schema: public; Owner: erp_user
--

CREATE TRIGGER tg_prevent_delete_ventas BEFORE DELETE ON public.ventas FOR EACH ROW EXECUTE FUNCTION public.sp_prevent_delete_ventas();


--
-- Name: clientes clientes_creadoporusuarioid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_creadoporusuarioid_fkey FOREIGN KEY (creadoporusuarioid) REFERENCES public.usuarios(usuarioid);


--
-- Name: cuentasporcobrar cuentasporcobrar_clienteid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.cuentasporcobrar
    ADD CONSTRAINT cuentasporcobrar_clienteid_fkey FOREIGN KEY (clienteid) REFERENCES public.clientes(clienteid);


--
-- Name: cuentasporcobrar cuentasporcobrar_ventaid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.cuentasporcobrar
    ADD CONSTRAINT cuentasporcobrar_ventaid_fkey FOREIGN KEY (ventaid) REFERENCES public.ventas(ventaid);


--
-- Name: detalleventas detalleventas_productoid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.detalleventas
    ADD CONSTRAINT detalleventas_productoid_fkey FOREIGN KEY (productoid) REFERENCES public.productos(productoid);


--
-- Name: detalleventas detalleventas_ventaid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.detalleventas
    ADD CONSTRAINT detalleventas_ventaid_fkey FOREIGN KEY (ventaid) REFERENCES public.ventas(ventaid);


--
-- Name: facturas facturas_creadoporusuarioid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT facturas_creadoporusuarioid_fkey FOREIGN KEY (creadoporusuarioid) REFERENCES public.usuarios(usuarioid);


--
-- Name: facturas facturas_ventaid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.facturas
    ADD CONSTRAINT facturas_ventaid_fkey FOREIGN KEY (ventaid) REFERENCES public.ventas(ventaid);


--
-- Name: productos fk_categoria_producto; Type: FK CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT fk_categoria_producto FOREIGN KEY (categoriaid) REFERENCES public.categoriasproducto(categoriaid);


--
-- Name: pagos pagos_cuentaid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.pagos
    ADD CONSTRAINT pagos_cuentaid_fkey FOREIGN KEY (cuentaid) REFERENCES public.cuentasporcobrar(cuentaid);


--
-- Name: transaccionespasarela transaccionespasarela_iniciadaporusuarioid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.transaccionespasarela
    ADD CONSTRAINT transaccionespasarela_iniciadaporusuarioid_fkey FOREIGN KEY (iniciadaporusuarioid) REFERENCES public.usuarios(usuarioid);


--
-- Name: transaccionespasarela transaccionespasarela_pasarelaid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.transaccionespasarela
    ADD CONSTRAINT transaccionespasarela_pasarelaid_fkey FOREIGN KEY (pasarelaid) REFERENCES public.pasarelaspago(pasarelaid);


--
-- Name: transaccionespasarela transaccionespasarela_ventaid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.transaccionespasarela
    ADD CONSTRAINT transaccionespasarela_ventaid_fkey FOREIGN KEY (ventaid) REFERENCES public.ventas(ventaid);


--
-- Name: usuarioroles usuarioroles_roleid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.usuarioroles
    ADD CONSTRAINT usuarioroles_roleid_fkey FOREIGN KEY (roleid) REFERENCES public.roles(roleid);


--
-- Name: usuarioroles usuarioroles_usuarioid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.usuarioroles
    ADD CONSTRAINT usuarioroles_usuarioid_fkey FOREIGN KEY (usuarioid) REFERENCES public.usuarios(usuarioid);


--
-- Name: ventas ventas_clienteid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_clienteid_fkey FOREIGN KEY (clienteid) REFERENCES public.clientes(clienteid);


--
-- Name: ventas ventas_creadoporusuarioid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_creadoporusuarioid_fkey FOREIGN KEY (creadoporusuarioid) REFERENCES public.usuarios(usuarioid);


--
-- Name: ventas ventas_metodopagoid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: erp_user
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_metodopagoid_fkey FOREIGN KEY (metodopagoid) REFERENCES public.metodospago(metodopagoid);


--
-- PostgreSQL database dump complete
--

