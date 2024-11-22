-- Trigger para actualizar el estado 'verificado' de un Usuario cuando se añade una nueva Reseña
CREATE OR REPLACE FUNCTION actualizar_verificado_usuario()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Usuario
    SET verificado = TRUE
    WHERE usuario_id = NEW.usuario_id AND (
        SELECT COUNT(*) FROM Reseña WHERE usuario_id = NEW.usuario_id
    ) > 5;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_actualizar_verificado_usuario
AFTER INSERT ON Reseña
FOR EACH ROW
EXECUTE FUNCTION actualizar_verificado_usuario();

-- Trigger para actualizar el 'precio' de un Videojuego cuando se añade un nuevo Mod
CREATE OR REPLACE FUNCTION actualizar_precio_videojuego()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Videojuego
    SET precio = precio * 1.10
    WHERE id_videojuego = NEW.id_videojuego;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_actualizar_precio_videojuego
AFTER INSERT ON Mod
FOR EACH ROW
EXECUTE FUNCTION actualizar_precio_videojuego();

-- Trigger para actualizar la 'fecha_creación' de un Videojuego cuando se añade un nuevo Logro
CREATE OR REPLACE FUNCTION actualizar_fecha_creacion_videojuego()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Videojuego
    SET fecha_creacion = CURRENT_DATE
    WHERE id_videojuego = NEW.id_videojuego;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_actualizar_fecha_creacion_videojuego
AFTER INSERT ON Logro
FOR EACH ROW
EXECUTE FUNCTION actualizar_fecha_creacion_videojuego();

-- Trigger para validar el 'saldo_recibir' y 'saldo_dado' en Intercambios
CREATE OR REPLACE FUNCTION validar_saldo_intercambios()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.saldo_recibir > NEW.saldo_dado THEN
        RAISE EXCEPTION 'El saldo a recibir no puede ser mayor que el saldo dado';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_validar_saldo_intercambios
BEFORE INSERT OR UPDATE ON Intercambios
FOR EACH ROW
EXECUTE FUNCTION validar_saldo_intercambios();