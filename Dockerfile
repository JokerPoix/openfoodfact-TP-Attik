FROM jupyter/pyspark-notebook:spark-3.3.0

# Passer en root pour installer Hadoop et les libs natives
USER root

# Définition de HADOOP_HOME et création du dossier
ENV HADOOP_HOME=/usr/local/hadoop
RUN mkdir -p $HADOOP_HOME \
    && chown -R jovyan:users $HADOOP_HOME

# Installer les bibliothèques natives pour Snappy et LZ4
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      libsnappy1v5 libsnappy-dev \
      liblz4-1 liblz4-dev && \
    rm -rf /var/lib/apt/lists/*

# Revenir à l’utilisateur jovyan pour l’exécution Jupyter
USER jovyan

# Copie des dépendances Python
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# ✅ Activer les widgets dans JupyterLab
RUN pip install ipywidgets && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build && \
    jupyter lab build

# Copie du contenu du projet
COPY --chown=jovyan:users . /home/jovyan/work/

# Répertoire de travail
WORKDIR /home/jovyan/work

# Exposition du port Jupyter
EXPOSE 8888