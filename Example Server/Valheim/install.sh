set -e

echo steam steam/license note '' | debconf-set-selections
echo steam steam/question select 'I AGREE' | debconf-set-selections
add-apt-repository -y multiverse
dpkg --add-architecture i386
apt update
NEEDRESTART_MODE=a apt install -y steamcmd
apt clean

useradd --create-home valheim

sudo -u valheim -s /bin/bash -c "
mkdir -p ~/.steam/sdk64/
ln -sf ~/linux64/steamclient.so ~/.steam/sdk64/steamclient.so
"

cp auto_shutdown.sh /home/valheim/auto_shutdown.sh
chown valheim:valheim /home/valheim/auto_shutdown.sh
chmod +x /home/valheim/auto_shutdown.sh
cp valheim_cron /etc/cron.d/valheim_cron
chmod 644 /etc/cron.d/valheim_cron

cp valheim.service /etc/systemd/system/valheim.service
systemctl daemon-reload
systemctl enable valheim.service --now
