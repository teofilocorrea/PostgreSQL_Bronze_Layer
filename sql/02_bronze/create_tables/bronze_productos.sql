-- ============================================================
-- Tabla: bronze.productos
-- Descripción: Almacena la información básica de los productos
-- --              de la empresa. Cada registro representa un
-- --              producto adquirido.
-- Autor: Teofilo Correa Rojas
-- Fecha: 18 de mayo 2026
-- ============================================================

CREATE TABLE IF NOT EXISTS bronze.productos (

    id              SERIAL          PRIMARY KEY,
    nombre          VARCHAR(100)    NOT NULL,
    descripcion     TEXT,
    precio          NUMERIC(10,2)   NOT NULL,
    stock           INTEGER         NOT NULL,
    categoria_id    INTEGER,
    proveedor_id    INTEGER,
    activo          BOOLEAN         NOT NULL,
    created_at      TIMESTAMP       NOT NULL,
    source_file     VARCHAR(100)    NOT NULL,
    load_date       TIMESTAMP       NOT NULL DEFAULT NOW(),
    record_status   VARCHAR(20) NOT NULL
);