#!/bin/sh
set -e

# Display startup banner
echo "═══════════════════════════════════════════════════════"
echo "  SSH TARPIT - Honeypot for SSH Brute Force Attacks"
echo "═══════════════════════════════════════════════════════"
echo "  Bind Address: ${BIND_ADDRESS}"
echo "  Bind Port:    ${BIND_PORT}"
echo "  Verbosity:    ${VERBOSE}"
echo "  Max Clients:  ${MAX_CLIENTS}"
echo "═══════════════════════════════════════════════════════"
echo ""

# If no arguments provided, run with environment variables
if [ -z "$1" ]; then
    exec ssh-tarpit \
        --bind-address "${BIND_ADDRESS}" \
        --bind-port "${BIND_PORT}" \
        --verbosity "${VERBOSE}"
fi

# If 'bash' or 'sh' is requested, start shell (for debugging)
if [ "$1" = 'bash' ] || [ "$1" = 'sh' ]; then
    exec /bin/sh
fi

# Otherwise pass all arguments to ssh-tarpit
exec ssh-tarpit "$@"