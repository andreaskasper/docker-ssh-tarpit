# Multi-stage build for minimal image size
FROM python:3.14-alpine AS builder

# Install build dependencies
RUN apk add --no-cache \
    gcc \
    musl-dev \
    python3-dev

# Install ssh-tarpit
RUN pip3 install --no-cache-dir --user ssh-tarpit

# Final stage - minimal runtime image
FROM python:3.14-alpine

LABEL maintainer="Andreas Kasper <andreas.kasper@goo1.de>" \
      description="SSH Tarpit - Slow down SSH brute force attacks" \
      org.opencontainers.image.source="https://github.com/andreaskasper/docker-ssh-tarpit" \
      org.opencontainers.image.description="A tarpit that locks SSH clients for hours" \
      org.opencontainers.image.licenses="MIT"

# Security: Run as non-root user
RUN addgroup -g 1000 tarpit && \
    adduser -D -u 1000 -G tarpit tarpit

# Copy Python packages from builder
COPY --from=builder /root/.local /home/tarpit/.local

# Make sure scripts in .local are usable
ENV PATH=/home/tarpit/.local/bin:$PATH

# Default configuration
ENV BIND_ADDRESS=0.0.0.0
ENV BIND_PORT=22
ENV VERBOSE=info
ENV MAX_CLIENTS=4096

# Expose SSH port
EXPOSE 22

WORKDIR /app

# Copy entrypoint
COPY --chown=tarpit:tarpit entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Switch to non-root user
USER tarpit

# Healthcheck to verify tarpit is running
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD nc -z localhost ${BIND_PORT} || exit 1

ENTRYPOINT ["/entrypoint.sh"]
CMD []