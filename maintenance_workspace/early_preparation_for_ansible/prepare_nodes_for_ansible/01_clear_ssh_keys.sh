#!/bin/bash
file="$HOME/.ssh/known_hosts"
for account in `cat list_of_servers.txt former_list_of_servers.txt`; do
    user="${account%%@*}"
    host="${account##*@}"
    ip=$(dig +short ${host})
    echo "<> Clearing ssh identities for ${host}..."
    ssh-keygen -f "${file}" -R "${host}"
    echo "<> ... and its ${ip}"
    ssh-keygen -f "${file}" -R "${ip}"
done
