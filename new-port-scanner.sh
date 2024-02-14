#!/bin/bash

# List of IP addresses and corresponding ports
ip_ports=(
"192.168.74.54 12000,12001,12002,12003,12004,12005"
"192.168.74.55 12000,12001,12002,12003,12004,12005"	
"192.168.74.56 12000,12001,12002,12003,12004,12005"
)

# Loop through each entry in the list
for entry in "${ip_ports[@]}"; do
  # Extract IP and ports from the entry
  ip=$(echo $entry | cut -d ' ' -f 1)
  ports=$(echo $entry | cut -d ' ' -f 2)

  # Loop through each port for the current IP
  for port in $(echo $ports | tr ',' ' '); do
    nc_output=$(nc -vzw 2 $ip $port 2>&1)
    echo "Connection to $ip:$port - Output: $nc_output"
  done
done
