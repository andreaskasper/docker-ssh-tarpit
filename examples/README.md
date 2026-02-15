# SSH Tarpit Deployment Examples

This directory contains various deployment examples for different scenarios.

## Files

### `traefik-compose.yml`
Deploy the SSH tarpit alongside Traefik with proper monitoring and logging configuration.

**Use case**: When you already have Traefik running and want to integrate the tarpit into your infrastructure.

```bash
docker-compose -f traefik-compose.yml up -d
```

### `multi-host-swarm.yml`
Deploy the tarpit across all nodes in a Docker Swarm cluster.

**Use case**: Protect every server in your Docker Swarm infrastructure.

```bash
docker stack deploy -c multi-host-swarm.yml tarpit
```

### `monitoring-stack.yml`
Complete monitoring setup with log analysis and metrics export.

**Use case**: When you need detailed statistics and want to integrate with Prometheus/Grafana.

```bash
docker-compose -f monitoring-stack.yml up -d
```

### `systemd-service.txt`
Systemd service file for running the tarpit as a system service.

**Use case**: Run the tarpit on a server without docker-compose, managed by systemd.

```bash
sudo cp systemd-service.txt /etc/systemd/system/ssh-tarpit.service
sudo systemctl daemon-reload
sudo systemctl enable --now ssh-tarpit
```

## Common Deployment Patterns

### 1. Single Server Protection

```bash
# Move SSH to port 2222 first
sudo sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Deploy tarpit on port 22
docker run -d --name ssh-tarpit --restart unless-stopped \
  -p 22:22 andreaskasper/ssh-tarpit:latest
```

### 2. Multi-Server Infrastructure

Use `multi-host-swarm.yml` to deploy across all servers:

```bash
# Initialize swarm on manager
docker swarm init

# Join workers
# docker swarm join --token <token> <manager-ip>:2377

# Deploy stack
docker stack deploy -c multi-host-swarm.yml tarpit
```

### 3. With Existing Monitoring

Integrate with your existing Prometheus/Grafana setup:

```bash
# Deploy with metrics export
docker-compose -f monitoring-stack.yml up -d

# Metrics available at ./metrics/tarpit.prom
# Point your node_exporter textfile collector to this directory
```

## Security Considerations

1. **Always move your real SSH server** to a non-standard port before deploying
2. **Use key-based authentication** on your real SSH server
3. **Implement firewall rules** to restrict access to your real SSH port
4. **Monitor resource usage** to prevent the tarpit from being used in DoS attacks
5. **Regularly review logs** for patterns and adjust firewall rules accordingly

## Tips

- Set `VERBOSE=debug` to see detailed connection attempts
- Use `docker logs -f ssh-tarpit` to watch live attacks
- Adjust `MAX_CLIENTS` based on your server resources
- Consider rate limiting at the firewall level for additional protection

## Questions?

Check the main [README.md](../README.md) or open an issue on GitHub.