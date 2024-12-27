# Define the build argument
ARG ARCH

FROM ubuntu:latest AS os

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Install dependencies
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv unzip curl less groff jq && \
    apt-get clean

# Install AWS CLI 2.0 x86 or aarch64
ARG ARCH
RUN if [ "$ARCH" = "amd64" ]; then \
        ARCH1="x86_64"; \
    elif [ "$ARCH" = "arm64" ]; then \
        ARCH1="aarch64"; \
    else \
        echo "Unsupported architecture: $ARCH"; exit 1; \
    fi && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-${ARCH1}.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

# Create a new user called "core" with UID 1002 and a home directory
RUN useradd -m -u 1002 core

# Switch to the new user
USER core

# Set the home directory
WORKDIR /home/core

# Specify the default shell
SHELL ["/bin/bash", "-c"]

# Create a virtual environment in a hidden folder
RUN python3 -m venv /home/core/.venv

# Activate the virtual environment and install Poetry
RUN source /home/core/.venv/bin/activate && python -m pip install --upgrade pip
RUN source /home/core/.venv/bin/activate && pip install poetry poetry-dynamic-versioning

# Ensure the virtual environment is activated for the core user
RUN echo "source /home/core/.venv/bin/activate" >> /home/core/.bashrc

FROM os AS base

USER core

# Add core-internal.sh to the home folder as core.sh
COPY core-internal.sh /home/core/core.sh

# Switch users so we can modify the permissions without sudo
USER root

# Make core.sh executable
RUN chmod +x /home/core/core.sh

# Switch back to the core user
USER core

# Copy the *whl file from ../core-db/dist to the folder /home/core/dist
COPY dist/*.whl /home/core/dist/

# Copy the docs folder from the current folder to /home/core/docs
COPY docs /home/core/docs

# Use PIP in the virtual environment to install all the wheel files in the /home/core/dist folder
# RUN source /home/core/.venv/bin/activate && pip install /home/core/dist/*.whl
RUN source /home/core/.venv/bin/activate && pip freeze > requirements.txt

# Add the AWS CLI to the PATH
RUN echo 'export PATH=$PATH:/usr/local/bin/aws' >> /home/core/.bashrc

# Add the home folder to the PATH
RUN echo 'export PATH=$PATH:/home/core' >> /home/core/.bashrc

# Set the entrypoint
ENTRYPOINT ["/bin/bash"]
