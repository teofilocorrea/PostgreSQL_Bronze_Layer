-- ============================================================
-- Tabla: bronze.clientes
-- Descripción: Almacena la información básica de los clientes
-- --              de la empresa. Cada registro representa un
-- --              clientes.
-- Autor: Teofilo Correa Rojas
-- Fecha: 18 de mayo 2026
-- ============================================================

CREATE TABLE IF NOT EXISTS bronze.clientes (

    id              SERIAL                  PRIMARY KEY,
    nombre          VARCHAR(250)            NOT NULL,
    email           VARCHAR(100)            NOT NULL,
    telefono        VARCHAR(30),
    ciudad          VARCHAR(250),
    pais            VARCHAR(250),
    fecha_registro  DATE                    NOT NULL,
    activo          BOOLEAN                 NOT NULL,
    created_at      TIMESTAMP               NOT NULL,
    source_file     VARCHAR(100)            NOT NULL,
    load_date       TIMESTAMP               NOT NULL DEFAULT now(),
    record_status   VARCHAR(20)             NOT NULL
);