#!/bin/bash

apt-get -q update
apt-get -y install git-core

# pre-add github's host key to avoid prompt
mkdir -p /home/swarm/.ssh
ssh-keyscan -H github.com >> /home/swarm/.ssh/known_hosts
chmod 600 /home/swarm/.ssh/known_hosts

# grab most configuration stuff from our .symerc
git clone https://github.com/seajure/.symerc /tmp/symerc
echo 'US/Pacific' > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata
su -c /tmp/symerc/bootstrap swarm
#rm -rf /tmp/symerc

# get the script we use to add user's public keys
curl -LsS http://git.io/addkey > /usr/local/bin/add-github-key

# From syme's Clojure.sh
sudo apt-get -y install openjdk-7-jre-headless
sudo wget -qO /usr/local/bin/lein https://raw.github.com/technomancy/leiningen/stable/bin/lein
sudo chmod +x /usr/local/bin/lein
