FROM jupyter/pyspark-notebook:latest

# (facultatif) Ajout de dépendances si nécessaire
COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Copier le notebook dans le conteneur
COPY openfoodfacts_etl.ipynb /home/jovyan/work/

# Dossier de travail
WORKDIR /home/jovyan/work

# Exposer Jupyter
EXPOSE 8888
