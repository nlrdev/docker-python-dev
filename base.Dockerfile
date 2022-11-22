FROM python:3.10.6-slim
RUN apt update -y && apt upgrade -y
RUN apt install -y libpq-dev gcc
RUN pip install --upgrade pip 
RUN mkdir /usr/src/setup
ADD ./requirements.txt /usr/src/setup
WORKDIR /usr/src/setup
RUN pip install --upgrade -r requirements.txt
