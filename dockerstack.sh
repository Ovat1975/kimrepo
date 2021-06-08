#delete docker stack
docker stack rm b2b
#run docker stack
docker stack deploy -c docker-compose.yml -c docker-compose.override.yml namastack
#add env config update
docker service update --env-add "URL_CUSTCOMPANY=http://sample.com/custcompany/" namastack
