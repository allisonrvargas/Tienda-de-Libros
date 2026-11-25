-- Datos de ejemplo del ejercicio (los de la tabla de la tercera forma normal)

INSERT INTO categoria (id_categoria, categoria) VALUES
    (1, 'Infantil'),
    (2, 'Romance'),
    (3, 'Ciencia Ficción');

INSERT INTO libro (isbn, titulo, autor, fecha_publicacion, editorial, id_categoria, precio, stock) VALUES
    ('978-3-16-14841-0-0', 'El principito',       'Antoine de Saint-Exupéry', '1943-04-06', 'Gallimard',       1, 10, 50),
    ('978-0-14-14396-0-0', 'Orgullo y Prejuicio', 'Jane Austen',              '1813-01-28', 'Penguin Classics', 2, 15, 30),
    ('978-0-553-21311-7',  '1984',                'George Orwell',            '1949-06-08', 'Signet Classics',  3, 20, 20);

INSERT INTO cliente (correo_cliente, cliente, telefono_cliente, direccion_cliente) VALUES
    ('juan.perez@gmail.com',   'Juan Pérez',   '3001234567', 'Calle Falsa 123'),
    ('maria.garcia@gmail.com', 'María García', '3109876543', 'Avenida Siempreviva 456');

INSERT INTO pedido (correo_cliente, isbn, metodo_pago, monto) VALUES
    ('juan.perez@gmail.com',   '978-3-16-14841-0-0', 'Tarjeta de Crédito', 10),
    ('maria.garcia@gmail.com', '978-0-14-14396-0-0', 'PayPal',             15),
    ('juan.perez@gmail.com',   '978-0-553-21311-7',  'Tarjeta de Crédito', 20);