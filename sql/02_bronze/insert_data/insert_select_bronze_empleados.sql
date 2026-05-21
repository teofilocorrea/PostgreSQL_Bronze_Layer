-- ============================================================
-- Script : INSERT SELECT — STG → Bronze
-- Tabla  : bronze.empleados
-- Origen : stg.empleados
-- Destino: bronze.empleados
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 21 de mayo 2026
-- ============================================================

INSERT INTO bronze.empleados (nombre, email, cargo, fecha_ingreso, activo, created_at, source_file, record_status)

SELECT
    nombre,
    email,
    cargo,
    fecha_ingreso,
    activo,
    created_at,
    'stg_empleados',
    'active'
FROM stg.empleados;
