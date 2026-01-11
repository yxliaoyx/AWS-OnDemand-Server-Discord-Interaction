find /tmp -name ".X99*" -exec rm -f {} \; > /dev/null 2>&1
xvfb-run --auto-servernum --server-args='-screen 0 640x480x24:32' wine VRisingServer.exe -persistentDataPath ./save-data -logFile server.log
