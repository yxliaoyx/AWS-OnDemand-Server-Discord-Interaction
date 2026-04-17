set -e

echo steam steam/license note '' | debconf-set-selections
echo steam steam/question select 'I AGREE' | debconf-set-selections
add-apt-repository -y multiverse
dpkg --add-architecture i386
apt update
NEEDRESTART_MODE=a apt install -y steamcmd
apt clean

useradd --create-home server

cp auto_shutdown.sh /home/server/auto_shutdown.sh
cp server_cron /etc/cron.d/server_cron

cp server.service /etc/systemd/system/server.service
systemctl enable server.service --now
