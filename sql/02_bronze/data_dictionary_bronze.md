# Data Steward — Bronze Layer

## Propósito de la capa
Copia fiel de la capa Bronze con columnas de auditoría agregadas.
Se registra de dónde vino el dato, cuándo llegó y su estado.

## Reglas generales de la capa
- Solo PRIMARY KEY
- Sin validaciones de negocio
- Sin UNIQUE ni CHECK
- Columnas de auditoría obligatorias en todas las tablas
- DEFAULT NOW() en load_date

---

## Tabla: bronze.categorias

### Descripción
Almacena la información básica de las categorias de la empresa.
Cada registro representa a una categoria de los productos.

### Campos

| Campo          | ¿Qué guarda?                        | Obligatorio | Único | Tipo elegido  | Razón del tipo                                           |
|----------------|-------------------------------------|-------------|-------|---------------|----------------------------------------------------------|
| id             | Identificador único de la categoría    | Sí          | Sí    | SERIAL        | Se genera automático, no necesitamos asignarlo           |
| nombre         | Nombre de la categoría ej: Ropa, Electrónica        | Sí          | No    | VARCHAR(100)  | Texto corto, sabemos que no superará 100 caracteres      |
| descripcion          | Detalle de qué incluye la categoría       | No          | No    | VARCHAR(2000) | Texto corto con longitud máxima conocida 2000 caracteres |
| activo        | Si la categoría está disponible o no             | Sí          | No    | BOOLEAN       | Solo puede ser verdadero o falso        |
| created_at     | Cuándo se creó el registro en la BD | Sí          | No    | TIMESTAMP     | Necesitamos fecha y hora exacta de carga                 |
| source_file   | Nombre del archivo o fuente de origen  | Sí | No | VARCHAR(100) | Identifica de dónde vino el dato |
| load_date     | Fecha y hora exacta de carga           | Sí | No | TIMESTAMP    | DEFAULT NOW() — se genera automático |
| record_status | Estado del registro active o inactive  | Sí | No | VARCHAR(20)  | Controla si el registro está vigente |

## Tabla: bronze.proveedores

### Descripción
Almacena la información básica de los proveedores de la empresa.
Cada registro representa un proveedor contratado.

### Campos

| Campo          | ¿Qué guarda?                        | Obligatorio | Único | Tipo elegido | Razón del tipo                                                     |
|----------------|-------------------------------------|-------------|-------|--------------|--------------------------------------------------------------------|
| id             | Identificador único del proveedor   | Sí          | Sí    | SERIAL       | Se genera automático, no necesitamos asignarlo                     |
| nombre         | Nombre de la empresa proveedora        | Sí          | No    | VARCHAR(100) | Texto corto, sabemos que no superará 100 caracteres                |
| contacto          | Nombre de la persona de contacto       | No          | No    | VARCHAR(150) | Texto corto, sabemos que no superará 150 caracteres                |
| email        | Correo electrónico del proveedor             | No          | No    | VARCHAR(150) | Texto corto con longitud máxima conocida                           |
| telefono         | Número de teléfono     | No          | No    | VARCHAR(15)  | Solo puede aceptar 15 digitos que no incluye Guiones ni parentesis |
| pais  | País de origen del proveedor     | No          | No    | VARCHAR(100) | Texto corto con longitud máxima conocida 100 caracteres            |
| activo  | Si el proveedor está activo     | Sí          | No    | BOOLEAN      | Solo puede ser verdadero o falso            |
| created_at     | Cuándo se creó el registro | Sí          | No    | TIMESTAMP    | Necesitamos fecha y hora exacta de carga                           |
| source_file   | Nombre del archivo o fuente de origen  | Sí | No | VARCHAR(100) | Identifica de dónde vino el dato |
| load_date     | Fecha y hora exacta de carga           | Sí | No | TIMESTAMP    | DEFAULT NOW() — se genera automático |
| record_status | Estado del registro active o inactive  | Sí | No | VARCHAR(20)  | Controla si el registro está vigente |

## Tabla: bronze.productos

### Descripción
Almacena la información básica de los productos de la empresa.
Cada registro representa un producto adquirido.

### Campos

| Campo          | ¿Qué guarda?                        | Obligatorio | Único | Tipo elegido  | Razón del tipo                                                  |
|----------------|-------------------------------------|-------------|-------|---------------|-----------------------------------------------------------------|
| id             | Identificador único del producto   | Sí          | Sí    | SERIAL        | Se genera automático, no necesitamos asignarlo                  |
| nombre         | Nombre del producto        | Sí          | No    | VARCHAR(100)  | Texto corto, sabemos que no superará 100 caracteres             |
| descripcion          | Descripción detallada del producto       | No          | No    | TEXT          | Texto corto, sabemos que no superará 250 caracteres             |
| precio        | Precio de venta             | Sí          | No    | NUMERIC(10,2) | Necesita decimales exactos, es un valor monetario               |
| stock         | Cantidad disponible en inventario     | Sí          | No    | INT           | Aceptar cantidad de mas de 2 millones de numeros para no limitar |
| categoria_id  | FK — a qué categoría pertenece     | No          | No    | INT           | Se relaciona con la tabla de categorias                         |
| proveedor_id  | FK — quién lo suministra     | No          | No    | INT           | Se relaciona con la tabla de proveedor                          |
| activo     | Si el producto está disponible | Sí          | No    | BOOLEAN       | Solo puede ser verdadero o falso                                |
| created_at     | Cuándo se creó el registro | Sí          | No    | TIMESTAMP     | Necesitamos fecha y hora exacta de carga          |
| source_file   | Nombre del archivo o fuente de origen  | Sí | No | VARCHAR(100) | Identifica de dónde vino el dato |
| load_date     | Fecha y hora exacta de carga           | Sí | No | TIMESTAMP    | DEFAULT NOW() — se genera automático |
| record_status | Estado del registro active o inactive  | Sí | No | VARCHAR(20)  | Controla si el registro está vigente |

## Tabla: bronze.empleados

### Descripción
Almacena la información básica de los empleados de la empresa.
Cada registro representa a un empleado.

### Campos

| Campo          | ¿Qué guarda?                        | Obligatorio | Único | Tipo elegido | Razón del tipo                                          |
|----------------|-------------------------------------|-------------|-------|--------------|---------------------------------------------------------|
| id             | Identificador único del empleado    | Sí          | Sí    | SERIAL       | Se genera automático, no necesitamos asignarlo          |
| nombre         | Nombre completo        | Sí          | No    | VARCHAR(250) | Texto corto, sabemos que no superará 250 caracteres     |
| email          | Correo corporativo       | Sí          | No    | VARCHAR(100) | Texto corto con longitud máxima conocida 100 caracteres |
| cargo        | Puesto que ocupa ej: Vendedor, Gerente             | Sí          | No    | VARCHAR(250) | Texto corto con longitud máxima conocida 250 caracteres |
| fecha_ingreso        | Cuándo entró a la empresa             | Sí          | No    | DATE         | Necesitamo la fecha de ingreso del empleado             |
| activo        | Si está activo en la empresa             | Sí          | No    | BOOLEAN      | Solo puede ser verdadero o falso |
| created_at     | Cuándo se creó el registro en la BD | Sí          | No    | TIMESTAMP    | Necesitamos fecha y hora exacta de carga                |
| source_file   | Nombre del archivo o fuente de origen  | Sí | No | VARCHAR(100) | Identifica de dónde vino el dato |
| load_date     | Fecha y hora exacta de carga           | Sí | No | TIMESTAMP    | DEFAULT NOW() — se genera automático |
| record_status | Estado del registro active o inactive  | Sí | No | VARCHAR(20)  | Controla si el registro está vigente |

## Tabla: bronze.clientes

### Descripción
Almacena la información básica de los clientes de la empresa.
Cada registro representa a un ciente.

### Campos

| Campo          | ¿Qué guarda?                        | Obligatorio | Único | Tipo elegido | Razón del tipo                                          |
|----------------|-------------------------------------|-------------|-------|--------------|---------------------------------------------------------|
| id             | Identificador único del cliente    | Sí          | Sí    | SERIAL       | Se genera automático, no necesitamos asignarlo          |
| nombre         | Nombre completo        | Sí          | No    | VARCHAR(250) | Texto corto, sabemos que no superará 250 caracteres     |
| email          | Correo del cliente       | Sí          | No    | VARCHAR(100) | Texto corto con longitud máxima conocida 100 caracteres |
| telefono        | Teléfono de contacto             | No          | No    | VARCHAR(30)  | Texto corto con longitud máxima conocida 30 caracteres  |
| ciudad        | Ciudad donde vive             | No          | No    | VARCHAR(250) | Texto corto con longitud máxima conocida 250 caracteres |
| pais        | País donde vive             | No          | No    | VARCHAR(250) | Texto corto con longitud máxima conocida 250 caracteres |
| fecha_registro        | Cuándo se registró como cliente             | Sí          | No    | DATE         | Necesitamos fecha que se registro el cliente            |
| activo        | Si el cliente está activo             | Sí          | No    | BOOLEAN      | Solo puede ser verdadero o falso |
| created_at     | Cuándo se creó el registro en la BD | Sí          | No    | TIMESTAMP    | Necesitamos fecha y hora exacta de carga                |
| source_file   | Nombre del archivo o fuente de origen  | Sí | No | VARCHAR(100) | Identifica de dónde vino el dato |
| load_date     | Fecha y hora exacta de carga           | Sí | No | TIMESTAMP    | DEFAULT NOW() — se genera automático |
| record_status | Estado del registro active o inactive  | Sí | No | VARCHAR(20)  | Controla si el registro está vigente |

## Tabla: bronze.ordenes

### Descripción
Almacena la información básica de las ordenes de la empresa.
Cada registro representa a una orden generada.

### Campos

| Campo          | ¿Qué guarda?                        | Obligatorio | Único | Tipo elegido  | Razón del tipo                                          |
|----------------|-------------------------------------|-------------|-------|---------------|---------------------------------------------------------|
| id             | Identificador único de la orden    | Sí          | Sí    | SERIAL        | Se genera automático, no necesitamos asignarlo          |
| cliente_id         | FK — quién hizo la compra        | No          | No    | INT           | Se relaciona con la tabla de compras                    |
| empleado_id          | FK — quién procesó la orden       | No          | No    | INT           | Se relaciona con la tabla de empleados                  |
| fecha_orden        | Cuándo se realizó la compra             | Sí          | No    | DATE          | Necesitamos fecha que se registro de la orden           |
| estado        | Estado ej: pendiente, enviado, entregado             | Si          | No    | VARCHAR(50)   | Estado de la orden                                      |
| total        | Monto total de la orden             | Sí          | No    | NUMERIC(10,2) | Necesita decimales exactos, es un valor monetario |
| created_at     | Cuándo se creó el registro en la BD | Sí          | No    | TIMESTAMP     | Necesitamos fecha y hora exacta de carga                |
| source_file   | Nombre del archivo o fuente de origen  | Sí | No | VARCHAR(100) | Identifica de dónde vino el dato |
| load_date     | Fecha y hora exacta de carga           | Sí | No | TIMESTAMP    | DEFAULT NOW() — se genera automático |
| record_status | Estado del registro active o inactive  | Sí | No | VARCHAR(20)  | Controla si el registro está vigente |

## Tabla: bronze.orden_detalle

### Descripción
Almacena la información básica de los detalles de la orden de la empresa.
Cada registro representa a un detalle de la orden generada.

### Campos

| Campo          | ¿Qué guarda?                        | Obligatorio | Único | Tipo elegido  | Razón del tipo                                    |
|----------------|-------------------------------------|-------------|-------|---------------|---------------------------------------------------|
| id             | Identificador único del detalle    | Sí          | Sí    | SERIAL        | Se genera automático, no necesitamos asignarlo    |
| orden_id         | FK — a qué orden pertenece        | No          | No    | INT           | Se relaciona con la tabla de ordenes              |
| producto_id          | FK — qué producto se compró       | No          | No    | INT           | Se relaciona con la tabla de productos            |
| cantidad        | Cuántas unidades se compraron             | Sí          | No    | INT           | Saber la cantidad de articulo compro el individuo |
| precio_unitario        | Precio del producto al momento de compra             | Si          | No    | NUMERIC(10,2) | Precio de los articulo unitario                   |
| subtotal        | cantidad x precio_unitario             | Sí          | No    | NUMERIC(10,2) | Cantidad de precio por unidad                     |
| created_at     | Cuándo se creó el registro en la BD | Sí          | No    | TIMESTAMP     | Necesitamos fecha y hora exacta de carga          |
| source_file   | Nombre del archivo o fuente de origen  | Sí | No | VARCHAR(100) | Identifica de dónde vino el dato |
| load_date     | Fecha y hora exacta de carga           | Sí | No | TIMESTAMP    | DEFAULT NOW() — se genera automático |
| record_status | Estado del registro active o inactive  | Sí | No | VARCHAR(20)  | Controla si el registro está vigente |