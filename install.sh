set -e

apt update

apt install -y docker.io
apt install -y nodejs
apt install -y npm
apt install -y python3-pip
apt install -y python3-venv
apt install -y unzip
apt clean

npm install -g aws-cdk

wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
unzip -q awscli-exe-linux-x86_64.zip && rm awscli-exe-linux-x86_64.zip
./aws/install --update

aws configure

python3 -m venv .venv
source .venv/bin/activate
pip install --no-cache-dir -r requirements.txt
python3 discord_command_register.py
cdk bootstrap
cdk deploy
deactivate

rm -r cdk.out
docker image prune -a --force
