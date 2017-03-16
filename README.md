# SpearmintServerDocker
Configuration files to create a docker for SpearmintServer

## Prerequisites:
- docker installed and running in your machine.
- A docker running a mysql image with a database named spearmintdb and proper credentials (pwd goes into secrets.json).
- A docker running a mongodb image with a database called spearmint and the 27017 port exposed (use of credentials highly recommended).
- A docker running a reverse nginx proxy.

*** Note: See Wiki section for more detailed instructions 

## Installation:
1. Create a secrets.json file in the root of this project with the database password and the django secret key.
2. Clone SpearmintServer git into the root of this project
```bash
git clone https://github.com/acil-bwh/SpearmintServer.git
```
3. Build the docker image
```bash
docker build -t <image_name> .
```
4. Run the docker image
```bash
docker run --name <container_name> --link spearmintdb:mysql -e VIRTUAL_HOST=<domain_name> -d <image_name>
```
* On first deployment:
  * Run the container bash:
  ```bash
  docker exec -ti <container_name> /bin/bash
  ```
  * Create the database tables:
  ```bash
  python manage.py makemigrations
  python manage.py migrate
  ```
  * Create a superuser:
  ```bash
  python manage.py createsuperuser
  ```
  * Use superuser to enter admin page and introduce your mongo db credentials:
  
  Go to `<your_domain>/admin` on your browser and login with superuser credentials.
  Create a mongo db entry and introduce db_domain, login and password.
  
  
  
