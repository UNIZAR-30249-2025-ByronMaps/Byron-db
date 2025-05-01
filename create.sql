-- Tabla persona (sin cambios)
CREATE TABLE "reserva_espacio" (
   "reserva_id"  BIGINT,
   "espacio_id" VARCHAR(50) NOT NULL,
   CONSTRAINT "fk_Reserva_espacio_Espacio" FOREIGN KEY ("espacio_id") 
        REFERENCES "espacio" ("identificador") ON DELETE CASCADE
	CONSTRAINT "fk_Reserva_espacio_Reserva" FOREIGN KEY ("reserva_id") 
        REFERENCES "reserva" ("id") ON DELETE CASCADE	
	PRIMARY KEY ( "reserva_id","espacio_id")
);

CREATE TABLE "reserva_espacio" (
   "reserva_id"  BIGINT,
   "espacio_id" VARCHAR(50) NOT NULL,
   CONSTRAINT "fk_Reserva_espacio_Espacio" FOREIGN KEY ("espacio_id") 
        REFERENCES "espacio" ("identificador") ON DELETE CASCADE,
	CONSTRAINT "fk_Reserva_espacio_Reserva" FOREIGN KEY ("reserva_id") 
        REFERENCES "reserva" ("id") ON DELETE CASCADE	,
	PRIMARY KEY ( "reserva_id","espacio_id")
);