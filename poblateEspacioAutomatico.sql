
INSERT INTO espacio (
    identificador,
    planta,
    num_max_ocupantes,
    porcentaje_ocupacion,
    porcentaje_modificado,
    es_reservable,
    categoria,
    categoria_de_reserva,
	tam_espacio,
    id_edificio,
    asignacion_id
)
SELECT
    id_espacio AS identificador,
    CAST(altura AS INTEGER) AS planta,
    (FLOOR(RANDOM() * 51) + 50)::INTEGER AS num_max_ocupantes, -- Aleatorio entre 50 y 100
    80 AS porcentaje_ocupacion,
    false AS porcentaje_modificado,
    true AS es_reservable, -- Aleatoriamente true o false
    uso AS categoria,
    uso AS categoria_de_reserva,
	superficie AS tam_espacio,
    'Ada' AS id_edificio,
    ROW_NUMBER() OVER () AS asignacion_id
FROM
    ada;
