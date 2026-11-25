-- Verificaciones del diseño en tercera forma normal. Se ejecuta después de los tres scripts de sql/.
DO $$
BEGIN
    -- 1. Datos del ejercicio
    ASSERT (SELECT COUNT(*) FROM categoria) = 3, 'deben ser 3 categorías';
    ASSERT (SELECT COUNT(*) FROM libro)     = 3, 'deben ser 3 libros';
    ASSERT (SELECT COUNT(*) FROM cliente)   = 2, 'deben ser 2 clientes';
    ASSERT (SELECT COUNT(*) FROM pedido)    = 3, 'deben ser 3 pedidos';

    -- 2. 3FN: la categoría vive en su propia tabla y nada se repite
    ASSERT (SELECT COUNT(DISTINCT categoria) FROM categoria) = (SELECT COUNT(*) FROM categoria), 'categorías repetidas';
    ASSERT (SELECT COUNT(*) FROM libro l LEFT JOIN categoria c USING (id_categoria) WHERE c.id_categoria IS NULL) = 0, 'libro sin categoría';
    ASSERT (SELECT COUNT(*) FROM pedido p LEFT JOIN cliente c USING (correo_cliente) WHERE c.correo_cliente IS NULL) = 0, 'pedido sin cliente';
    ASSERT (SELECT COUNT(*) FROM pedido p LEFT JOIN libro l USING (isbn) WHERE l.isbn IS NULL) = 0, 'pedido sin libro';

    -- 3. El monto de cada pedido es el precio del libro, y el total de ventas es el de la tabla del ejercicio
    ASSERT (SELECT COUNT(*) FROM pedido p JOIN libro l USING (isbn) WHERE p.monto <> l.precio) = 0, 'monto distinto del precio';
    ASSERT (SELECT SUM(monto) FROM pedido) = 45, 'el total de ventas debe ser 45';
    ASSERT (SELECT COUNT(*) FROM libro WHERE stock < 0) = 0, 'stock negativo';

    -- 4. Cada libro se vendió al menos una vez (la consulta de libros sin comprar debe estar vacía)
    ASSERT (SELECT COUNT(*) FROM libro l LEFT JOIN pedido p ON p.isbn = l.isbn WHERE p.isbn IS NULL) = 0, 'hay libros sin comprar';

    -- 5. Las restricciones rechazan datos inválidos
    BEGIN
        INSERT INTO pedido SELECT correo_cliente, isbn, 'PayPal', 1 FROM pedido LIMIT 1;
        RAISE EXCEPTION 'FALLO: se aceptó un pedido repetido (misma clave compuesta)';
    EXCEPTION WHEN unique_violation THEN NULL;
    END;
    BEGIN
        INSERT INTO libro VALUES ('X-1', 'Libro', 'Autor', NULL, NULL, 99, 10, 1);
        RAISE EXCEPTION 'FALLO: se aceptó una categoría inexistente';
    EXCEPTION WHEN foreign_key_violation THEN NULL;
    END;
    BEGIN
        UPDATE libro SET precio = -1 WHERE isbn = (SELECT isbn FROM libro LIMIT 1);
        RAISE EXCEPTION 'FALLO: se aceptó un precio negativo';
    EXCEPTION WHEN check_violation THEN NULL;
    END;

    RAISE NOTICE 'Tienda de libros: todas las verificaciones pasaron';
END $$;