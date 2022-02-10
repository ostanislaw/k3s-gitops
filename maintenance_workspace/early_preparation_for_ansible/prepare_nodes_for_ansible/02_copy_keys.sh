#!/bin/bash
for account in `cat list_of_servers.txt`; do
    echo "<> Copy ssh key for ${account}..."
    ssh-copy-id -i ~/.ssh/id_rsa.pub "${account}"
done
