established_ssh=$(ss --no-header state established '( dport = :ssh or sport = :ssh )')

if [[ -n $established_ssh ]]; then
    exit 0
fi


tcpdump_output=$(timeout 600 tcpdump -c 10 port 27015 2>/dev/null)

if [[ -z $tcpdump_output ]]; then
    systemctl stop corekeeper.service
    shutdown now
fi
