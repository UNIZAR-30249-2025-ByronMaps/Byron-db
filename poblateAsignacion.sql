INSERT INTO asignacion (id, asignado, departamento)
SELECT
    row_number() OVER () AS id,           -- Genera un id secuencial
   	'EINA' AS asignado, -- Asignado aleatorio
    NULL                           -- O el campo que tengas en 'ada' para departamento
FROM
    ada
WHERE
    id_espacio IS NOT NULL;
