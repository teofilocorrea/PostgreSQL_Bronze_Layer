-- ============================================================
-- Script : INSERT SELECT — STG → Bronze
-- Tabla  : bronze.productos
-- Origen : stg.productos
-- Destino: bronze.productos
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 21 de mayo 2026
-- ============================================================

INSERT INTO bronze.productos (nombre, descripcion, precio, stock, categoria_id, proveedor_id, activo, created_at, source_file, record_status)

SELECT
    nombre,
    descripcion,
    precio,
    stock,
    categoria_id,
    proveedor_id,
    activo,
    created_at,
    'stg_productos',
    'active'
FROM stg.productos;