established_ssh=$(ss --no-header state established '( dport = :ssh or sport = :ssh )')

if [[ -n $established_ssh ]]; then
    exit 0
fi

# 123 (NTP)
# 27015 (SRCDS)
tcpdump_output=$(timeout 600 tcpdump -c 1 udp and not port 123 and not port 27015 2>/dev/null)

if [[ -z $tcpdump_output ]]; then
    systemctl stop abioticfactor.service
    shutdown now
fi
