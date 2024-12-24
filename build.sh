#!/bin/zsh

# Navigate to the directory containing the Dockerfile
cd /Users/jbarwick/Development/simple-cloud-kit/core-docker

# Build the Docker image
docker build -t core-docker:latest .

# Print a message indicating the build is complete
echo "Docker image 'core-docker:latest' built successfully."