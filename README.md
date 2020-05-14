# Dockerize: Python - Django application

Please note this is a development environment. Please read the docs before using live.

## Nginx reverse proxy

The Nginx container is set up with basic config to listen on port 80 and forward all requests to the application container running Gunicorn + Django listening on port 8000.

### Setup

Nginx config can be found here:  `nginx\nginx.conf`

## Django + Gunicorn

### Setup

1. Install [Docker](https://docs.docker.com/engine/install/).

2. Install [Docker Compose](https://docs.docker.com/compose/install/).

3. [Pull](https://github.com/Axiomvp/docker-nginx-gunicorn-django.git) files from git.

4. Copy your Django app to the `app'` directory, ensure the manage.py is accessible: `app'/manage.py`

5. Add any additional requirements to `Pipfile`

6. Run: `[bash/powershell]$ docker-compose build`

7. Run: `[bash/powershell]$ docker-compose up -d`

## Database

This should be changed if you are not using Postgres.