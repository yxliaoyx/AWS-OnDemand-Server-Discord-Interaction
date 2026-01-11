# V Rising Server

## Installation

1. Edit `start_server.sh`
2. Run the installation script
    ```bash
    sudo /bin/bash install.sh
    ```

## Management

```
# check server status (ctrl-c to exit)
systemctl status vrising.service

# start a server
systemctl start vrising.service

# stop a server
systemctl stop vrising.service

# restart a server
systemctl restart vrising.service

# access to the logs
journalctl -u vrising.service --lines=10
```
