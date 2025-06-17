#!/bin/bash

# === Configuración ===
CONTAINER_NAME="postgres_db"
DB_NAME="ERP_Ventas"
DB_USER="erp_user"
BACKUP_FILE=$1

# === Verificar argumento ===
if [ -z "$BACKUP_FILE" ]; then
  echo "❌ Debes especificar el archivo de respaldo: ./restore_postgres.sh backups/erp_backup_YYYY-MM-DD_HH-MM-SS.sql"
  exit 1
fi

# === Restaurar respaldo ===
cat "$BACKUP_FILE" | docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME"

# === Verificar éxito ===
if [ $? -eq 0 ]; then
    echo "✅ Restauración completada desde $BACKUP_FILE"
else
    echo "❌ Error durante la restauración"
    exit 1
fi
