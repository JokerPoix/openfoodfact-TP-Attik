#!/bin/bash
set -e

# Lancer Jupyter en arrière-plan
start-notebook.sh --ServerApp.token='' --ServerApp.password='' &

# Attendre que Jupyter soit prêt
echo "⏳ Attente que Jupyter démarre..."
while ! nc -z localhost 8888; do sleep 1; done

# Ensuite, exécuter les notebooks
bash /usr/local/bin/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa.sh

# Garder le conteneur en vie
wait
