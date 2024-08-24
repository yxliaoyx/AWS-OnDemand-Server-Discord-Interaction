set -e

echo steam steam/license note '' | debconf-set-selections
echo steam steam/question select 'I AGREE' | debconf-set-selections
add-apt-repository -y multiverse
dpkg --add-architecture i386
apt update
NEEDRESTART_MODE=a apt install -y steamcmd wine
apt clean

useradd --create-home abioticfactor

sudo -u abioticfactor -s /bin/bash -c "
mkdir -p ~/.steam/sdk64/;
ln -s ~/linux64/steamclient.so ~/.steam/sdk64/steamclient.so
"

cp start_server.sh /home/abioticfactor/start_server.sh
chmod +x /home/abioticfactor/start_server.sh

cp auto_shutdown.sh /home/abioticfactor/auto_shutdown.sh
cp abioticfactor_cron /etc/cron.d/abioticfactor_cron

cp abioticfactor.service /etc/systemd/system/abioticfactor.service
systemctl enable abioticfactor.service --now
