# Use an ARM-compatible Linux image
FROM arm64v8/ubuntu:latest

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Install dependencies
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv unzip curl less groff jq && \
    apt-get clean

# Install AWS CLI 2.0
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
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

# Switch back to root user to copy and change permissions of core.sh
USER root

# Add core-internal.sh to the home folder as core.sh
COPY core-internal.sh /home/core/core.sh

# Make core.sh executable
RUN chmod +x /home/core/core.sh

# Add the AWS CLI to the PATH
RUN echo 'export PATH=$PATH:/usr/local/bin/aws' >> /home/core/.bashrc

# Switch back to the core user
USER core

# Add the home folder to the PATH
RUN echo 'export PATH=$PATH:/home/core' >> /home/core/.bashrc

# Set the entrypoint
ENTRYPOINT ["/bin/bash"]