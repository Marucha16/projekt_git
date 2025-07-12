#!/bin/bash

get_hostname() {
    echo "Hostname: $(hostname)"
}

get_os_name() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "OS: $PRETTY_NAME"
    else
        echo "OS: Nieznany"
    fi
}

get_ram_usage() {
    meminfo=$(free -m)
    total=$(echo "$meminfo" | awk '/Mem:/ {print $2}')
    used=$(echo "$meminfo" | awk '/Mem:/ {print $3}')
    free=$(echo "$meminfo" | awk '/Mem:/ {print $4}')

    echo "RAM użyta: ${used} MB"
    echo "RAM wolna: ${free} MB"
    echo "RAM całkowita: ${total} MB"
}

get_disk_usage() {
    df -h --output=source,used,avail,size,target -x tmpfs -x devtmpfs | grep '^/dev/' | while read -r line; do
        echo "$line"
    done
}
get_disk_usage
