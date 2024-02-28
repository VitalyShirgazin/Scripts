#!/bin/bash

# Array of Vagrant machine IP addresses
vagrant_ips=("192.168.1.10" "192.168.1.8" "192.168.1.9")

# Loop through each Vagrant machine
for ip in "${vagrant_ips[@]}"; do
    echo "Checking if Vagrant machine at $ip is reachable..."

    # Check if the server is reachable using ping
    if ping -c 1 -W 1 $ip &> /dev/null; then
        echo "Shutting down Vagrant machine at $ip..."
        
        # SSH into the Vagrant machine and issue shutdown command
        ssh vagrant@$ip "sudo shutdown -h now"
        
        # Add a sleep to allow time for the shutdown command to take effect
        sleep 5

        echo "Vagrant machine at $ip shut down successfully."
    else
        echo "Vagrant machine at $ip is not reachable or already shut down."
    fi
done

echo "All Vagrant machines checked and shutted down successfuly."

