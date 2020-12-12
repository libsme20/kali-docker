# Dockerfile kali-light
# Inspired from thibaudrobin/docker-kali-light, thanks for sharing


# Official base image
FROM kalilinux/kali-rolling

# Set working directory to /root
WORKDIR /root

# Apt
RUN apt -y update --fix-missing && apt -y upgrade && apt -y autoremove && apt autoclean

# Basic tools
RUN apt install default-mysql-client iputils-ping man aircrack-ng amap apt-utils bsdmainutils cewl crackmapexec crunch curl dirb dirbuster dnsenum dnsrecon dnsutils dos2unix enum4linux exploitdb ftp gcc git gobuster golang hashcat hping3 hydra iputils-ping john joomscan kpcli libffi-dev make masscan metasploit-framework mimikatz nasm nbtscan ncat netcat-traditional nikto nmap onesixtyone oscanner passing-the-hash patator php powershell powersploit proxychains4 python2 python3 python3-pip python3-setuptools python-dev python-setuptools recon-ng responder ruby-dev samba samdump2 seclists sipvicious smbclient smbmap smtp-user-enum snmp socat sqlmap ssh-audit sslscan tcpdump testssl.sh theharvester tnscmd10g vim wafw00f weevely wfuzz whatweb whatweb whois wordlists wpscan zsh -y --no-install-recommends

# Advanced tools (comment if not needed)
ADD ./install.sh /root/install.sh
RUN chmod +x /root/install.sh && /root/install.sh && rm /root/install.sh

# put interesting cmds inside history
ADD ./conf/interesting_cmd /root/.zsh_history
ADD ./conf/interesting_cmd /root/.bash_history


# Aliases
ADD ./conf/aliases /opt/aliases
RUN echo 'source /opt/aliases' >> /root/.zshrc
RUN echo 'source /opt/aliases' >> /root/.bashrc

WORKDIR /root

# Open shell, can be used if zsh is preferred
# CMD ["/bin/zsh"]
