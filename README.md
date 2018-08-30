## Nginx reverse proxy and Django + Gunicorn with docker.

The Nginx container is set up with basic config to listen on port 80 and forward all requests to the applications container running Gunicorn + Django listening on port 8000.

## Setup

1. Install [Docker](https://docs.docker.com/install/) on the machine.

2. [Pull](https://github.com/Axiomvp/docker-nginx-gunicorn-django.git) files from git.

3. Copy your Django app in the app into the `bin/'yourapp'` directory, ensure the manage.py is accessible: `bin/'yourapp'/manage.py`

4. Ensure that `'yourapp'` name in the `Dockerfile` and `docker-compose.yml`  match your django applications name in:`bin/'yourapp'`

5. Add any additional requirements to `requirements.txt`

6. In the `bin/` directory, run: `[bash]$ docker-compose up`

## Optional

##### Setup script for centOS/RedHat

Run: `[bash]$ ./setup_linux.sh` once you have configured the setup script.

See below for configureation options:

Create a new user if you want to isolate the python initialization:

    [bash]$ useradd user
    [bash]$ passwd password
    [bash]$ usermod -aG wheel user

Set the user in the bash script `USER=user`
