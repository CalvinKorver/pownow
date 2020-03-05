docker rm -f crawler
docker image build -t crawler:1.3 .
docker container run --publish 8000:8080 --detach --name crawler -it crawler:1.3