
FROM ubuntu:18.04

MAINTAINER Dockerfiles

# Install required packages and remove the apt packages cache when done.

RUN apt-get update && \
    apt-get upgrade -y && \ 
    apt-get install -y \
        git \
        python3 \
        python3-dev \
        libpq-dev \
        python-setuptools \
        python3-pip \
        nginx \
        supervisor \
        libmysqlclient-dev \
        sqlite3 && \
    rm /usr/bin/python && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    pip3 install -U pip setuptools && \
    rm -rf /var/lib/apt/lists/*

# install uwsgi
RUN pip install uwsgi


# setup all the configfiles
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY nginx-app.conf /etc/nginx/sites-available/default
COPY supervisor-app.conf /etc/supervisor/conf.d/


# COPY requirements.txt and RUN pip install BEFORE adding the rest of your code, this will cause Docker's caching mechanism
# to prevent re-installinig (all your) dependencies when you made a change a line or two in your app.

COPY requirements.txt /home/docker/code/SpearmintServer/
RUN pip install -r /home/docker/code/SpearmintServer/requirements.txt

# add (the rest of) our code
COPY . /home/docker/code/
COPY secrets.json /home/docker/code/SpearmintServer/SpearmintServer/ 
ENV HOME /home/docker/code/SpearmintServer/
WORKDIR $HOME

RUN python manage.py collectstatic --noinput
RUN pip install git+http://github.com/acil-bwh/Spearmint.git@develop
RUN python setup.py install


EXPOSE 80
CMD ["supervisord", "-n"]
