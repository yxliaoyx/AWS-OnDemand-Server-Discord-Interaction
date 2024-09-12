set -e

echo steam steam/license note '' | debconf-set-selections
echo steam steam/question select 'I AGREE' | debconf-set-selections
add-apt-repository -y multiverse
dpkg --add-architecture i386
apt update
NEEDRESTART_MODE=a apt install -y steamcmd
apt clean

useradd --create-home satisfactory

cp auto_shutdown.sh /home/satisfactory/auto_shutdown.sh
cp satisfactory_cron /etc/cron.d/satisfactory_cron

cp satisfactory.service /etc/systemd/system/satisfactory.service
systemctl enable satisfactory.service --now
