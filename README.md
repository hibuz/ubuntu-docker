# Custom ubuntu docker image

## 1. 🚀 Run Oh My Zsh Instantly on Ubuntu
- Docker run temporary
```zsh
# default user: ubuntu
docker run --rm -it hibuz/zsh
```
```bash
# default user: hibuz
docker run --rm -it hibuz/bash
```

## 2. Addtional images

### 2.1 simple docker compose run command
- Docker run
```bash
git clone https://github.com/hibuz/ubuntu-docker

cd ubuntu-docker

docker compose up


```

### 2.2 hadoop-base docker compose build command
- Docker build and run
```bash
docker compose -f docker-compose-hadoop.yml build
```

## 3 docker build & run command
- see [Dockerfile](Dockerfile) & [Dockerfile.zsh](Dockerfile.zsh)
