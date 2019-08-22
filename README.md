# My Lamp Docker

## Quick Start

### 1 - First Step
#### Install Docker

```
wget -O docker-install.sh  https://get.docker.com/
sudo chmod +x docker-install.sh
./docker-install.sh
```

If you're trying to install it on MacOS, download the .dmg file using the code below and install it.
```
wget https://download.docker.com/mac/stable/Docker.dmg
```

### 2- Second Step
#### Install Docker-Compose

```
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
./usr/local/bin/docker-compose
```


### 3 - Third Step
#### Creating containers

```
sudo docker-compose up -d
```
