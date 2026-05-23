-- ============================================================
-- Script : INSERT SELECT — STG → Bronze
-- Tabla  : bronze.orden_detalle
-- Origen : stg.orden_detalle
-- Destino: bronze.orden_detalle
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 22 de mayo 2026
-- ============================================================

INSERT INTO bronze.orden_detalle(orden_id, producto_id, cantidad, precio_unitario, subtotal, created_at, source_file, record_status)

SELECT
    orden_id,
    producto_id,
    cantidad,
    precio_unitario,
    subtotal,
    created_at,
    'stg_orden_detalle',
    'active'
FROM stg.orden_detalle;