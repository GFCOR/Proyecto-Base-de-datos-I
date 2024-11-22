Pregunta: ¿Cuáles son los usuarios que han escrito más reseñas y cuántas horas han jugado en total? Justificación: Identificar a los usuarios más activos ayuda a entender el compromiso de los usuarios y puede ser utilizado para promociones dirigidas.
-- Consulta para encontrar los usuarios con más reseñas y sus horas jugadas totales
SELECT
    u.nombre AS usuario,
    u.apodo,
    COUNT(r.id_reseña) AS total_reseñas,
    SUM(r.horas_jugadas) AS total_horas_jugadas
FROM
    Usuario u
    JOIN Reseña r ON u.usuario_id = r.usuario_id
GROUP BY
    u.usuario_id
ORDER BY
    total_reseñas DESC, total_horas_jugadas DESC;

Pregunta: ¿Cuáles son los juegos que tienen más mods creados para ellos? Justificación: Entender qué juegos tienen más mods puede ayudar a identificar juegos populares y áreas potenciales para expansión o soporte.
-- Consulta para encontrar los juegos más populares por número de mods
SELECT
    v.nombre AS videojuego,
    COUNT(m.id_mod) AS total_mods
FROM
    Videojuego v
    JOIN Mod m ON v.id_videojuego = m.id_videojuego
GROUP BY
    v.id_videojuego
ORDER BY
    total_mods DESC;


Pregunta: ¿Cuál es el precio promedio de los juegos por género? Justificación: Esto ayuda a entender las tendencias de precios dentro de diferentes géneros y puede asistir en estrategias de precios.
-- Consulta para encontrar el precio promedio de los juegos por género
SELECT
    genero,
    AVG(precio) AS precio_promedio
FROM
    Videojuego
GROUP BY
    genero
ORDER BY
    precio_promedio DESC;

Pregunta: ¿Cuántos usuarios están verificados basado en el número de reseñas que han escrito? Justificación: Esto ayuda a entender el impacto de la actividad del usuario en el estado de verificación.
-- Consulta para encontrar el número de usuarios verificados basado en sus reseñas
SELECT
    verificado,
    COUNT(usuario_id) AS total_usuarios
FROM
    Usuario
GROUP BY
    verificado
ORDER BY
    total_usuarios DESC;

Pregunta: ¿Cuál es el monto total de transacciones entre usuarios? Justificación: Esto ayuda a entender el volumen de transacciones entre usuarios y puede ser utilizado para análisis financieros.
-- Consulta para encontrar el monto total de transacciones entre usuarios
SELECT
    u1.nombre AS usuario_1,
    u2.nombre AS usuario_2,
    SUM(i.saldo_dado) AS total_saldo_dado,
    SUM(i.saldo_recibir) AS total_saldo_recibir
FROM
    Intercambio i
    JOIN Usuario u1 ON i.usuario_id_1 = u1.usuario_id
    JOIN Usuario u2 ON i.usuario_id_2 = u2.usuario_id
GROUP BY
    u1.usuario_id, u2.usuario_id
ORDER BY
    total_saldo_dado DESC, total_saldo_recibir DESC;