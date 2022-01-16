# Image Kali Linux dans un conteneur Docker


Origin (en): This repository is inspired from https://github.com/thibaudrobin/docker-kali. The main purpose is to keep it updated and customize it.

Origine(fr): Ce dépôt est inspiré de https://github.com/thibaudrobin/docker-kali/ et a pour but d'être personnalisé et maintenu.


Son objectif est de déployer localement un conteneur Docker basé sur une image vierge de Kali linux.
Les outils les plus intéressants sont paramétrés pour être installés sur l'image de Kali Linux Vierge.
Cela permet d'avoir une instance Kali linux avec une taille optimisée en fonction des besoins logiciels.

## Pré-requis

Les paquets python-pip3 sont requis pour installer docker-compose.
```bash
sudo apt update -y && sudo apt install python3-pip ca-certificates curl gnupg lsb-release uidmap dbus-user-session
```

## Installation de docker


Pour l'installation de docker, nous reprenons ces lignes du site officiel de kali. 
Le mode de docker est rootless, cela signifie qu'il n'y a pas besoin d'avoir les droits d'administration pour utiliser docker.


```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose -y 

/usr/bin/dockerd-rootless-setuptool.sh install

systemctl --user start docker
systemctl --user enable docker
sudo loginctl enable-linger $(whoami)
docker context use rootless
```

En cas de problème avec le mode rootless de docker, voir la page suivante:
```
https://docs.docker.com/engine/security/rootless/#troubleshooting
```


## Montage NFS 


Permet de réaliser des montages NFS au lancement du conteneur. Il est possible d'ajouter d'autres points de montage.
Il y a deux exempes ci-dessous.

```bash
# Copie du dist
cp docker-compose.yml.dist docker-compose.yml

# CHOISIR SON CHEMIN
HOST_SHARED_PATH_GENERAL=/mnt/kali
HOST_SHARED_PATH_HTB=$HOME/Documents/htb

# Configuration pour le chemin general

sudo mkdir -p $HOST_SHARED_PATH_GENERAL
sed -i "s|<CHEMIN_GENERAL>|$HOST_SHARED_PATH_GENERAL|g" docker-compose.yml
# permet de copier de commandes interessantes dans le .zsh_history
sudo cp conf/interesting_cmd $HOST_SHARED_PATH_GENERAL/.zsh_history

# Configuration pour le chemin htb
sed -i "s|<CHEMIN_HTB>|$HOST_SHARED_PATH_HTB|g" docker-compose.yml

```

## Utilisation de docker

Construire l'image

```bash
docker build -t kali .
```

Créer des conteneurs

```bash
# instance réutilisable
docker-compose up -d kali

# instance plus court terme
docker-compose run kali
```

Liste les conteneurs existants. Attention, ne pas oublier l'option -a
```bash
docker ps -a
```

Executer un conteneur:
```bash
docker exec -ti axxxxxxxxxx1 /bin/zsh
```

Supprimer un conteneur:
```bash
docker rm -f axxxxxxxxxx1
```

# Alias pour se connecter facilement à son instance

```bash
DOCKER_CONTAINER_ID=<REPERTOIRE DE CE DEPOT>
SHELL_HOST=/bin/bash
echo "alias kali-docker='docker exec -ti $DOCKER_CONTAINER_ID $SHELL_HOST'" >> ~/.bashrc && source ~/.bashrc
```