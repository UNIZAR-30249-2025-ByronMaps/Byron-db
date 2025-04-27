INSERT INTO intervalos_disponibles (espacio_id, date_inicio, date_fin)
SELECT 
    e.identificador,
    d.dia_inicio,
    d.dia_fin
FROM 
    espacio e
CROSS JOIN LATERAL (
    SELECT 
        generate_series(
            '2025-07-01 08:00:00'::timestamp,
            '2025-07-10 08:00:00'::timestamp,
            interval '1 day'
        ) AS inicio
) g
CROSS JOIN LATERAL (
    SELECT 
        g.inicio AS dia_inicio,
        g.inicio + interval '12 hours' AS dia_fin
) d;
