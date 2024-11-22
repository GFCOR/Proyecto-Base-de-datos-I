-- Tabla Usuario
CREATE TABLE IF NOT EXISTS Usuario (
                                       usuario_id INT PRIMARY KEY,
                                       nombre VARCHAR(50) NOT NULL,
                                       apodo VARCHAR(30) NOT NULL,
                                       verificado BOOLEAN NOT NULL
);

-- Tabla Videojuego
CREATE TABLE IF NOT EXISTS Videojuego (
                                          id_videojuego INT PRIMARY KEY,
                                          nombre VARCHAR(100) NOT NULL,
                                          descripcion VARCHAR(255) NOT NULL,
                                          fecha_creacion DATE NOT NULL,
                                          precio NUMERIC(10, 2) NOT NULL
);

-- Tabla Intercambio
CREATE TABLE IF NOT EXISTS Intercambio (
                                           id_intercambio INT PRIMARY KEY,
                                           usuario_id_1 INT REFERENCES Usuario(usuario_id),
                                           usuario_id_2 INT REFERENCES Usuario(usuario_id),
                                           saldo_dado NUMERIC(10, 2) NOT NULL,
                                           saldo_recibir NUMERIC(10, 2) NOT NULL,
                                           fecha_transaccion DATE NOT NULL
);

-- Tabla Logro
CREATE TABLE IF NOT EXISTS Logro (
                                     id_logro INT PRIMARY KEY,
                                     id_videojuego INT REFERENCES Videojuego(id_videojuego),
                                     nombre VARCHAR(50) NOT NULL,
                                     descripcion VARCHAR(255) NOT NULL
);

-- Tabla Mod
CREATE TABLE IF NOT EXISTS Mod (
                                   id_mod INT PRIMARY KEY,
                                   id_videojuego INT REFERENCES Videojuego(id_videojuego),
                                   descripcion VARCHAR(255) NOT NULL,
                                   tipo VARCHAR(30) NOT NULL
);

-- Tabla Objeto
CREATE TABLE IF NOT EXISTS Objeto (
                                      objeto_id INT PRIMARY KEY,
                                      id_videojuego INT REFERENCES Videojuego(id_videojuego),
                                      nombre VARCHAR(50) NOT NULL,
                                      descripcion VARCHAR(255) NOT NULL
);

-- Tabla Reseña
CREATE TABLE IF NOT EXISTS Reseña (
                                      id_reseña INT PRIMARY KEY,
                                      id_videojuego INT REFERENCES Videojuego(id_videojuego),
                                      usuario_id INT REFERENCES Usuario(usuario_id),
                                      comentario VARCHAR(255) NOT NULL,
                                      fecha_comentario DATE NOT NULL,
                                      horas_jugadas INT NOT NULL
);