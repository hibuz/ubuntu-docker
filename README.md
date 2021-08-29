# Custom ubuntu docker image

## 1. Just use Ubuntu OS with `ubuntu` as default user
- Docker run temporary
``` bash
docker run --rm -it hibuz/bash
```

## 2. Addtional images
### 2.1 clone repository
``` bash
git clone https://github.com/hibuz/ubuntu-docker
```

### 2.2 simple docker compose run command
- Docker run
``` bash
cd ubuntu-docker/base

docker compose up
```

### 2.3 zsh docker compose run command
- Docker build and run
``` bash
cd ubuntu-docker

docker compose up
```

## 3 docker build & run command
- see [Dockerfile](Dockerfile) & [Dockerfile.ext](Dockerfile.ext)

# Reference
- https://github.com/black7375/BlaCk-Void-Zsh