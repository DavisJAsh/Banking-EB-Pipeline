#!/bin/bash

# Objective: Checks for CPU usage and pushes the report to a GitHub repo if usage exceeds a certain threshold.

# Calculate CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU Usage: $cpu_usage%"

# Check if CPU usage exceeds 60%
if (( $(echo "$cpu_usage > 60" | bc -l) )); then 
    exit_code=1
 else
    exit_code=0
fi

exit $exit_code
