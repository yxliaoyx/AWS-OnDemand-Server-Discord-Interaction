# Project Zomboid Server

## Installation

1. Edit startup parameters in `projectzomboid.service`.
   Refer to [Startup parameters](https://pzwiki.net/wiki/Startup_parameters) for details.


2. Run the following command to install:
   ```bash
   sudo /bin/bash install.sh
   ```

## Management

```
# check server status (ctrl-c to exit)
systemctl status projectzomboid.service

# start the server
systemctl start projectzomboid.service

# stop the server
systemctl stop projectzomboid.service

# restart the server
systemctl restart projectzomboid.service

# access logs
journalctl -u projectzomboid.service --lines=10
```
