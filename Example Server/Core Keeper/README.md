# Core Keeper Server

## Installation

```bash
sudo /bin/bash install.sh
```

## Server Config

```
/home/corekeeper/.config/unity3d/Pugstorm/Core\ Keeper/DedicatedServer/ServerConfig.json
```

## Management

```
# check server status (ctrl-c to exit)
systemctl status corekeeper.service

# start a server
systemctl start corekeeper.service

# stop a server
systemctl stop corekeeper.service

# restart a server
systemctl restart corekeeper.service

# access to the logs
journalctl -u corekeeper.service --lines=10
```
