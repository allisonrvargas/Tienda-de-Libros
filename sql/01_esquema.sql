-- Tienda de Libros: esquema en tercera forma normal (PostgreSQL)
-- Sigue el diagrama entidad-relación del README: CLIENTE, PEDIDOS, LIBROS y CATEGORÍA.

DROP TABLE IF EXISTS pedido, libro, cliente, categoria CASCADE;

CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY,
    categoria    VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE libro (
    isbn              VARCHAR(20) PRIMARY KEY,
    titulo            VARCHAR(120) NOT NULL,
    autor             VARCHAR(100) NOT NULL,
    fecha_publicacion DATE,
    editorial         VARCHAR(80),
    id_categoria      INT NOT NULL REFERENCES categoria (id_categoria),
    precio            NUMERIC(10,2) NOT NULL CHECK (precio >= 0),
    stock             INT NOT NULL DEFAULT 0 CHECK (stock >= 0)
);

CREATE TABLE cliente (
    correo_cliente    VARCHAR(100) PRIMARY KEY,
    cliente           VARCHAR(100) NOT NULL,
    telefono_cliente  VARCHAR(20),
    direccion_cliente VARCHAR(150)
);

-- Un pedido relaciona a un cliente con un libro (clave compuesta, como en el diagrama)
CREATE TABLE pedido (
    correo_cliente VARCHAR(100) NOT NULL REFERENCES cliente (correo_cliente),
    isbn           VARCHAR(20)  NOT NULL REFERENCES libro (isbn),
    metodo_pago    VARCHAR(30)  NOT NULL,
    monto          NUMERIC(10,2) NOT NULL CHECK (monto >= 0),
    PRIMARY KEY (correo_cliente, isbn)
);