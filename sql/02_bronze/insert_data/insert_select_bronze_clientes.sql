-- ============================================================
-- Script : INSERT SELECT — STG → Bronze
-- Tabla  : bronze.clientes
-- Origen : stg.clientes
-- Destino: bronze.clientes
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 22 de mayo 2026
-- ============================================================

INSERT INTO bronze.clientes(nombre, email, telefono, ciudad, pais, fecha_registro, activo, created_at, source_file, record_status)

SELECT
    nombre,
    email,
    telefono,
    ciudad,
    pais,
    fecha_registro,
    activo,
    created_at,
    'stg_clientes',
    'active'
FROM stg.clientes;