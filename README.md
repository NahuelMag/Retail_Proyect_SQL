# Proyecto Retail - Base de Datos SQL

## 1. Descripción del proyecto

Este proyecto consiste en la creación de la estructura inicial de una base de datos para un sistema retail utilizando PostgreSQL.

El objetivo es diseñar las tablas principales para gestionar clientes, productos y ventas, aplicar restricciones de integridad y realizar una carga inicial de datos de manera controlada.

El proyecto utiliza sentencias SQL de definición de datos (DDL) y manipulación de datos (DML).

## 2. Tecnologías utilizadas

- **PostgreSQL:** sistema de gestión de bases de datos relacionales.
- **SQL:** lenguaje utilizado para crear tablas, establecer restricciones y manipular datos.
- **pgAdmin 4:** herramienta gráfica para administrar PostgreSQL y ejecutar consultas SQL.
- **GitHub:** plataforma utilizada para alojar y compartir el código del proyecto.

## 3. Estructura del repositorio

El repositorio contiene los siguientes archivos:

- `retail.sql`: script SQL con la creación de las tablas, las restricciones, la carga inicial de datos y las operaciones de mantenimiento.
- `README.md`: documentación del proyecto e instrucciones para su ejecución.

## 4. Modelo de datos

La base de datos está compuesta por tres tablas principales: `clientes`, `producto` y `ventas`.

### Tabla `clientes`

Almacena la información de los clientes.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| `clientes_id` | SERIAL | Identificador único y clave primaria. |
| `email` | VARCHAR(40) | Correo electrónico obligatorio y único. |
| `edad` | INT | Edad del cliente. |

Restricciones:
- `PRIMARY KEY`: identifica de forma única a cada cliente.
- `UNIQUE`: impide que se repitan los correos electrónicos.
- `NOT NULL`: exige que el email y la edad tengan un valor.
- `CHECK (edad > 0)`: garantiza que la edad sea mayor que cero.

### Tabla `producto`

Almacena los productos disponibles.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| `producto_id` | SERIAL | Identificador único y clave primaria. |
| `stock` | INT | Cantidad disponible del producto. |
| `precio_producto` | DECIMAL(8,2) | Precio del producto con dos decimales. |

Restricciones:
- `PRIMARY KEY`: identifica de forma única a cada producto.
- `NOT NULL`: exige que el stock y el precio tengan un valor.
- `CHECK (stock >= 0)`: impide que el stock sea negativo.
- `CHECK (precio_producto > 0)`: impide registrar precios iguales o inferiores a cero.

### Tabla `ventas`

Registra las ventas realizadas y establece las relaciones entre clientes y productos.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| `ventas_id` | SERIAL | Identificador único y clave primaria. |
| `clientes_id` | INT | Identificador del cliente asociado a la venta. |
| `producto_id` | INT | Identificador del producto vendido. |
| `cantidad` | INT | Cantidad de unidades vendidas. |

Restricciones:
- `PRIMARY KEY`: identifica cada venta.
- `FOREIGN KEY`: relaciona cada venta con un cliente existente.
- `FOREIGN KEY`: relaciona cada venta con un producto existente.
- `CHECK (cantidad > 0)`: garantiza que la cantidad vendida sea mayor que cero.

Las claves foráneas mantienen la integridad referencial entre las tablas.

## 5. Cómo crear la base de datos y ejecutar el proyecto

La creación de la base de datos y la ejecución del script se realizan por separado.

### Paso 1. Instalar PostgreSQL y pgAdmin

Instalar PostgreSQL, que incluye el sistema gestor de bases de datos, y utilizar pgAdmin 4 para administrar la instancia y ejecutar las consultas.

### Paso 2. Crear la base de datos

1. Abrir pgAdmin 4 y conectarse al servidor PostgreSQL.
2. En el panel izquierdo, hacer clic derecho sobre **Databases**.
3. Seleccionar **Create → Database**.
4. Ingresar el nombre `proyecto_retail`.
5. Guardar los cambios.

La base de datos se crea desde pgAdmin y no forma parte del archivo `retail.sql`.

### Paso 3. Abrir el editor SQL

1. Seleccionar la base de datos `proyecto_retail`.
2. Abrir **Tools → Query Tool**, o utilizar la opción equivalente disponible en la versión instalada.
3. Abrir el archivo `retail.sql` desde el editor SQL.

### Paso 4. Ejecutar el script

Ejecutar el contenido completo del archivo `retail.sql`.

El script crea las tablas, establece las restricciones de integridad, inserta los registros iniciales y realiza las operaciones de actualización y eliminación previstas.

**Importante:** el script comienza con sentencias `DROP TABLE IF EXISTS`, por lo que elimina las tablas existentes con esos nombres antes de volver a crearlas. Esto puede provocar la pérdida de datos anteriores. Se recomienda ejecutarlo en una base de datos de prueba.

### Paso 5. Verificar los resultados

Al finalizar la ejecución, consultar las tablas mediante las siguientes instrucciones:

```sql
SELECT * FROM clientes;
SELECT * FROM producto;
SELECT * FROM ventas;
```

Estas consultas permiten comprobar los registros existentes en cada tabla.

## 6. Carga inicial de datos y transacciones

El script inserta cinco registros iniciales en cada tabla.

Las inserciones se agrupan dentro de una transacción explícita mediante `BEGIN` y `COMMIT`.

- `BEGIN`: inicia la transacción.
- `INSERT INTO`: agrega registros a las tablas.
- `COMMIT`: confirma los cambios realizados en la transacción.

Este mecanismo permite confirmar conjuntamente las inserciones cuando todas las operaciones se ejecutan correctamente.

Los identificadores se generan automáticamente mediante el tipo `SERIAL`.

## 7. Actualización masiva de precios

El script utiliza una sentencia `UPDATE` para aumentar un 10 % el precio de los productos identificados con los IDs 1, 2 y 3.

Antes de realizar la actualización, se ejecuta una consulta `SELECT` para revisar los productos afectados.

La cláusula `WHERE` limita la modificación a los registros seleccionados y evita actualizar todos los productos de la tabla.

## 8. Eliminación de un registro de prueba

Para comprobar el funcionamiento de `DELETE`, el script inserta un cliente de prueba con el correo `prueba@gmail.com`.

A continuación, realiza una consulta `SELECT` para verificar su existencia y lo elimina mediante una sentencia `DELETE` con una condición `WHERE` basada en el correo electrónico.

De esta manera, se elimina únicamente el registro de prueba y se conservan los demás clientes.

## 9. Restricciones de integridad implementadas

El proyecto utiliza diferentes restricciones para proteger la consistencia de los datos:

- **PRIMARY KEY:** identifica de manera única los registros.
- **FOREIGN KEY:** garantiza que las relaciones entre ventas, clientes y productos sean válidas.
- **UNIQUE:** evita correos electrónicos duplicados.
- **NOT NULL:** impide valores nulos en campos obligatorios.
- **CHECK:** valida condiciones para edad, precio, stock y cantidad vendida.

## 10. Objetivos cumplidos

- Creación de las tablas principales del sistema retail.
- Definición de claves primarias y foráneas.
- Implementación de restricciones de integridad.
- Uso de tipos de datos adecuados.
- Inserción de datos iniciales mediante una transacción explícita.
- Actualización selectiva de precios mediante `UPDATE`.
- Eliminación controlada de un registro de prueba mediante `DELETE`.
- Verificación de los registros mediante consultas `SELECT`.
- Documentación del procedimiento de instalación y ejecución.

## 11. Autor

Proyecto desarrollado como parte de una práctica de SQL y bases de datos relacionales.
