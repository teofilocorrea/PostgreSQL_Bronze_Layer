-- ============================================================
-- Tabla: bronze.proveedores
-- Descripción: Almacena la información básica de los proveedores
-- --              de la empresa. Cada registro representa
-- --              proveedores adquirido.
-- Autor: Teofilo Correa Rojas
-- Fecha: 16 de mayo 2026
-- ============================================================

CREATE TABLE IF NOT EXISTS bronze.proveedores (

    id              SERIAL              PRIMARY KEY,
    nombre          VARCHAR(100)        NOT NULL,
    contacto        VARCHAR(150),
    email           VARCHAR(150),
    telefono        VARCHAR(15),
    pais            VARCHAR(100),
    activo          BOOLEAN             NOT NULL,
    created_at      TIMESTAMP           NOT NULL,
    source_file     VARCHAR(100)        NOT NULL,
    load_date       TIMESTAMP           NOT NULL DEFAULT NOW(),
    record_status   VARCHAR(20)         NOT NULL
);