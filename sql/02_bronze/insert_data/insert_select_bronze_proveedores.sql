-- ============================================================
-- Script : INSERT SELECT — STG → Bronze
-- Tabla  : bronze.proveedores
-- Origen : stg.proveedores
-- Destino: bronze.proveedores
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 21 de mayo 2026
-- ============================================================

INSERT INTO bronze.proveedores(nombre, contacto, email, telefono, pais, activo, created_at, source_file, record_status)

SELECT
    nombre,
    contacto,
    email,
    telefono,
    pais,
    activo,
    created_at,
    'manual',
    'active'
FROM stg.proveedores;