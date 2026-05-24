# Project Closure — PostgreSQL Bronze Layer

## 📋 Información del proyecto

| Campo | Detalle |
|---|---|
| **Proyecto** | PostgreSQL Bronze Layer |
| **Autor** | Teófilo Correa Rojas |
| **Fecha inicio** | Mayo 2026 |
| **Fecha cierre** | Mayo 2026 |
| **Estado** | ✅ Completado |

---

## 🎯 Objetivos — ¿Se cumplieron?

| Objetivo | Estado |
|---|---|
| Replicar las tablas STG con columnas de auditoría | ✅ Completado |
| Documentar el origen y estado de cada registro | ✅ Completado |
| Aplicar DEFAULT NOW() en load_date | ✅ Completado |
| Cargar datos entre capas usando INSERT SELECT | ✅ Completado |
| Documentar el modelo como Diccionario de Datos | ✅ Completado |
| Sentar las bases para la capa Silver | ✅ Completado |

---

## 🧱 Lo que se construyó

### Tablas creadas
| Tabla | Campos STG | Campos Auditoría | Total campos |
|---|---|---|---|
| `bronze.categorias` | 5 | 3 | 8 |
| `bronze.proveedores` | 8 | 3 | 11 |
| `bronze.productos` | 9 | 3 | 12 |
| `bronze.empleados` | 7 | 3 | 10 |
| `bronze.clientes` | 9 | 3 | 12 |
| `bronze.ordenes` | 7 | 3 | 10 |
| `bronze.orden_detalle` | 7 | 3 | 10 |

### Scripts creados
| Carpeta | Archivos | Descripción |
|---|---|---|
| `create_tables/` | 7 scripts | CREATE TABLE IF NOT EXISTS |
| `insert_data/` | 7 scripts | INSERT SELECT STG → Bronze |

---

## 📚 Lo que aprendí en este proyecto

### Nuevos conceptos
| Concepto | Descripción |
|---|---|
| Columnas de auditoría | `source_file`, `load_date`, `record_status` |
| `DEFAULT NOW()` | Valor automático para fecha de carga |
| `INSERT SELECT` | Copiar datos entre tablas y capas |
| Trazabilidad del dato | Registrar origen y estado de cada registro |
| Valores permitidos | Definir y documentar valores estándar por campo |

### Decisiones técnicas importantes
- Las columnas de auditoría son obligatorias (`NOT NULL`) en Bronze
- `load_date` usa `DEFAULT NOW()` — no se incluye en el INSERT
- `source_file` identifica el origen: `'manual'` o `'stg_nombre_tabla'`
- `record_status` controla el estado: `'active'`, `'inactive'`, `'pending'`, `'error'`
- Bronze no tiene FK constraints — eso corresponde a Silver

---

## 🔍 Diferencias entre STG y Bronze

| Aspecto | STG | Bronze |
|---|---|---|
| Propósito | Aterrizaje crudo | Copia auditada |
| Columnas de auditoría | ❌ No | ✅ Sí |
| DEFAULT NOW() | ❌ No | ✅ Sí |
| FK constraints | ❌ No | ❌ No |
| Carga de datos | INSERT INTO manual | INSERT SELECT desde STG |

---

## 🔜 Próximos pasos — Proyecto 4

El siguiente proyecto será **PostgreSQL_Silver_Layer** donde aprenderás:

```
✅ Constraints formales — CHECK, UNIQUE, NOT NULL avanzado
✅ FK con REFERENCES — relaciones formales entre tablas
✅ UUID como PRIMARY KEY
✅ Validaciones de negocio
✅ Datos limpios y listos para análisis
```

---

## 🗺️ Posición en la serie de proyectos

| # | Proyecto | Estado |
|---|---|---|
| 1 | PostgreSQL_Database_Infrastructure | ✅ Completado |
| 2 | PostgreSQL_Table_Design | ✅ Completado |
| 3 | PostgreSQL_Bronze_Layer | ✅ Completado |
| 4 | PostgreSQL_Silver_Layer | 🔜 Próximo |
| 5 | PostgreSQL_Data_Modeling | 🔜 Pendiente |

---

## 👤 Autor

### Teófilo Correa Rojas

**Data Analytics | Data Engineering en formación**

🔗 [LinkedIn](https://www.linkedin.com/in/teófilo-correa-rojas/)