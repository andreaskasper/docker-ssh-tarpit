#!/bin/bash

if [ "$1" = 'bash' ]; then
    bash
else
   ssh-tarpit "$@"
fi
