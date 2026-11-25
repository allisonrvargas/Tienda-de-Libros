-- Consultas de ejemplo sobre el esquema normalizado

-- 1. Libros con su categoría
SELECT l.titulo, l.autor, c.categoria, l.precio
FROM libro l
JOIN categoria c ON c.id_categoria = l.id_categoria
ORDER BY c.categoria;

-- 2. Pedidos con el nombre del cliente y el título del libro
SELECT cl.cliente, l.titulo, p.metodo_pago, p.monto
FROM pedido p
JOIN cliente cl ON cl.correo_cliente = p.correo_cliente
JOIN libro l ON l.isbn = p.isbn
ORDER BY cl.cliente, l.titulo;

-- 3. Total gastado por cada cliente
SELECT cl.cliente, COUNT(*) AS libros_comprados, SUM(p.monto) AS total_gastado
FROM pedido p
JOIN cliente cl ON cl.correo_cliente = p.correo_cliente
GROUP BY cl.cliente
ORDER BY total_gastado DESC;

-- 4. Ventas por método de pago
SELECT metodo_pago, COUNT(*) AS pedidos, SUM(monto) AS total
FROM pedido
GROUP BY metodo_pago
ORDER BY total DESC;

-- 5. Libros que nadie ha comprado todavía
SELECT l.titulo
FROM libro l
LEFT JOIN pedido p ON p.isbn = l.isbn
WHERE p.isbn IS NULL;