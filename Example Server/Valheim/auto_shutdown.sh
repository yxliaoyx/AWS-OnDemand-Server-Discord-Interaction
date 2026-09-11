tcpdump_output=$(timeout 600 tcpdump -i any -c 1 port 2456 2>/dev/null)

if [[ -n $tcpdump_output ]]; then
    exit 0
fi

established_ssh=$(ss --no-header state established '( dport = :ssh or sport = :ssh )')

if [[ -z $established_ssh ]]; then
    systemctl stop valheim.service
    shutdown now
fi
