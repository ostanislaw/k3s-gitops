#!/bin/bash
for account in `cat list_of_servers.txt`; do
    user="${account%%@*}"
    host="${account##*@}"
    file="/etc/sudoers.d/${user}_nopasswd"
    # brackets need to be escaped
    content="${user} ALL=\(ALL:ALL\) NOPASSWD:ALL"
    # ssh -t "${user}@${host}" 'sudo whoami; sudo whoami; sudo whoami'
    echo "<> Setting nopasswd sudo for ${user} at ${host}"
    ssh -t "${user}@${host}" "echo ${content} | sudo tee ${file} && sudo chmod 0440 ${file}; ls -lah ${file}"
done
