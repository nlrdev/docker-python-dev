## Read Me


##### Nginx reverse proxy and Django + Gunicorn with docker.

The Nginx container is set up with basic config to listen on port 80 and forward all requests to the applications container running Gunicorn + Django listening on port 8000.

## Setup 
1. Install 
[Docker](https://docs.docker.com/install/) on the machine.

2. Pull files from git.

3. Copy your Django app in the app into the `Bin/'yourapp'` directory, ensure the manage.py is accessible in app: `Bin/'yourapp'/manage.py`

4. Ensure that `'yourapp'` name in the `Dockerfile` and `docker-compose.yml`  match your django applications name in:`Bin/'yourapp'`

5. Ensure you add any additional requirements to `requirements.txt`

6. in the`Bin` directory run ` :~# docker-compose up `


## Optional

##### Setup script for centOS/RH

Once you have configured the setup script.
Run`:~# ./setup_linux.sh`

Create a new user if you want to isolate the python initialization:

    :~# useradd user
    :~# passwd password
    :~# usermod -aG wheel user

Set the user in the bash script ` USER=user ` 
