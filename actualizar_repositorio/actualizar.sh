#!/bin/bash

# Ruta del repositorio local
REPO="/home/vboxuser/Lab03_SO"

# Rama que se comprueba
BRANCH="main"

# Consultar cambios en GitHub
if ! runuser -u vboxuser -- git -C "$REPO" fetch origin "$BRANCH"; then
    echo "Error al consultar el repositorio."
    exit 1
fi

# Obtener los commits local y remoto
LOCAL=$(runuser -u vboxuser -- git -C "$REPO" rev-parse HEAD)
REMOTO=$(runuser -u vboxuser -- git -C "$REPO" rev-parse "origin/$BRANCH")

# Actualizar únicamente si hay cambios existentes
if [ "$LOCAL" != "$REMOTO" ]; then
    if runuser -u vboxuser -- git -C "$REPO" merge --ff-only "origin/$BRANCH"; then
        echo "Repositorio actualizado correctamente."
    else
        echo "Error al aplicar los cambios."
        exit 1
    fi
else
    echo "No hay cambios nuevos."
fi
