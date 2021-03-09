#!/bin/bash

if [ -z "$1" ]; then
    ssh-tarpit --bind-address 0.0.0.0
    exit
fi
if [ "$1" = 'bash' ]; then
    bash
    exit
else
   ssh-tarpit "$@"
   exit
fi
