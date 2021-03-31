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

docker ps (to get :container_id:)

(access website from localhost or run : " docker inspect :container_id: " to get ip address)

# To interact with container shell :
docker exec -it :container_id: /bin/bash

# Stop the container && rm it:
docker container stop :container_id:

docker container rm :container_id:
