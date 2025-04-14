# Usa la imagen oficial de PostgreSQL
FROM postgres:latest

# Copia tus scripts SQL al directorio de inicialización de PostgreSQL
COPY init.sql /docker-entrypoint-initdb.d/

# PostgreSQL escuchará en el puerto 5432
EXPOSE 5432