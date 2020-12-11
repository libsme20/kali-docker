# Version française

# Image Kali Linux dans un conteneur Docker

# Ce dépôt est fortement inspiré du dépot thibaudrobin/docker-kali-light

Ce dépôt a pour objectif de déployer localement un conteneur Docker basé sur une image vierge de Kali linux. 
Les outils les plus intéressants sont paramétrés pour être installés sur l'image de Kali Linux Vierge.
Cela permet d'avoir une instance Kali linux optimisée en fonction des besoins.

## Pré-requis

Les paquets python-pip3 sont requis pour installer docker-compose.
```bash
sudo apt update -y && sudo apt install python-pip3
```


```bash
sudo apt update -y
sudo apt install -y docker.io 
sudo systemctl enable docker --now
sudo usermod -aG docker $USER
```


## Installation

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
pip3 install docker-compose --user
docker-compose run kali
```

Créer des alias

```bash
echo "alias kali='docker-compose -f $HOME/docker-kali-light/docker-compose.yml run kali-light'" >> .bashrc && source .bashrc
```

Vous pouvez également modifier le fichier Dockerfile pour obtenir plus d'outils.


## Autres projets


Pour plus d'infos sur l'installation https://thibaud-robin.fr/articles/docker-kali/

Vous pouvez également utiliser gratuitement le projet Shutdown: https://github.com/ShutdownRepo/Exegol
