set -e

echo steam steam/license note '' | debconf-set-selections
echo steam steam/question select 'I AGREE' | debconf-set-selections
add-apt-repository -y multiverse
dpkg --add-architecture i386
apt update
NEEDRESTART_MODE=a apt install -y steamcmd
apt clean

useradd --create-home necesse

sudo -u necesse -s /bin/bash -c "
mkdir -p ~/.steam/sdk64/;
ln -s ~/linux64/steamclient.so ~/.steam/sdk64/steamclient.so
"

cp auto_shutdown.sh /home/necesse/auto_shutdown.sh
cp necesse_cron /etc/cron.d/necesse_cron

cp necesse.service /etc/systemd/system/necesse.service
systemctl enable necesse.service --now
