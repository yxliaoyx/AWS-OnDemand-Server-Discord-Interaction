set -e

echo steam steam/license note '' | debconf-set-selections
echo steam steam/question select 'I AGREE' | debconf-set-selections
add-apt-repository -y multiverse
dpkg --add-architecture i386
apt update
NEEDRESTART_MODE=a apt install -y steamcmd xvfb mesa-utils
apt clean

useradd --create-home corekeeper

sudo -u corekeeper -s /bin/bash -c "
mkdir -p ~/.steam/sdk64/;
ln -s ~/linux64/steamclient.so ~/.steam/sdk64/steamclient.so
"

cp auto_shutdown.sh /home/corekeeper/auto_shutdown.sh
cp corekeeper_cron /etc/cron.d/corekeeper_cron

cp corekeeper.service /etc/systemd/system/corekeeper.service
systemctl enable corekeeper.service --now
