# Abiotic Factor Server

## Installation

1. Edit `start_server.sh`
2. Run the installation script
    ```bash
    sudo /bin/bash install.sh
    ```

## Management

```
# check server status (ctrl-c to exit)
systemctl status abioticfactor.service

# start a server
systemctl start abioticfactor.service

# stop a server
systemctl stop abioticfactor.service

# restart a server
systemctl restart abioticfactor.service

# access to the logs
journalctl -u abioticfactor.service --lines=10
```
