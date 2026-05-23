-- ============================================================
-- Script : INSERT SELECT — STG → Bronze
-- Tabla  : bronze.ordenes
-- Origen : stg.ordenes
-- Destino: bronze.ordenes
-- Autor  : Teofilo Correa Rojas
-- Fecha  : 22 de mayo 2026
-- ============================================================

INSERT INTO bronze.ordenes (cliente_id, empleado_id, fecha_orden, estado, total, created_at, source_file, record_status)

    SELECT
        cliente_id,
        empleado_id,
        fecha_orden,
        estado,
        total,
        created_at,
        'stg_ordenes',
        'active'
FROM stg.ordenes;