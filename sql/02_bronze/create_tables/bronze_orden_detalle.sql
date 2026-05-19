-- ============================================================
-- Tabla: bronze.orden_detalle
-- Descripción: Almacena la información básica de los detalles de las ordenes
-- --              de la empresa. Cada registro representa
-- --              un detalle de la orden adquirida.
-- Autor: Teofilo Correa Rojas
-- Fecha: 18 de mayo 2026
-- ============================================================

CREATE TABLE IF NOT EXISTS bronze.orden_detalle (

    id                  SERIAL PRIMARY KEY,
    orden_id            INTEGER,
    producto_id         INTEGER,
    cantidad            INTEGER             NOT NULL,
    precio_unitario     NUMERIC(10,2)       NOT NULL,
    subtotal            NUMERIC(10,2)       NOT NULL,
    created_at          TIMESTAMP           NOT NULL,
    source_file         VARCHAR(100)        NOT NULL,
    load_file           TIMESTAMP           NOT NULL DEFAULT now(),
    record_status       VARCHAR(20)         NOT NULL
);