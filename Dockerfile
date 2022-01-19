FROM mattrayner/lamp:latest
# Image trop lourde et complexe :
#
# - conf apache buggyy (voir https://github.com/mattrayner/docker-lamp/issues/124),
# - /var/www/html est un lien symbolique vers un VOLUME
# - mysql n'est pas utilisé ici...
#
# Trouver (ou crééer) une image de base plus light avec juste PHP.


# Un conf qui marche à peu près
COPY src/main/apache/apache.conf /etc/apache2/sites-available/000-default.conf

# Download frontend (Création assumée d'un layer)
RUN wget https://github.com/jimetevenard/checkin-angular/releases/download/v1.2.1/checkin-1.2.1_dist.zip

# Make /var/www/html a "real" directory (and not a simlink to /app wich is a volume)
# and install front-end there
RUN rm /var/www/html && \
    mkdir /var/www/html && \
    unzip checkin-1.2.1_dist.zip && \
    mv dist/** /var/www/html

COPY src/main/apache/htaccess /var/www/html/.htaccess

RUN git clone https://github.com/jimetevenard/checkin-back-php.git && \
    mkdir /var/www/html/back && \
    mv checkin-back-php/** /var/www/html/back

COPY src/main/resources/config.json /var/www/html/config.json