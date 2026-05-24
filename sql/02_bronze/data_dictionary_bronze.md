# Data Steward — Bronze Layer

## Propósito de la capa
Copia fiel de la capa STG con columnas de auditoría agregadas.
Se registra de dónde vino el dato, cuándo llegó y su estado.

## Reglas generales de la capa
- Solo PRIMARY KEY
- Sin validaciones de negocio
- Sin UNIQUE ni CHECK
- Columnas de auditoría obligatorias en todas las tablas
- DEFAULT NOW() en load_date

## Valores permitidos — Columnas de auditoría

| Campo | Valor | Descripción |
|---|---|---|
| `source_file` | `'manual'` | Datos insertados manualmente |
| `source_file` | `'stg_categorias'` | Datos copiados desde stg.categorias |
| `source_file` | `'stg_proveedores'` | Datos copiados desde stg.proveedores |
| `source_file` | `'stg_productos'` | Datos copiados desde stg.productos |
| `source_file` | `'stg_empleados'` | Datos copiados desde stg.empleados |
| `source_file` | `'stg_clientes'` | Datos copiados desde stg.clientes |
| `source_file` | `'stg_ordenes'` | Datos copiados desde stg.ordenes |
| `source_file` | `'stg_orden_detalle'` | Datos copiados desde stg.orden_detalle |
| `record_status` | `'active'` | Registro vigente |
| `record_status` | `'inactive'` | Registro dado de baja |
| `record_status` | `'pending'` | Registro pendiente de revisión |
| `record_status` | `'error'` | Registro con error de carga |

---

## Tabla: bronze.categorias

### Descripción
Almacena la información básica de las categorias de la empresa.
Cada registro representa a una categoria de los productos.

### Campos

| Campo | ¿Qué guarda? | Obligatorio | Único | Tipo elegido | Razón del tipo |
|---|---|---|---|---|---|
| id | Identificador único de la categoría | Sí | Sí | SERIAL | Se genera automático, no necesitamos asignarlo |
| nombre | Nombre de la categoría ej: Ropa, Electrónica | Sí | No | VARCHAR(100) | Texto corto, sabemos que no superará 100 caracteres |
| descripcion | Detalle de qué incluye la categoría | No | No | VARCHAR(2000) | Texto corto con longitud máxima conocida 2000 caracteres |
| activo | Si la categoría está disponible o no | Sí | No | BOOLEAN | Solo puede ser verdadero o falso |
| created_at | Cuándo se creó el registro en la BD | Sí | No | TIMESTAMP | Necesitamos fecha y hora exacta de carga |
| source_file | Nombre del archivo o fuente de origen | Sí | No | VARCHAR(100) | Valores: 'manual', 'stg_categorias' |
| load_date | Fecha y hora exacta de carga | Sí | No | TIMESTAMP | DEFAULT NOW() — se genera automático |
| record_status | Estado del registro | Sí | No | VARCHAR(20) | Valores: 'active', 'inactive', 'pending', 'error' |

---

## Tabla: bronze.proveedores

### Descripción
Almacena la información básica de los proveedores de la empresa.
Cada registro representa un proveedor contratado.

### Campos

| Campo | ¿Qué guarda? | Obligatorio | Único | Tipo elegido | Razón del tipo |
|---|---|---|---|---|---|
| id | Identificador único del proveedor | Sí | Sí | SERIAL | Se genera automático, no necesitamos asignarlo |
| nombre | Nombre de la empresa proveedora | Sí | No | VARCHAR(100) | Texto corto, sabemos que no superará 100 caracteres |
| contacto | Nombre de la persona de contacto | No | No | VARCHAR(150) | Texto corto, sabemos que no superará 150 caracteres |
| email | Correo electrónico del proveedor | No | No | VARCHAR(150) | Texto corto con longitud máxima conocida |
| telefono | Número de teléfono | No | No | VARCHAR(15) | Solo puede aceptar 15 dígitos |
| pais | País de origen del proveedor | No | No | VARCHAR(100) | Texto corto con longitud máxima conocida 100 caracteres |
| activo | Si el proveedor está activo | Sí | No | BOOLEAN | Solo puede ser verdadero o falso |
| created_at | Cuándo se creó el registro | Sí | No | TIMESTAMP | Necesitamos fecha y hora exacta de carga |
| source_file | Nombre del archivo o fuente de origen | Sí | No | VARCHAR(100) | Valores: 'manual', 'stg_proveedores' |
| load_date | Fecha y hora exacta de carga | Sí | No | TIMESTAMP | DEFAULT NOW() — se genera automático |
| record_status | Estado del registro | Sí | No | VARCHAR(20) | Valores: 'active', 'inactive', 'pending', 'error' |

---

## Tabla: bronze.productos

### Descripción
Almacena la información básica de los productos de la empresa.
Cada registro representa un producto adquirido.

### Campos

| Campo | ¿Qué guarda? | Obligatorio | Único | Tipo elegido | Razón del tipo |
|---|---|---|---|---|---|
| id | Identificador único del producto | Sí | Sí | SERIAL | Se genera automático, no necesitamos asignarlo |
| nombre | Nombre del producto | Sí | No | VARCHAR(100) | Texto corto, sabemos que no superará 100 caracteres |
| descripcion | Descripción detallada del producto | No | No | TEXT | Sin límite de longitud |
| precio | Precio de venta | Sí | No | NUMERIC(10,2) | Necesita decimales exactos, es un valor monetario |
| stock | Cantidad disponible en inventario | Sí | No | INTEGER | Acepta hasta 2 millones de registros |
| categoria_id | ID de referencia a la categoría | No | No | INTEGER | Campo de referencia, sin FK constraint en Bronze |
| proveedor_id | ID de referencia al proveedor | No | No | INTEGER | Campo de referencia, sin FK constraint en Bronze |
| activo | Si el producto está disponible | Sí | No | BOOLEAN | Solo puede ser verdadero o falso |
| created_at | Cuándo se creó el registro | Sí | No | TIMESTAMP | Necesitamos fecha y hora exacta de carga |
| source_file | Nombre del archivo o fuente de origen | Sí | No | VARCHAR(100) | Valores: 'manual', 'stg_productos' |
| load_date | Fecha y hora exacta de carga | Sí | No | TIMESTAMP | DEFAULT NOW() — se genera automático |
| record_status | Estado del registro | Sí | No | VARCHAR(20) | Valores: 'active', 'inactive', 'pending', 'error' |

---

## Tabla: bronze.empleados

### Descripción
Almacena la información básica de los empleados de la empresa.
Cada registro representa a un empleado.

### Campos

| Campo | ¿Qué guarda? | Obligatorio | Único | Tipo elegido | Razón del tipo |
|---|---|---|---|---|---|
| id | Identificador único del empleado | Sí | Sí | SERIAL | Se genera automático, no necesitamos asignarlo |
| nombre | Nombre completo | Sí | No | VARCHAR(250) | Texto corto, sabemos que no superará 250 caracteres |
| email | Correo corporativo | Sí | No | VARCHAR(100) | Texto corto con longitud máxima conocida 100 caracteres |
| cargo | Puesto que ocupa ej: Vendedor, Gerente | Sí | No | VARCHAR(250) | Texto corto con longitud máxima conocida 250 caracteres |
| fecha_ingreso | Cuándo entró a la empresa | Sí | No | DATE | Necesitamos la fecha de ingreso del empleado |
| activo | Si está activo en la empresa | Sí | No | BOOLEAN | Solo puede ser verdadero o falso |
| created_at | Cuándo se creó el registro en la BD | Sí | No | TIMESTAMP | Necesitamos fecha y hora exacta de carga |
| source_file | Nombre del archivo o fuente de origen | Sí | No | VARCHAR(100) | Valores: 'manual', 'stg_empleados' |
| load_date | Fecha y hora exacta de carga | Sí | No | TIMESTAMP | DEFAULT NOW() — se genera automático |
| record_status | Estado del registro | Sí | No | VARCHAR(20) | Valores: 'active', 'inactive', 'pending', 'error' |

---

## Tabla: bronze.clientes

### Descripción
Almacena la información básica de los clientes de la empresa.
Cada registro representa a un cliente.

### Campos

| Campo | ¿Qué guarda? | Obligatorio | Único | Tipo elegido | Razón del tipo |
|---|---|---|---|---|---|
| id | Identificador único del cliente | Sí | Sí | SERIAL | Se genera automático, no necesitamos asignarlo |
| nombre | Nombre completo | Sí | No | VARCHAR(250) | Texto corto, sabemos que no superará 250 caracteres |
| email | Correo del cliente | Sí | No | VARCHAR(100) | Texto corto con longitud máxima conocida 100 caracteres |
| telefono | Teléfono de contacto | No | No | VARCHAR(30) | Texto corto con longitud máxima conocida 30 caracteres |
| ciudad | Ciudad donde vive | No | No | VARCHAR(250) | Texto corto con longitud máxima conocida 250 caracteres |
| pais | País donde vive | No | No | VARCHAR(250) | Texto corto con longitud máxima conocida 250 caracteres |
| fecha_registro | Cuándo se registró como cliente | Sí | No | DATE | Necesitamos fecha que se registró el cliente |
| activo | Si el cliente está activo | Sí | No | BOOLEAN | Solo puede ser verdadero o falso |
| created_at | Cuándo se creó el registro en la BD | Sí | No | TIMESTAMP | Necesitamos fecha y hora exacta de carga |
| source_file | Nombre del archivo o fuente de origen | Sí | No | VARCHAR(100) | Valores: 'manual', 'stg_clientes' |
| load_date | Fecha y hora exacta de carga | Sí | No | TIMESTAMP | DEFAULT NOW() — se genera automático |
| record_status | Estado del registro | Sí | No | VARCHAR(20) | Valores: 'active', 'inactive', 'pending', 'error' |

---

## Tabla: bronze.ordenes

### Descripción
Almacena la información básica de las ordenes de la empresa.
Cada registro representa a una orden generada.

### Campos

| Campo | ¿Qué guarda? | Obligatorio | Único | Tipo elegido | Razón del tipo |
|---|---|---|---|---|---|
| id | Identificador único de la orden | Sí | Sí | SERIAL | Se genera automático, no necesitamos asignarlo |
| cliente_id | ID de referencia al cliente | No | No | INTEGER | Campo de referencia, sin FK constraint en Bronze |
| empleado_id | ID de referencia al empleado | No | No | INTEGER | Campo de referencia, sin FK constraint en Bronze |
| fecha_orden | Cuándo se realizó la compra | Sí | No | DATE | Necesitamos fecha que se registró la orden |
| estado | Estado ej: pendiente, enviado, entregado | Sí | No | VARCHAR(50) | Estado de la orden |
| total | Monto total de la orden | Sí | No | NUMERIC(10,2) | Necesita decimales exactos, es un valor monetario |
| created_at | Cuándo se creó el registro en la BD | Sí | No | TIMESTAMP | Necesitamos fecha y hora exacta de carga |
| source_file | Nombre del archivo o fuente de origen | Sí | No | VARCHAR(100) | Valores: 'manual', 'stg_ordenes' |
| load_date | Fecha y hora exacta de carga | Sí | No | TIMESTAMP | DEFAULT NOW() — se genera automático |
| record_status | Estado del registro | Sí | No | VARCHAR(20) | Valores: 'active', 'inactive', 'pending', 'error' |

---

## Tabla: bronze.orden_detalle

### Descripción
Almacena la información básica de los detalles de la orden de la empresa.
Cada registro representa a un detalle de la orden generada.

### Campos

| Campo | ¿Qué guarda? | Obligatorio | Único | Tipo elegido | Razón del tipo |
|---|---|---|---|---|---|
| id | Identificador único del detalle | Sí | Sí | SERIAL | Se genera automático, no necesitamos asignarlo |
| orden_id | ID de referencia a la orden | No | No | INTEGER | Campo de referencia, sin FK constraint en Bronze |
| producto_id | ID de referencia al producto | No | No | INTEGER | Campo de referencia, sin FK constraint en Bronze |
| cantidad | Cuántas unidades se compraron | Sí | No | INTEGER | Saber la cantidad de artículos comprados |
| precio_unitario | Precio del producto al momento de compra | Sí | No | NUMERIC(10,2) | Precio de los artículos unitario |
| subtotal | cantidad x precio_unitario | Sí | No | NUMERIC(10,2) | Cantidad de precio por unidad |
| created_at | Cuándo se creó el registro en la BD | Sí | No | TIMESTAMP | Necesitamos fecha y hora exacta de carga |
| source_file | Nombre del archivo o fuente de origen | Sí | No | VARCHAR(100) | Valores: 'manual', 'stg_orden_detalle' |
| load_date | Fecha y hora exacta de carga | Sí | No | TIMESTAMP | DEFAULT NOW() — se genera automático |
| record_status | Estado del registro | Sí | No | VARCHAR(20) | Valores: 'active', 'inactive', 'pending', 'error' |
