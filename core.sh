#!/bin/zsh

LOCAL_DIR="$(pwd)/local"
AWS_DIR="$HOME/.aws"

# Run the Docker image, mount the local folder "local" to the container folder "/mnt/core",
# and mount the ~/.aws folder to the /home/core/.aws folder in the container,
# and pass command-line arguments to core.sh
docker run --rm -it \
    -v "$LOCAL_DIR:/mnt/core" \
    -v "$AWS_DIR:/home/core/.aws" \
    core-docker:latest core.sh "$@"

# Print the contents of the file /mnt/core/arguments.txt
cat $LOCAL_DIR/arguments.txt