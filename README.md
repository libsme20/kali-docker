# Image Kali Linux dans un conteneur Docker


Origin (en): This repository is inspired from https://github.com/thibaudrobin/docker-kali. The main purpose is to keep it updated and customize it.

Origine(fr): Ce dépôt est inspiré de https://github.com/thibaudrobin/docker-kali/ et a pour but d'être personnalisé et maintenu.


Son objectif est de déployer localement un conteneur Docker basé sur une image vierge de Kali linux.
Les outils les plus intéressants sont paramétrés pour être installés sur l'image de Kali Linux Vierge.
Cela permet d'avoir une instance Kali linux avec une taille optimisée en fonction des besoins logiciels.

## Pré-requis

Les paquets python-pip3 sont requis pour installer docker-compose.
```bash
sudo apt update -y && sudo apt install python3-pip
pip3 install docker-compose --user
```

Pour l'installation de docker, nous reprenons ces lignes de commandes basées sur le site officiel de kali.

```bash
sudo apt-get update -y 
sudo apt-get install ca-certificates curl gnupg lsb-release uidmap dbus-user-session -y 

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

En cas de problème, voir la page suivante:
```
https://docs.docker.com/engine/security/rootless/#troubleshooting
```

Cela permet théoriquement de pouvoir exécuter docker sans avoir besoin d'utiliser sudo.


## Installation


Créer et partager un lot de commandes utiles dans l'historique bash et/ou ssh qui peuvent être réutilisées.

```bash
# Copie du dist
cp docker-compose.yml.dist docker-compose.yml

# CHOISIR SON CHEMIN
HOST_SHARED_PATH_GENERAL=/mnt/kali
HOST_SHARED_PATH_HTB=/home/$(whoami)/Documents/htb

# Configuration pour le chemin general

sudo mkdir -p $HOST_SHARED_PATH_GENERAL
sed -i "s|<CHEMIN_GENERAL>|$HOST_SHARED_PATH_GENERAL|g" docker-compose.yml
sudo cp conf/interesting_cmd $HOST_SHARED_PATH_GENERAL/.zsh_history

# Configuration pour le chemin htb
sed -i "s|<CHEMIN_HTB>|$HOST_SHARED_PATH_HTB|g" docker-compose.yml

```

Construire l'image

```bash
docker build -t kali .
```

Créer des conteneurs

```
docker-compose run kali
```

Créer des alias

```bash
KALI_BASEPATH=$HOME/shared
echo "alias kali='docker-compose -f $KALI_BASEPATH/kali/docker-compose.yml run kali'" >> .bashrc && source .bashrc
```

Vous pouvez également modifier le fichier Dockerfile pour obtenir plus d'outils.
























Mode de connexion internet
```
docker network create -d bridge kali-bridge-nw
```









