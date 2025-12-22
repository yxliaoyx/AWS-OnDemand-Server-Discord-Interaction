# Necesse Server

## Installation

```bash
sudo /bin/bash install.sh
```

## Management

```
# check server status (ctrl-c to exit)
systemctl status necesse.service

# start a server
systemctl start necesse.service

# stop a server
systemctl stop necesse.service

# restart a server
systemctl restart necesse.service

# access to the logs
journalctl -u necesse.service --lines=10
```
