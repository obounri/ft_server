# ft_server
Introduction to the basics of system and network administration. 
 
Install a complete web server, using Docker deployment technology.
# Container OS : 
debian:buster
# Services :
WordPress website, phpMyAdmin and MySQL.

Set SSL protocol.
 # Run project :
docker build --tag server .

docker run -p 80:80 -p 443:443 server

# To interact with container shell :
docker ps (to get "container id")
 
docker exec -it "container id" /bin/bash
