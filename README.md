# Image Kali Linux dans un conteneur Docker


Origin (en): This repository is inspired from https://github.com/thibaudrobin/docker-kali. The purpose is to improve and customize it.

Origine(fr): Ce dépôt est fortement inspiré de https://github.com/thibaudrobin/docker-kali/ et a pour but d'être personnalisé et amélioré.


Son objectif est de déployer localement un conteneur Docker basé sur une image vierge de Kali linux.
Les outils les plus intéressants sont paramétrés pour être installés sur l'image de Kali Linux Vierge.
Cela permet d'avoir une instance Kali linux avec une taille optimisée en fonction des besoins logiciels.

## Pré-requis

Les paquets python3-pip sont requis pour installer docker-compose.
```bash
sudo apt update -y && sudo apt install python-pip
```

Pour l'installation de docker, nous reprenons ces lignes de commandes basées sur le site officiel de kali.

```bash
sudo apt update -y
sudo apt install -y docker.io docker-compose
sudo systemctl enable docker --now
sudo usermod -aG docker $USER
# @Todo verify if it's still a requirement
#sudo gpasswd -a $USER docker
#newgrp docker
```

Cela permet théoriquement de pouvoir exécuter docker sans avoir besoin d'utiliser sudo.


## Installation



Cloner le projet

```bash
git clone git@github.com:libsme20/kali-docker.git
cd kali-docker
```

Créer et partager un lot de commandes utiles dans l'historique bash et/ou ssh qui peuvent être réutilisées.

```
sudo mkdir /mnt/kali-share
sudo cp conf/interesting_cmd /mnt/kali-share/.zsh_history
sudo cp conf/interesting_cmd /mnt/kali-share/.bash_history
```

Construire l'image

```bash
docker build -t kali .
```

Créer des conteneurs

```
sudo chown $USER /var/run/docker.sock
# La commande rm permet de supprimer le conteneur une fois le terminal de kali quitté
sudo docker-compose run --rm kali
```

Créer des alias

```bash
KALI_BASEPATH=$HOME/Documents/docker-containers
echo "alias kali='docker-compose -f $KALI_BASEPATH/kali-docker/docker-compose.yml run kali-docker'" >> .bashrc && source .bashrc
```

Vous pouvez également modifier le fichier Dockerfile pour obtenir plus d'outils.


## Autres projets


Pour plus d'information sur l'installation, vous pouvez voir le tutoriel original à l'adresse suivante: https://thibaud-robin.fr/articles/docker-kali/
