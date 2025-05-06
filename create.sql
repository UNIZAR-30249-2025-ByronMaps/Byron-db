CREATE TABLE "persona" (
    "id" BIGINT PRIMARY KEY,
    "nombre" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL UNIQUE CHECK ("email" ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    "rol" VARCHAR(255) NOT NULL,
    "rol_secundario" VARCHAR(255) NULL,
    "departamento" VARCHAR(255) NULL,
	"password" VARCHAR(255) NOT NULL
);

CREATE TABLE "espacio" (
    "identificador" VARCHAR(50) NOT NULL UNIQUE PRIMARY KEY,
    "departamento" VARCHAR(255) NULL,
    "planta" INTEGER NOT NULL CHECK ("planta" >= 0),
    "num_max_ocupantes" INTEGER NOT NULL CHECK ("num_max_ocupantes" > 0),
    "porcentaje_ocupacion" INTEGER NOT NULL CHECK ("porcentaje_ocupacion" >= 0 AND "porcentaje_ocupacion" <= 100),
    "es_reservable" BOOLEAN NOT NULL,
    "categoria" VARCHAR(255) NOT NULL,
    "categoria_de_reserva" VARCHAR(255) NOT NULL,
	"tam_espacio" FLOAT NOT NULL
);

CREATE TABLE "intervalos_disponibles" (
    "espacio_id" VARCHAR(50) NOT NULL,
    "date_inicio" TIMESTAMP NOT NULL,
    "date_fin" TIMESTAMP NOT NULL,

    CONSTRAINT "fk_Intervalo_Espacio" FOREIGN KEY ("espacio_id")
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
    "detalles_adicionales" TEXT NULL,
    "num_asistentes" INTEGER NOT NULL,

    CONSTRAINT "fk_Reserva_Usuario" FOREIGN KEY ("usuario_id") 
        REFERENCES "persona" ("id") ON DELETE CASCADE,
    CHECK ("date_inicio" < "date_fin")
);

CREATE TABLE "reserva_espacio" (
   "reserva_id"  BIGINT,
   "espacio_id" VARCHAR(50) NOT NULL,
   CONSTRAINT "fk_Reserva_espacio_Espacio" FOREIGN KEY ("espacio_id") 
        REFERENCES "espacio" ("identificador") ON DELETE CASCADE,
	CONSTRAINT "fk_Reserva_espacio_Reserva" FOREIGN KEY ("reserva_id") 
        REFERENCES "reserva" ("id") ON DELETE CASCADE,	
	PRIMARY KEY ( "reserva_id","espacio_id")
);