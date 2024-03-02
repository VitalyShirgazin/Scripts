#!/bin/bash

# Specify the names of your VirtualBox machines
vm_names=("Ubuntu1" "Ubuntu2" "Ubuntu3" "CentOS1")

# Start or report status for each VirtualBox machine
for vm_name in "${vm_names[@]}"; do
    # Check if the VirtualBox machine is already locked
    is_locked=$(VBoxManage showvminfo --machinereadable "$vm_name" 2>/dev/null | grep "VMState=" | cut -d "=" -f2)

    if [ "$is_locked" == "running" ]; then
        echo "VirtualBox machine '$vm_name' is already running."
    elif [ "$is_locked" == "locked" ]; then
        echo "VirtualBox machine '$vm_name' is already locked by another session or process."
    else
        # Start the VirtualBox machine
        VBoxManage startvm "$vm_name" --type headless > /dev/null 2>&1

        # Check the exit status of the VBoxManage command
        if [ $? -eq 0 ]; then
            echo "VirtualBox machine '$vm_name' started successfully."
        else
            echo "VirtualBox machine has already started '$vm_name'."
        fi
    fi
done
