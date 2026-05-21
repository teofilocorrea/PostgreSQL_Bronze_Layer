-- ============================================================
-- Script : INSERT SELECT — STG → Bronze
-- Tabla  : bronze.categorias
-- Origen : stg.categorias
-- Destino: bronze.categorias
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 18 de mayo 2026
-- ============================================================

INSERT INTO bronze.categorias(nombre, descripcion, activo, created_at, source_file, record_status)
SELECT
    nombre,
    descripcion,
    activo,
    created_at,
    'manual',
    'active'
FROM stg.categorias;