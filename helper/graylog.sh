# Run Graylog in Docker
# http://docs.graylog.org/en/stable/pages/installation/docker.html

docker run -d --name mongo --restart always mongo:3
docker run -d --name elasticsearch -e "discovery.type=single-node" -e "bootstrap.memory_lock=false" -e "http.host=0.0.0.0" -e "ES_JAVA_OPTS=-Xms512m -Xmx512m" --restart always docker.elastic.co/elasticsearch/elasticsearch:6.6.1
docker run -d --name graylog --link mongo --link elasticsearch -p 9000:9000 -p 12201:12201 -p 1514:1514 -p 5555:5555 -e GRAYLOG_HTTP_EXTERNAL_URI="http://127.0.0.1:9000/" -e GRAYLOG_ROOT_PASSWORD_SHA2=8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918 --restart always graylog/graylog:3.0
