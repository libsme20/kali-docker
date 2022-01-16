# Dockerfile kali-light
# Inspired from thibaudrobin/docker-kali-light


# Official base image
FROM kalilinux/kali-bleeding-edge

# Set working directory to /root
WORKDIR /root

# Apt
RUN apt -y update --fix-missing && apt -y upgrade && apt -y autoremove && apt autoclean

# Basic tools
RUN apt install iputils-ping nano openssh-server net-tools man apt-utils bsdmainutils zip unzip curl vim wget   -y

# Zsh installation and configuration
RUN apt install zsh zsh-autosuggestions -y 

# Installation of all pentest tools of kali-linux
RUN apt install kali-linux-large -y


# History
ADD ./conf/interesting_cmd /root/.zsh_history

# Paramètrage zsh
RUN chsh -s $(which zsh)
RUN wget https://gitlab.com/kalilinux/packages/kali-defaults/-/raw/kali/master/etc/skel/.zshrc -O /root/.zshrc

# Aliases
ADD ./conf/aliases /opt/aliases
RUN echo 'source /opt/aliases' >> /root/.zshrc

CMD ["/bin/zsh"]
