# Checkin App Docker-image

Application [jimetevenard/checkin-angular: Liste Checkin](https://github.com/jimetevenard/checkin-angular) et [son petit backend PHP](https://github.com/jimetevenard/checkin-back-php) dans un environnement _LAMP_ (Apache + PHP)

## Lancement

````sh
# Un autre port peut être utilisé. Ex : -p 1234:80 pour le port 1234
docker run -p 80:80 jimetevenard/checkin:latest
````
