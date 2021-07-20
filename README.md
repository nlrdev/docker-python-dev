# Dockerize: Python Application

This is a development environment. Please read the docs before using live.

## Nginx reverse proxy

Nginx config can be found here:  `nginx\nginx.conf`

## Django + Gunicorn

1. Install [Docker](https://docs.docker.com/engine/install/).

2. Install [Docker Compose](https://docs.docker.com/compose/install/).

3. [Pull](https://github.com/Axiomvp/docker-nginx-gunicorn-django.git) files from git.

4. Copy your Django app to the `'app'` directory, ensure the `manage.py` is accessible: `app/manage.py`

5. Add any additional requirements to `Pipfile`

6. Run: `[bash/powershell]$ docker-compose build`

7. Run: `[bash/powershell]$ docker-compose up -d`

## Database

This should be changed if you are not using Postgres. Update the login details in the docker-compose file below `environment`


## Additional configuration


### traefik 

Add the following labels to the docker-compose file once you have [installed and configured](https://doc.traefik.io/traefik/providers/docker/) the traefik server.
```
    labels:
      - "traefik.enable=true"
      - "traefik.docker.network=somenet"
      - "traefik.http.routers.entrypoints=web"
      - "traefik.http.routers.nginx-frontend.rule=Host(`app.localhost`)"
      - "traefik.http.services.nginx-frontend.loadbalancer.server.port=80"
```
