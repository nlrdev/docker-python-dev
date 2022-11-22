# Dockerize: Python Application

This example is for a django app, however any wsgi/asgi based app should work

## configuration


### Build:

Build a base image, don't have to recompile dependencies when rebuilding the app
    
    $: docker build -f base.Dockerfile . -t localhost:5000/prebuildcontainer:latest

Build the app image and deploy locally 

    $: docker compose build
    $: docker compose up -d    

### Example pipline:

Jenkinsfile

    pipeline {
        agent any

        stages {
            stage('Build') {
                steps {
                    sh 'docker compose -f prod.docker-compose.yml down'
                    sh 'docker volume rm  my_app_website_data'
                    sh 'docker compose -f prod.docker-compose.yml build --no-cache'
                }
            }
            stage('Deploy') {
                steps {
                    sh 'docker compose -f prod.docker-compose.yml up -d --force-recreate'
                }
            }
        }
    }




## Additional configuration

### Secret key:

    from django.core.management.utils import get_random_secret_key
    print(get_random_secret_key())

### traefik:

[install and configure](https://doc.traefik.io/traefik/providers/docker/) the traefik server.

See [docker-traefik-proxy repo](https://github.com/nlrdev/docker-traefik-proxy)