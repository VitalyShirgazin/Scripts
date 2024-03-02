#!/bin/bash

# Array of VM names
vm_names=("Ubuntu1" "Ubuntu2" "Ubuntu3" "centOS1")

# Loop through each VM and gracefully shut it down using ACPI shutdown
for vm_name in "${vm_names[@]}"; do
    echo "Shutting down ${vm_name} gracefully using ACPI shutdown..."
    vboxmanage controlvm "${vm_name}" acpipowerbutton
done

echo "Waiting for VMs to shut down gracefully..."

# Wait for a short duration to allow VMs to shut down
sleep 10

# Check if any VM is still running and force power off if needed
for vm_name in "${vm_names[@]}"; do
    running_status=$(vboxmanage showvminfo --machinereadable "${vm_name}" | grep "VMState=" | cut -d "=" -f2)
    
    if [ "${running_status}" == "running" ]; then
        echo "Forcing power off for ${vm_name}..."
        vboxmanage controlvm "${vm_name}" poweroff
    else
        echo "${vm_name} is already powered off."
    fi
done

echo "All VMs have been shut down."

