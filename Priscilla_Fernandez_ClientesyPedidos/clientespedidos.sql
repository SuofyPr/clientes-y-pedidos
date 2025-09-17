-- base de datos

DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda;
USE tienda;

-- tablas
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    direccion VARCHAR(50),
    telefono VARCHAR(20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    fecha DATE NOT NULL,
    total INT NOT NULL,
    CONSTRAINT fk_pedidos_clientes
        FOREIGN KEY (cliente_id) REFERENCES clientes(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- clientes
INSERT INTO clientes (nombre, direccion, telefono) VALUES
('Juan Pérez', 'Av. Principal 123', '987654321'),
('María López', 'Calle Secundaria 456', '912345678'),
('Pedro Gómez', 'Pasaje Norte 789', '934567890'),
('Ana Torres', 'Av. Sur 321', '956789012'),
('Luis Fernández', 'Camino Real 654', '978901234');

-- pedidos

INSERT INTO pedidos (cliente_id, fecha, total) VALUES
(1, '2025-09-01', 25000),
(1, '2025-09-03', 18000),
(2, '2025-09-02', 30000),
(2, '2025-09-04', 12000),
(3, '2025-09-05', 50000),
(3, '2025-09-06', 22000),
(4, '2025-09-07', 15000),
(4, '2025-09-08', 45000),
(5, '2025-09-09', 27000),
(5, '2025-09-10', 32000);

-- proyecion

SELECT c.id AS cliente_id, c.nombre, p.id AS pedido_id, p.fecha, p.total
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
ORDER BY c.id, p.fecha;


SELECT p.id AS pedido_id, p.fecha, p.total
FROM pedidos p
WHERE p.cliente_id = 2
ORDER BY p.fecha;

-- total pedidos

SELECT c.id AS cliente_id, c.nombre, COALESCE(SUM(p.total),0) AS total_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre;

-- elimina cliente
DELETE FROM clientes WHERE id = 3;

-- 3 clientes con mas pedidos
SELECT c.id AS cliente_id, c.nombre, COUNT(p.id) AS cantidad_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre
ORDER BY cantidad_pedidos DESC
LIMIT 3;