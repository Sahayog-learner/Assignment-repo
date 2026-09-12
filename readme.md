
## Task 1 – System Provisioning & Linux Administration

1. Created an Ubuntu Server VM using VirtualBox and configured the VM networking for host-to-VM access.
2. Created the `trainee` user and granted it sudo privileges.
3. Configured SSH key-based authentication for the `trainee` user.
4. Changed the SSH service from port `22` to port `2222` and disabled direct SSH login for root.
5. Enabled and configured UFW to allow only:
   - SSH – `2222`
   - HTTP – `80`
   - HTTPS – `443`
6. Verified SSH connectivity using the new port and `trainee` user.

## Command to see the status of firewall
```bash 
sudo ufw status verbose
```

## Task 2 – Containerization & Web Services

1. Installed and configured Docker and Docker Compose.
2. Created the web stack under `/opt/webstack/`.
3. Created a Docker Compose configuration containing three services:
   - Nginx reverse proxy
   - Backend application
   - PostgreSQL database
4. Configured the backend to listen on its internal application port.
5. Configured PostgreSQL with a persistent Docker volume for database data.
6. Configured Nginx to receive requests on port `80` and forward them to the backend service.
7. Started the complete stack using Docker Compose.
8. Verified the running containers and tested the application through the Nginx endpoint.

# Verify container status
```bash 
docker ps 
```

# Verify proxy routing

On server

    ```bash
        curl -v http://localhost
    ```
On Browser

    ```bash
    curl -v <Server-ip>
    ```

## Task 3 – Automation & Shell Scripting

1. Created the `infra_health_check.sh` script under `/opt/scripts/`.
2. Implemented checks for CPU usage, memory usage, root filesystem usage, Docker service status, and web application container status.
3. Added warning handling when disk usage exceeds `85%` or the application container is stopped.
4. Configured timestamped warning entries to be written to `/var/log/infra_health.log`.
5. Made the script executable and tested it manually.
6. Configured a cron job to execute the health-check script every 15 minutes.
7. Verified the cron configuration and generated logs.

## Task 4 – Monitoring, Backups & Disaster Recovery

1. Created the database backup script `db_backup.sh` under `/opt/scripts/`.
2. Configured the script to create a database dump, compress it, and store timestamped backups under `/var/backups/db/`.
3. Tested the backup process and verified that backup files were created successfully.
4. Documented the database restoration procedure using the generated backup archive.
5. Configured basic system and container monitoring using Prometheus and Node Exporter.
6. Verified that system metrics were being collected and made available through the monitoring setup.