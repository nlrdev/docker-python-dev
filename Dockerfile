FROM localhost:5000/prebuildcontainer:latest
RUN mkdir /usr/src/app
ADD ./website /usr/src/app
WORKDIR /usr/src/app