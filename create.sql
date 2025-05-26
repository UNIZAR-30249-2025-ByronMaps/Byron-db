CREATE TABLE "persona" (
    "id" BIGINT PRIMARY KEY,
    "nombre" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL UNIQUE CHECK ("email" ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    "rol" VARCHAR(255) NOT NULL,
    "rol_secundario" VARCHAR(255),
    "departamento" VARCHAR(255),
    "password" VARCHAR(255) NOT NULL,
    "asignacion_id" BIGINT
);

CREATE TABLE "asignacion" (
    "id" BIGINT PRIMARY KEY,
    "asignado" VARCHAR(255) NOT NULL,
    "departamento" VARCHAR(255)
);

CREATE TABLE "edificio" (
    "edificio_id" VARCHAR(255) PRIMARY KEY,
    "porcentaje_ocupacion" INTEGER NOT NULL 
);

CREATE TABLE "espacio" (
    "identificador" VARCHAR(50) PRIMARY KEY,
    "planta" INTEGER NOT NULL CHECK ("planta" >= 0),
    "num_max_ocupantes" INTEGER NOT NULL CHECK ("num_max_ocupantes" > 0),
    "porcentaje_ocupacion" INTEGER NOT NULL,
    "porcentaje_modificado" BOOLEAN NOT NULL,
    "es_reservable" BOOLEAN NOT NULL,
    "categoria" VARCHAR(255) NOT NULL,
    "categoria_de_reserva" VARCHAR(255) NOT NULL,
    "tam_espacio" FLOAT NOT NULL,
    "id_edificio" VARCHAR(50) NOT NULL,
    "asignacion_id" BIGINT,
    CONSTRAINT fk_espacio_asignacion FOREIGN KEY ("asignacion_id")
        REFERENCES "asignacion" ("id") ON DELETE SET NULL
);

CREATE TABLE "intervalos_edificio" (
    "edificio_id" VARCHAR(50) NOT NULL,
    "date_inicio" TIMESTAMP NOT NULL,
    "date_fin" TIMESTAMP NOT NULL,
    "modificado" BOOLEAN NOT NULL,

    CONSTRAINT "fk_intervalo_espacio" FOREIGN KEY ("edificio_id")
        REFERENCES "edificio" ("edificio_id") ON DELETE CASCADE,

    CHECK ("date_inicio" < "date_fin"),
    PRIMARY KEY ("edificio_id", "date_inicio")
);
CREATE TABLE "intervalos_disponibles" (
    "espacio_id" VARCHAR(50) NOT NULL,
    "date_inicio" TIMESTAMP NOT NULL,
    "date_fin" TIMESTAMP NOT NULL,
    "modificado" BOOLEAN NOT NULL,

    CONSTRAINT "fk_intervalo_espacio" FOREIGN KEY ("espacio_id")
        REFERENCES "espacio" ("identificador") ON DELETE CASCADE,

    CHECK ("date_inicio" < "date_fin"),
    PRIMARY KEY ("espacio_id", "date_inicio")
);

CREATE TABLE "reserva" (
    "id" SERIAL PRIMARY KEY,
    "usuario_id" BIGINT NOT NULL,
    "date_inicio" TIMESTAMP NOT NULL,
    "date_fin" TIMESTAMP NOT NULL,
    "uso" VARCHAR(255) NOT NULL,
    "detalles_adicionales" TEXT,
    "num_asistentes" INTEGER NOT NULL,

    CONSTRAINT "fk_reserva_usuario" FOREIGN KEY ("usuario_id")
        REFERENCES "persona" ("id") ON DELETE CASCADE,

    CHECK ("date_inicio" < "date_fin")
);

CREATE TABLE "reserva_espacio" (
    "reserva_id" BIGINT,
    "espacio_id" VARCHAR(50) NOT NULL,
    
    CONSTRAINT "fk_reserva_espacio_espacio" FOREIGN KEY ("espacio_id")
        REFERENCES "espacio" ("identificador") ON DELETE CASCADE,

    CONSTRAINT "fk_reserva_espacio_reserva" FOREIGN KEY ("reserva_id")
        REFERENCES "reserva" ("id") ON DELETE CASCADE,

    PRIMARY KEY ("reserva_id", "espacio_id")
);
