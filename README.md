#### dependencies
- docker
You can get docker [here](https://docs.docker.com/get-docker/).Make sure you can run `docker` and `docker-compose` in your terminal.

#### Step to run the project
Go to the project direcotory, run the follow commands:
```
# build
docker-compose build

# start service
docker-compose up

# create db and tables
docker-compose run web rails db:create
docker-compose run web rails db:migrate
```
Visit localhost:300


