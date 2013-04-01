#!/usr/bin/env bash
# Some simple steps that allow to improve security of your SSH server
#
# Usage: wget -q -O - https://raw.github.com/vitalk/serv-recipes/master/install/secure-ssh.sh | sh

# disable remote root login
sed -ie 's/#\?PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

# disable password login
sed -ie 's/#\?PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# disable empty password login
sed -ie 's/#\?PermitEmptyPasswords yes/PermitEmptyPasswords no/' /etc/ssh/sshd_config

# enable PAM
sed -ie 's/#\?UsePAM no/UsePAM yes/' /etc/ssh/sshd_config

# increase key strength, once your change this regenerate your SSH host keys
sed -ie 's/#\?ServerKeyBits 768/ServerKeyBits 2048/' /etc/ssh/sshd_config
service ssh restart
rm -v /etc/ssh/ssh_host*
for t in rsa dsa; do
    ssh-keygen -q -t $t -N '' -f /etc/ssh/ssh_host_${t}_key;
done
