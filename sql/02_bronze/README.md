![Banner](asset/table_design_SQL_bronze.png)

## ¿Qué es esta capa?

La capa Bronze es la segunda capa de la arquitectura Medallion.
Es una copia fiel de la capa STG con columnas de auditoría agregadas.
Su propósito es registrar de dónde vino el dato, cuándo llegó y su estado.

---

## 📋 Reglas de esta capa

- Solo PRIMARY KEY como constraint
- Sin validaciones de negocio
- Sin UNIQUE ni CHECK
- Columnas de auditoría obligatorias en todas las tablas
- DEFAULT NOW() en load_date
- Los datos se copian desde STG con INSERT SELECT

---

## 📊 Tablas

| Tabla | Descripción | Origen |
|---|---|---|
| `bronze.categorias` | Categorías de productos | `stg.categorias` |~~~~
| `bronze.proveedores` | Proveedores de la empresa | `stg.proveedores` |~~~~
| `bronze.productos` | Catálogo de productos | `stg.productos` |
| `bronze.empleados` | Empleados de la empresa | `stg.empleados` |
| `bronze.clientes` | Clientes registrados | `stg.clientes` |
| `bronze.ordenes` | Órdenes de compra | `stg.ordenes` |
| `bronze.orden_detalle` | Detalle de cada orden | `stg.orden_detalle` |

---

## 🔵 Data Steward — Bronze Layer

### Columnas de auditoría

Todas las tablas Bronze tienen estas 3 columnas adicionales:

| Campo | Tipo | Descripción | Valores permitidos |
|---|---|---|---|
| `source_file` | VARCHAR(100) | Nombre del archivo o fuente de origen | `'manual'`, `'stg_nombre_tabla'` |
| `load_date` | TIMESTAMP | Fecha y hora exacta de carga | DEFAULT NOW() — se genera automático |
| `record_status` | VARCHAR(20) | Estado del registro | `'active'`, `'inactive'`, `'pending'`, `'error'` |

### Documentación completa
📄 [data_steward_bronze.md](data_steward_bronze.md)

---

## 🔄 Proceso de carga — INSERT SELECT

Los datos se copian desde STG hacia Bronze usando INSERT SELECT:

```sql
INSERT INTO bronze.categorias (
    nombre,
    descripcion,
    activo,
    created_at,
    source_file,
    record_status
)
SELECT
    nombre,
    descripcion,
    activo,
    created_at,
    'stg_categorias',
    'active'
FROM stg.categorias;
```

---

## 🗂️ Estructura de archivos

02_bronze/
├── create_tables/
│   ├── 01_create_categorias.sql
│   ├── 02_create_proveedores.sql
│   ├── 03_create_productos.sql
│   ├── 04_create_empleados.sql
│   ├── 05_create_clientes.sql
│   ├── 06_create_ordenes.sql
│   └── 07_create_orden_detalle.sql
├── insert_data/
│   ├── 01_insert_categorias.sql
│   ├── 02_insert_proveedores.sql
│   ├── 03_insert_productos.sql
│   ├── 04_insert_empleados.sql
│   ├── 05_insert_clientes.sql
│   ├── 06_insert_ordenes.sql
│   └── 07_insert_orden_detalle.sql
├── README.md
└── data_steward_bronze.md

---

## 🔗 Capas relacionadas

| Capa | Descripción |
|---|---|
| ⬆️ STG | Origen de los datos — [ver capa STG](../../README.md) |
| ➡️ **Bronze** | Estás aquí |
| ⬇️ Silver | Próxima capa — datos limpios y validados |