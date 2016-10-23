#/bin/bash

#curl -fsSL https://get.docker.com/ | sh
echo "Installing Docker via apt-get..."
apt-get install docker -q -y

echo "Setting up the journald logging driver option..."
mkdir /var/log/journal
mkdir /etc/systemd/system/docker.service.d
cp journald-logging.conf /etc/systemd/system/docker.service.d/

systemctl daemon-reload
systemctl restart systemd-journald

echo "Enabling and starting the Docker service..."
systemctl enable docker
systemctl start docker

echo "Done!"
