# Valheim Server

## Installation

```bash
sudo /bin/bash install.sh
```

This installs SteamCMD, creates the `valheim` user, and sets up the auto-shutdown cron job and systemd service.

## Configuration

Before starting the server, update the default values in `valheim.service`:

- `-name "Valheim Server"`: server name
- `-password "change_me"`: server password
- `-world "Dedicated"`: world name
- `-public 0`: set to `1` if you want the server listed publicly

Then reload the service:

```bash
sudo systemctl daemon-reload
sudo systemctl restart valheim.service
```

## Management

```bash
# check server status (ctrl-c to exit)
systemctl status valheim.service

# start a server
systemctl start valheim.service

# stop a server
systemctl stop valheim.service

# restart a server
systemctl restart valheim.service

# access to the logs
journalctl -u valheim.service --lines=20
```

The default Valheim game port is UDP `2456`, and the auto-shutdown check will power off the EC2 instance if there is no
active gameplay traffic and no active SSH session.
