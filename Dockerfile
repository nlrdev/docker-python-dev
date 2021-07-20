FROM python:3.8-slim
RUN mkdir /usr/src/app
WORKDIR /usr/src/app
ADD ./app /usr/src/app
RUN pip install --upgrade pip 
RUN pip install pipenv
RUN pipenv install --skip-lock --system --dev
