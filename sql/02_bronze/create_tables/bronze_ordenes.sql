-- ============================================================
-- Tabla: bronze.ordenes
-- Descripción: Almacena la información básica de las ordenes
-- --              de la empresa. Cada registro representa una
-- --              orden.
-- Autor: Teofilo Correa Rojas
-- Fecha: 18 de mayo 2026
-- ============================================================

CREATE TABLE IF NOT EXISTS bronze.ordenes (

    id              SERIAL          PRIMARY KEY,
    cliente_id      INTEGER,
    empleado_id     INTEGER,
    fecha_orden     DATE            NOT NULL,
    estado          VARCHAR(50)     NOT NULL,
    total           NUMERIC(10,2)   NOT NULL,
    created_at      TIMESTAMP       NOT NULL,
    source_file     VARCHAR(100)    NOT NULL,
    load_date       TIMESTAMP       NOT NULL DEFAULT now(),
    record_status   VARCHAR(20)     NOT NULL
);