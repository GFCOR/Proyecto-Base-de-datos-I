-- Restricciones de unicidad
ALTER TABLE Usuario
ADD CONSTRAINT unique_apodo_usuario UNIQUE (apodo);

ALTER TABLE Videojuego
ADD CONSTRAINT unique_nombre_videojuego UNIQUE (nombre);

-- Validar fechas
ALTER TABLE Videojuego
ADD CONSTRAINT chk_fecha_creacion_videojuego CHECK (fecha_creacion <= CURRENT_DATE);

ALTER TABLE Reseña
ADD CONSTRAINT chk_fecha_comentario CHECK (fecha_comentario <= CURRENT_DATE);

-- Validar precios
ALTER TABLE Videojuego
ADD CONSTRAINT chk_precio_videojuego CHECK (precio > 0);

-- Validar horas jugadas
ALTER TABLE Reseña
ADD CONSTRAINT chk_horas_jugadas CHECK (horas_jugadas >= 0);

-- Validar saldos en Intercambios
ALTER TABLE Intercambio
ADD CONSTRAINT chk_saldo_recibir CHECK (saldo_recibir >= 0),
ADD CONSTRAINT chk_saldo_dado CHECK (saldo_dado >= 0);