# Proyecto Retail - Base de Datos SQL

## 1. Descripción del proyecto

Este proyecto consiste en la creación de una base de datos inicial para un sistema de ventas retail utilizando PostgreSQL.

El objetivo es definir las tablas principales del sistema, establecer restricciones de integridad y realizar una carga inicial de datos mediante sentencias SQL.

El proyecto incluye operaciones de creación de tablas (DDL), manipulación de datos (DML), transacciones y consultas de verificación.

## 2. Tecnologías utilizadas

- **PostgreSQL:** sistema de gestión de bases de datos relacionales.
- **SQL:** lenguaje utilizado para crear las tablas, establecer restricciones y manipular los datos.
- **GitHub:** plataforma utilizada para alojar y compartir el proyecto.

## 3. Estructura de la base de datos

La base de datos está compuesta por tres tablas principales: `clientes`, `producto` y `ventas`.

### Tabla `clientes`

Almacena la información de los clientes.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| `clientes_id` | SERIAL | Identificador único y clave primaria. |
| `email` | VARCHAR(40) | Correo electrónico único y obligatorio. |
| `edad` | INT | Edad del cliente, debe ser mayor que cero. |

**Restricciones aplicadas:**

- `PRIMARY KEY`: identifica de forma única a cada cliente.
- `UNIQUE`: evita que se repitan los correos electrónicos.
- `NOT NULL`: exige que el email y la edad tengan un valor.
- `CHECK (edad > 0)`: impide registrar edades iguales o inferiores a cero.

### Tabla `producto`

Almacena la información de los productos disponibles.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| `producto_id` | SERIAL | Identificador único y clave primaria. |
| `stock` | INT | Cantidad disponible del producto. |
| `precio_producto` | DECIMAL(8,2) | Precio del producto con dos decimales. |

**Restricciones aplicadas:**

- `PRIMARY KEY`: identifica de forma única a cada producto.
- `NOT NULL`: exige que el stock y el precio tengan un valor.
- `CHECK (stock >= 0)`: permite stock cero, pero no valores negativos.
- `CHECK (precio_producto > 0)`: exige que el precio sea mayor que cero.

### Tabla `ventas`

Registra las ventas realizadas y relaciona clientes con productos.

| Campo | Tipo de dato | Descripción |
|---|---|---|
| `ventas_id` | SERIAL | Identificador único y clave primaria. |
| `clientes_id` | INT | Identificador del cliente asociado a la venta. |
| `producto_id` | INT | Identificador del producto vendido. |

**Restricciones aplicadas:**

- `PRIMARY KEY`: identifica cada venta.
- `FOREIGN KEY`: relaciona cada venta con un cliente existente.
- `FOREIGN KEY`: relaciona cada venta con un producto existente.
- `NOT NULL`: exige que ambas relaciones tengan un valor.

Las claves foráneas garantizan que las ventas no hagan referencia a clientes o productos inexistentes.

## 4. Orden de creación de las tablas

Las tablas se crean en el siguiente orden:

1. `clientes`
2. `producto`
3. `ventas`

Este orden permite crear primero las tablas que contienen los datos principales y luego establecer las relaciones mediante claves foráneas en la tabla `ventas`.

Al comienzo del script se utilizan sentencias `DROP TABLE IF EXISTS` para eliminar las tablas existentes antes de volver a crearlas.

**Importante:** esto elimina los datos anteriores de esas tablas. Se recomienda ejecutar el script en una base de datos de prueba.

## 5. Carga inicial de datos (DML)

El script incorpora cinco registros iniciales en cada tabla.

Las operaciones de inserción se agrupan dentro de una transacción explícita mediante `BEGIN` y `COMMIT`.

- `BEGIN`: inicia la transacción.
- `INSERT INTO`: agrega los registros a cada tabla.
- `COMMIT`: confirma los cambios realizados durante la transacción.

Este mecanismo permite agrupar las inserciones para que se confirmen conjuntamente si todas las operaciones se ejecutan correctamente.

Los identificadores se generan automáticamente mediante el tipo `SERIAL`.

## 6. Actualización masiva de precios

Se utiliza una sentencia `UPDATE` para aumentar un 10 % el precio de los productos cuyos identificadores son 1, 2 y 3.

Antes de realizar la modificación, se ejecuta un `SELECT` para consultar los registros afectados.

La cláusula `WHERE` limita la actualización a los productos seleccionados y evita modificar los precios de toda la tabla.

## 7. Eliminación de un registro de prueba

El script agrega un cliente de prueba con el correo `prueba@gmail.com`.

Antes de eliminarlo, se ejecuta una consulta `SELECT` para verificar que el registro exista.

Posteriormente, se utiliza `DELETE` con una cláusula `WHERE` basada en el email para eliminar únicamente ese cliente de prueba.

De esta manera, se evita borrar accidentalmente el resto de los registros.

## 8. Cómo ejecutar el proyecto

1. Instalar PostgreSQL y disponer de una base de datos de prueba.
2. Abrir pgAdmin o una herramienta compatible con PostgreSQL.
3. Seleccionar la base de datos donde se ejecutará el proyecto.
4. Abrir el archivo `retail.sql` en el editor de consultas.
5. Ejecutar el script completo.
6. Revisar los mensajes de ejecución para detectar posibles errores.
7. Consultar los registros con sentencias `SELECT` para verificar los resultados.

## 9. Objetivos cumplidos

- Creación de las tres tablas principales del sistema retail.
- Definición de claves primarias y foráneas.
- Implementación de restricciones de integridad mediante `CHECK`, `UNIQUE` y `NOT NULL`.
- Uso de tipos de datos apropiados para identificadores, texto, precios y cantidades.
- Inserción de datos iniciales mediante una transacción.
- Actualización selectiva de precios mediante `UPDATE`.
- Eliminación controlada de un registro de prueba mediante `DELETE`.
- Verificación de los datos antes de realizar modificaciones.

## 10. Autor

Proyecto desarrollado como parte de una práctica de SQL y bases de datos relacionales.
