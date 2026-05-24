-- ============================================================
-- Tabla: bronze.empleados
-- Descripción: Almacena la información básica de los empleados
-- --              de la empresa. Cada registro representa un
-- --              empleado.
-- Autor: Teofilo Correa Rojas
-- Fecha: 18 de mayo 2026
-- ============================================================

CREATE TABLE IF NOT EXISTS bronze.empleados (

    id              SERIAL          PRIMARY KEY,
    nombre          VARCHAR(250)    NOT NULL,
    email           VARCHAR(100)    NOT NULL,
    cargo           VARCHAR(250)    NOT NULL,
    fecha_ingreso   DATE            NOT NULL,
    activo          BOOLEAN         NOT NULL,
    created_at       TIMESTAMP       NOT NULL,
    source_file     VARCHAR(100)    NOT NULL,
    load_date       TIMESTAMP       NOT NULL DEFAULT now(),
    record_status   VARCHAR(20)     NOT NULL
);