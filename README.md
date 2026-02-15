# SSH TARPIT 🪤

A lightweight, secure SSH honeypot that keeps attackers locked up for hours. Built with Docker for easy deployment.

## 🎯 Purpose

This tarpit creates a fake SSH server that responds **extremely slowly** to connection attempts. It's designed to:
- Waste attackers' time and resources
- Protect your real SSH server (which should be on a different port)
- Log and monitor brute force attempts
- Reduce server load from automated attacks

## ✨ Features

- ✅ **Tiny footprint** - Alpine-based image (~50MB vs ~900MB)
- ✅ **Multi-architecture** - Supports amd64, arm64, arm/v7
- ✅ **Secure by default** - Runs as non-root user
- ✅ **Resource limits** - Prevents DoS on the tarpit itself
- ✅ **Automated builds** - GitHub Actions with security scanning
- ✅ **Health monitoring** - Built-in healthcheck
- ✅ **Configurable** - Environment variables for all settings

## 🏗️ Build Status

[![Build Status](https://github.com/andreaskasper/docker-ssh-tarpit/actions/workflows/docker-build.yml/badge.svg)](https://github.com/andreaskasper/docker-ssh-tarpit/actions)
[![Security Scan](https://github.com/andreaskasper/docker-ssh-tarpit/actions/workflows/security-scan.yml/badge.svg)](https://github.com/andreaskasper/docker-ssh-tarpit/actions)
![Docker Pulls](https://img.shields.io/docker/pulls/andreaskasper/ssh-tarpit.svg)
![Docker Image Size](https://img.shields.io/docker/image-size/andreaskasper/ssh-tarpit/latest)

## 🚀 Quick Start

### Using Docker

```bash
# Run on port 22 (make sure your real SSH is on a different port first!)
docker run -d -p 22:22 --name ssh-tarpit andreaskasper/ssh-tarpit
```

### Using Docker Compose

```bash
# Download and run
wget https://raw.githubusercontent.com/andreaskasper/docker-ssh-tarpit/main/docker-compose.yml
docker-compose up -d

# View logs
docker-compose logs -f
```

### Using Docker Stack (Swarm)

```bash
docker stack deploy -c stack.yml tarpit
```

## ⚙️ Configuration

### Environment Variables

| Variable      | Default   | Description                                          |
|---------------|-----------|------------------------------------------------------|
| `BIND_ADDRESS`| 0.0.0.0   | IP address to bind to                                |
| `BIND_PORT`   | 22        | Internal port (usually don't change)                 |
| `VERBOSE`     | info      | Log level: `debug`, `info`, `warn`, `error`, `fatal` |
| `MAX_CLIENTS` | 4096      | Maximum concurrent connections                       |

### Custom Command

```bash
# Get help
docker run andreaskasper/ssh-tarpit --help

# Custom settings
docker run -p 22:22 andreaskasper/ssh-tarpit \
  --bind-address 0.0.0.0 \
  --bind-port 22 \
  --verbosity debug
```

## 🔒 Security Best Practices

### 1. Move Your Real SSH Server First!

**CRITICAL: Do this BEFORE deploying the tarpit!**

```bash
# Edit /etc/ssh/sshd_config
sudo nano /etc/ssh/sshd_config

# Change the port line to:
Port 2222  # Or any non-standard port (e.g., 2200, 22000)

# Restart SSH
sudo systemctl restart sshd

# Test the new port (open a NEW terminal, don't close the current one!)
ssh -p 2222 user@your-server
```

### 2. Deploy the Tarpit on Port 22

```bash
docker run -d \
  --name ssh-tarpit \
  --restart unless-stopped \
  -p 22:22 \
  andreaskasper/ssh-tarpit
```

### 3. Use Firewall Rules

```bash
# Allow your real SSH only from specific IPs
sudo ufw allow from 192.168.1.0/24 to any port 2222
sudo ufw allow from YOUR_HOME_IP to any port 2222

# Allow tarpit from everywhere
sudo ufw allow 22/tcp

# Enable firewall
sudo ufw enable
```

## 🎛️ Advanced Deployments

### With Traefik (for monitoring)

```yaml
version: '3.8'

services:
  ssh-tarpit:
    image: andreaskasper/ssh-tarpit:latest
    restart: unless-stopped
    ports:
      - "22:22"
    networks:
      - monitoring
    labels:
      - "traefik.enable=false"  # SSH doesn't use HTTP
    logging:
      driver: "json-file"
      options:
        max-size: "50m"
        max-file: "5"

networks:
  monitoring:
    external: true
```

### With Resource Limits

```yaml
services:
  ssh-tarpit:
    image: andreaskasper/ssh-tarpit:latest
    ports:
      - "22:22"
    deploy:
      resources:
        limits:
          cpus: '2.0'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 128M
```

### Monitoring Trapped Connections

```bash
# Watch live connections
docker logs -f ssh-tarpit

# Count trapped IPs
docker logs ssh-tarpit 2>&1 | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' | sort | uniq -c | sort -rn

# Export logs for analysis
docker logs ssh-tarpit > /var/log/ssh-tarpit.log
```

## 📊 Statistics

View connection attempts:

```bash
# Show last 100 connection attempts
docker logs ssh-tarpit --tail 100 | grep "Connection"

# Top attacking IPs
docker logs ssh-tarpit | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' | \
  sort | uniq -c | sort -rn | head -20

# Hourly attack statistics
docker logs ssh-tarpit --since 1h | grep -c "Connection"
```

## 🐛 Troubleshooting

### Port already in use

```bash
# Find what's using port 22
sudo lsof -i :22
# or
sudo netstat -tlnp | grep :22

# If it's SSH, move it to another port first (see Security Best Practices)
```

### Container won't start

```bash
# Check logs
docker logs ssh-tarpit

# Run in interactive mode for debugging
docker run -it --rm -p 22:22 andreaskasper/ssh-tarpit sh
```

### Permission denied

```bash
# Ports < 1024 require privileged access on some systems
docker run -d -p 22:22 --cap-add=NET_BIND_SERVICE andreaskasper/ssh-tarpit
```

### Can't SSH to real server after deployment

```bash
# Make sure you can still access your real SSH port
ssh -p 2222 user@your-server

# Check if SSH is listening on the new port
sudo netstat -tlnp | grep sshd

# If needed, temporarily stop the tarpit
docker stop ssh-tarpit
```

## 🏗️ Building from Source

```bash
# Clone repository
git clone https://github.com/andreaskasper/docker-ssh-tarpit.git
cd docker-ssh-tarpit

# Build image
docker build -t ssh-tarpit:local .

# Run your build
docker run -d -p 22:22 ssh-tarpit:local
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

MIT License - feel free to use this in your projects!

## 💰 Support the Project

- [![Patreon](https://img.shields.io/badge/Donate-Patreon-orange.svg)](https://www.patreon.com/AndreasKasper)
- [![PayPal](https://img.shields.io/badge/Donate-PayPal-blue.svg)](https://www.paypal.me/AndreasKasper)

## ⚠️ Disclaimer

This is a defensive security tool. Use it responsibly and only on systems you own or have permission to protect. The maintainers are not responsible for any misuse.

**Always ensure you have alternative access to your server before deploying the tarpit on port 22!**

---

**Made with ❤️ by [Andreas Kasper](https://github.com/andreaskasper)**
