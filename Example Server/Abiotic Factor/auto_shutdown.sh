tcpdump_output=$(timeout 600 tcpdump -c 1 port 7777 2>/dev/null)

if [[ -n $tcpdump_output ]]; then
    exit 0
fi

established_ssh=$(ss --no-header state established '( dport = :ssh or sport = :ssh )')

if [[ -z $established_ssh ]]; then
    systemctl stop abioticfactor.service
    shutdown now
fi
