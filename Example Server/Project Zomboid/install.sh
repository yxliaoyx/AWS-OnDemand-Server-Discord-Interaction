set -e

echo steam steam/license note '' | debconf-set-selections
echo steam steam/question select 'I AGREE' | debconf-set-selections
add-apt-repository -y multiverse
dpkg --add-architecture i386
apt update
NEEDRESTART_MODE=a apt install -y steamcmd
apt clean

useradd --create-home projectzomboid

cp auto_shutdown.sh /home/projectzomboid/auto_shutdown.sh
cp projectzomboid_cron /etc/cron.d/projectzomboid_cron

cp projectzomboid.service /etc/systemd/system/projectzomboid.service
cp projectzomboid.socket /etc/systemd/system/projectzomboid.socket
systemctl enable projectzomboid.service --now
