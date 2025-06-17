#!/bin/bash

# === Configuración ===
CONTAINER_NAME="postgres_db"
DB_NAME="ERP_Ventas"
DB_USER="erp_user"
BACKUP_DIR="./backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/erp_backup_$DATE.sql"

# === Crear directorio de respaldo si no existe ===
mkdir -p "$BACKUP_DIR"

# === Ejecutar respaldo desde dentro del contenedor ===
docker exec -t "$CONTAINER_NAME" pg_dump -U "$DB_USER" -d "$DB_NAME" > "$BACKUP_FILE"

# === Verificar éxito ===
if [ $? -eq 0 ]; then
    echo "✅ Respaldo exitoso: $BACKUP_FILE"
else
    echo "❌ Error en el respaldo"
    exit 1
fi
