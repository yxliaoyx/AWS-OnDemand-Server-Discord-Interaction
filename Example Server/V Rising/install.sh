set -e

echo steam steam/license note '' | debconf-set-selections
echo steam steam/question select 'I AGREE' | debconf-set-selections
add-apt-repository -y multiverse
dpkg --add-architecture i386
apt update
NEEDRESTART_MODE=a apt install -y steamcmd wine
apt clean

useradd --create-home vrising

sudo -u vrising -s /bin/bash -c "
mkdir -p ~/.steam/sdk64/;
ln -s ~/linux64/steamclient.so ~/.steam/sdk64/steamclient.so
"

cp start_server.sh /home/vrising/start_server.sh
chmod +x /home/vrising/start_server.sh

cp auto_shutdown.sh /home/vrising/auto_shutdown.sh
cp vrising_cron /etc/cron.d/vrising_cron

cp vrising.service /etc/systemd/system/vrising.service
systemctl enable vrising.service --now
