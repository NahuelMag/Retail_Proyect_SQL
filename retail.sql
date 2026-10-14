
-- 1. Eliminar tablas en orden correcto

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS clientes;


-- 2. Crear clientes

CREATE TABLE clientes (
    clientes_id SERIAL PRIMARY KEY,
    email VARCHAR(40) NOT NULL UNIQUE,
    edad INT NOT NULL,
    CONSTRAINT chk_edad CHECK (edad > 0)
);


-- 3. Crear productos

CREATE TABLE producto (
    producto_id SERIAL PRIMARY KEY,
    stock INT NOT NULL,
    precio_producto DECIMAL(8,2) NOT NULL,
    CONSTRAINT chk_stock CHECK (stock >= 0),
    CONSTRAINT chk_precio_producto CHECK (precio_producto > 0)
);


-- 4. Crear ventas

CREATE TABLE ventas (
    ventas_id SERIAL PRIMARY KEY,
    clientes_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,

    CONSTRAINT fk_venta_cliente
        FOREIGN KEY (clientes_id)
        REFERENCES clientes(clientes_id),

    CONSTRAINT fk_venta_producto
        FOREIGN KEY (producto_id)
        REFERENCES producto(producto_id),

    CONSTRAINT chk_cantidad CHECK (cantidad > 0)
);


-- 5. Insertar datos

BEGIN;

INSERT INTO clientes (email, edad) VALUES
('juan@gmail.com', 25),
('maria@gmail.com', 32),
('carlos@gmail.com', 41),
('ana@gmail.com', 28),
('lucia@gmail.com', 35);

INSERT INTO producto (stock, precio_producto) VALUES
(10, 15000.00),
(25, 8500.00),
(8, 45000.00),
(0, 12000.00),
(15, 32000.00);

INSERT INTO ventas (clientes_id, producto_id, cantidad) VALUES
(1, 1, 2),
(2, 3, 1),
(3, 2, 3),
(4, 5, 1),
(5, 4, 2);

COMMIT;


-- 6. Actualizar precios

SELECT *
FROM producto
WHERE producto_id IN (1, 2, 3);

UPDATE producto
SET precio_producto = precio_producto * 1.10
WHERE producto_id IN (1, 2, 3);


-- 7. Insertar y eliminar cliente de prueba

INSERT INTO clientes (email, edad)
VALUES ('prueba@gmail.com', 20);

SELECT *
FROM clientes
WHERE email = 'prueba@gmail.com';

DELETE FROM clientes
WHERE email = 'prueba@gmail.com';


-- 8. Verificar resultados

SELECT * FROM clientes;
SELECT * FROM producto;
SELECT * FROM ventas;
