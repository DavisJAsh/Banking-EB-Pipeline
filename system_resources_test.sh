#!/bin/bash

# Objective: Checks for CPU usage and pushes the report to a GitHub repo if usage exceeds a certain threshold.

# Email details
to="ashleigh.kuralabs@gmail.com"
subject="Abnormal CPU usage"

# Calculate CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU Usage: $cpu_usage%"

# Check if CPU usage exceeds 60%
if (( $(echo "$cpu_usage > 60" | bc -l) )); then 
    exit_code=1
    # Send an email alert
    body="CPU usage is exceeding expectations at $cpu_usage%. Attention is necessary!"
    echo "$body" | mail -s "$subject" "$to"
else
    exit_code=0
fi

# Push CPU report to GitHub
git add .
git commit -m "Current CPU Usage: $cpu_usage%"
git push -u origin main

exit $exit_code
