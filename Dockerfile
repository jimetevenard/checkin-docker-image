FROM mattrayner/lamp:latest
# Image trop lourde et complexe :
#
# - conf apache buggyy (voir https://github.com/mattrayner/docker-lamp/issues/124),
# - /var/www/html est un lien symbolique vers un VOLUME
# - mysql n'est pas utilisé ici...
#
# Trouver (ou crééer) une image de base plus light, avec juste PHP + Apache (ou nginx).



# Une conf qui marche à peu près
# =============================
COPY src/main/apache/apache.conf /etc/apache2/sites-available/000-default.conf



# Téléchargement du frontend (Création assumée d'un layer)
# ========================================================
RUN wget https://github.com/jimetevenard/checkin-angular/releases/download/v1.2.1/checkin-1.2.1_dist.zip


# Transformation de "/var/www/html" en un "vrai" répertoire
# (et non un symlink vers /app/ qui est déclaré en volume dans le Dockerfile d'origine)
RUN rm /var/www/html && mkdir /var/www/html


# Installation du front-end
# =========================
RUN unzip checkin-1.2.1_dist.zip && \
    mv dist/** /var/www/html

# Ce .htacess contient (entre autres) le rewrite pour l'app angular
COPY src/main/apache/htaccess /var/www/html/.htaccess


# Installation du back-end
# ========================
RUN git clone https://github.com/jimetevenard/checkin-back-php.git && \
    mkdir /var/www/html/back && \
    mv checkin-back-php/** /var/www/html/back

# Copie de la config applicative
# ==============================
COPY src/main/resources/config.json /var/www/html/config.json