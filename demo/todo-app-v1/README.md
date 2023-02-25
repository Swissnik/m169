# todo-app-v1
## Pull Image
- docker pull ghcr.io/swissnik/m169/demo/todo-app-v1/redis-master:v1
- docker pull ghcr.io/swissnik/m169/demo/todo-app-v1/redis-slave:v1
- docker pull ghcr.io/swissnik/m169/demo/todo-app-v1/todo-app:v1

## Create Network
- docker network create todoapp_network

## Run Container
- docker run --net=todoapp_network --name=redis-master -d ghcr.io/swissnik/m169/demo/todo-app-v1/redis-master:v1
- docker run --net=todoapp_network --name=redis-slave -d ghcr.io/swissnik/m169/demo/todo-app-v1/redis-slave:v1
- docker run --net=todoapp_network --name=frontend -d -p 3000:3000 ghcr.io/swissnik/m169/demo/todo-app-v1/todo-app:v1
