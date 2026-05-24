![Banner](sql/02_bronze/asset/table_design_SQL_bronze.png)

## 📌 Descripción

Este proyecto tiene como objetivo construir y documentar las **tablas
de la capa Bronze** de una plataforma de datos en PostgreSQL,
aplicando la arquitectura Medallion como base de organización.

El enfoque es práctico y progresivo, aprendiendo columnas de auditoría,
trazabilidad del dato y el proceso de carga entre capas con INSERT SELECT.

---

## 🎯 Objetivos del proyecto

- Replicar las tablas STG agregando columnas de auditoría
- Documentar el origen y estado de cada registro
- Aplicar DEFAULT NOW() para automatizar la fecha de carga
- Cargar datos entre capas usando INSERT SELECT
- Documentar el modelo de datos como Diccionario de Datos
- Sentar las bases para la capa Silver

---

## 🏗️ Arquitectura — Bronze Layer

```
Arquitectura Medallion
│
├── STG     ← Proyecto 2
├── Bronze  ← este proyecto
├── Silver  ← Proyecto 4
└── Gold    ← Proyecto 5
```

La capa Bronze es una copia fiel de STG con columnas
de auditoría agregadas para registrar la trazabilidad del dato.

**Reglas de esta capa:**
- Solo PRIMARY KEY como constraint
- Sin UNIQUE, CHECK ni FK formales
- Columnas de auditoría obligatorias en todas las tablas
- DEFAULT NOW() en load_date
- Datos cargados con INSERT SELECT desde STG

---

## 🧱 Estructura del proyecto

```
PostgreSQL_Bronze_Layer/
│
├── docs/
│   ├── data_dictionary.md
│   └── project_closure.md
│
├── sql/
│   └── 02_bronze/
│       ├── asset/
│       │   └── table_design_SQL_bronze.png
│       ├── create_tables/
│       │   ├── 01_create_categorias.sql
│       │   ├── 02_create_proveedores.sql
│       │   ├── 03_create_productos.sql
│       │   ├── 04_create_empleados.sql
│       │   ├── 05_create_clientes.sql
│       │   ├── 06_create_ordenes.sql
│       │   └── 07_create_orden_detalle.sql
│       ├── insert_data/
│       │   ├── 01_insert_categorias.sql
│       │   ├── 02_insert_proveedores.sql
│       │   ├── 03_insert_productos.sql
│       │   ├── 04_insert_empleados.sql
│       │   ├── 05_insert_clientes.sql
│       │   ├── 06_insert_ordenes.sql
│       │   └── 07_insert_orden_detalle.sql
│       ├── README.md
│       └── data_dictionary_bronze.md
│
├── .gitignore
└── README.md
```
---

## 📊 Entidades del modelo

| Tabla | Descripción | Campos STG | Campos Auditoría |
|---|---|---|---|
| `bronze.categorias` | Categorías de productos | 5 | 3 |
| `bronze.proveedores` | Proveedores de la empresa | 8 | 3 |
| `bronze.productos` | Catálogo de productos | 9 | 3 |
| `bronze.empleados` | Empleados de la empresa | 7 | 3 |
| `bronze.clientes` | Clientes registrados | 9 | 3 |
| `bronze.ordenes` | Órdenes de compra | 7 | 3 |
| `bronze.orden_detalle` | Detalle de cada orden | 7 | 3 |

---

## 📖 Diccionario de Datos

### Columnas de auditoría — presentes en todas las tablas

| Campo | Tipo | Descripción | Valores permitidos |
|---|---|---|---|
| `source_file` | VARCHAR(100) | Origen del dato | `'manual'`, `'stg_nombre_tabla'` |
| `load_date` | TIMESTAMP | Fecha y hora de carga | DEFAULT NOW() |
| `record_status` | VARCHAR(20) | Estado del registro | `'active'`, `'inactive'`, `'pending'`, `'error'` |

### Documentación completa
📄 [data_dictionary_bronze.md](sql/02_bronze/data_dictionary_bronze.md)

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

## 🔗 Proyectos relacionados

| # | Proyecto | Descripción |
|---|---|---|
| 1 | [PostgreSQL_Database_Infrastructure](https://github.com/teofilocorrea/PostgreSQL_Database_Infrastructure) | Base de datos y esquemas |
| 2 | [PostgreSQL_Table_Design](https://github.com/teofilocorrea/PostgreSQL_Table_Design) | STG Layer |
| 3 | PostgreSQL_Bronze_Layer | Bronze Layer ← estás aquí |
| 4 | PostgreSQL_Silver_Layer | Silver + constraints + FK |
| 5 | PostgreSQL_Data_Modeling | Gold + Star Schema |

---

## 👤 Autor

### Teófilo Correa Rojas

**Data Analytics | Data Engineering en formación**

🔗 [LinkedIn](https://www.linkedin.com/in/teófilo-correa-rojas/)