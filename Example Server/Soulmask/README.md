# Soulmask Server

## Installation

 ```bash
 sudo /bin/bash install.sh
 ```

## Management

```
# check server status (ctrl-c to exit)
systemctl status server.service

# start a server
systemctl start server.service

# stop a server
systemctl stop server.service

# restart a server
systemctl restart server.service

# access to the logs
journalctl -u server.service --lines=10
```
