#!/bin/bash

export VOLUME=${VOLUME:-/mnt/core}

# Print "Hello, World!" and any command-line arguments
echo "Hello, World! $@"
echo ""
echo "I am..."

aws sts get-caller-identity

# echo the arguments to a file /mnt/core/arguments.txt

echo $@ > $VOLUME/arguments.txt
