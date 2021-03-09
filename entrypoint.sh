#!/bin/bash

if [ -z "$1" ]; then
    ssh-tarpit --bind-address ${BIND_ADDRESS} --bind-port ${BIND_PORT} --verbosity ${VERBOSE}
    exit
fi
if [ "$1" = 'bash' ]; then
    bash
    exit
else
   ssh-tarpit "$@"
   exit
fi
