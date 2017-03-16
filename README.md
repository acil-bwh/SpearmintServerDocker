# SpearmintServerDocker
Configuration files to create a docker for SpearmintServer

## Prerequisites:
- docker installed and running in your machine.
- A docker running a mysql image with a database named spearmintdb and proper credentials (pwd goes into secrets.json)
- A docker running a mongodb image with a database called spearmint and the 27017 port exposed (use of credentials highly recommended)
- A docker running a reverse nginx proxy.

## Usage:
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
docker run --name <container_name> --link spearmintdb:mysql -e VIRTUAL_HOST=spmint.chestimagingplatform.org -d <image_name>
```
