#!/bin/bash

# Configuration
APP_CONTAINER="web_backend"
DISK_THRESHOLD=85
LOG_FILE="/var/log/infra_health.log"

# Get timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# 1 Resource Checks

CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {
    printf "%.0f", 100 - $8
}')

RAM_USAGE=$(free | awk '/Mem:/ {
    printf "%.0f", ($3/$2) * 100
}')

DISK_USAGE=$(df -P / | awk 'NR==2 {gsub("%",""); print $5}')

echo "Infrastructure Health Check"
echo "Timestamp : $TIMESTAMP"
echo "CPU Usage : ${CPU_USAGE}%"
echo "RAM Usage : ${RAM_USAGE}%"
echo "Disk Usage: ${DISK_USAGE}%"

# 2 Docker Check

if systemctl is-active --quiet docker; then
    echo "Docker     : RUNNING"
else
    echo "[WARNING] Docker service is not running"
    echo "$TIMESTAMP [WARNING] Docker service is not running" >> "$LOG_FILE"
fi

# 3 Application Container Check

if docker ps --format '{{.Names}}' | grep -q "^${APP_CONTAINER}$"; then
    echo "Application: ${APP_CONTAINER} - RUNNING"
else
    echo "[WARNING] Application container ${APP_CONTAINER} is stopped"
    echo "$TIMESTAMP [WARNING] Application container ${APP_CONTAINER} is stopped" >> "$LOG_FILE"
fi

# 4 Disk Usage Check

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    echo "[WARNING] Root disk usage is ${DISK_USAGE}%"
    echo "$TIMESTAMP [WARNING] Root disk usage is ${DISK_USAGE}%" >> "$LOG_FILE"
fi

echo
