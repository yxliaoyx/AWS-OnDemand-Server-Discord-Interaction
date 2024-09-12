# Satisfactory Server

## Installation

```bash
sudo /bin/bash install.sh
```

## Management

```
# check server status (ctrl-c to exit)
systemctl status satisfactory.service

# start a server
systemctl start satisfactory.service

# stop a server
systemctl stop satisfactory.service

# restart a server
systemctl restart satisfactory.service

# access to the logs
journalctl -u satisfactory.service --lines=10
```
