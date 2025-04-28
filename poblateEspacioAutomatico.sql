
INSERT INTO espacio (
    identificador,
    departamento,
    planta,
    num_max_ocupantes,
    porcentaje_ocupacion,
    es_reservable,
    categoria,
    categoria_de_reserva,
	tam_espacio
)
SELECT
    id_espacio AS identificador,
    NULL AS departamento,
    CAST(altura AS INTEGER) AS planta,
    (FLOOR(RANDOM() * 51) + 50)::INTEGER AS num_max_ocupantes, -- Aleatorio entre 50 y 100
    (FLOOR(RANDOM() * 51) + 50)::INTEGER AS porcentaje_ocupacion, -- Aleatorio entre 50 y 100
    (RANDOM() < 0.5) AS es_reservable, -- Aleatoriamente true o false
    uso AS categoria,
    uso AS categoria_de_reserva,
	superficie AS tam_espacio
FROM
    ada;
