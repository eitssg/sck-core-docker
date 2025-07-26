# Define the build argument
ARG ARCH=amd64

FROM monster-jj.jvj28.com:9093/core-docker-base-${ARCH}:latest

# Set environment variables
ENV PYTHONUNBUFFERED=1

COPY nginx/portal.conf /etc/nginx/conf.d/portal.conf

# Create the UI directory and set permissions for the nginx user to read it
RUN mkdir -p /home/core/ui
RUN chmod 755 /home/core
RUN chmod -R 755 /home/core/ui

RUN echo "<html><body><h1>Welcome to the SCK Core Portal</h1></body></html>" > /home/core/ui/index.html

# Enable the nginx service boot at startup
RUN systemctl enable nginx

COPY gitlab/config.toml /etc/gitlab-runner/config.toml

USER core

# Add core-internal.sh to the home folder as core.sh
COPY core-internal.sh /home/core/core.sh

# Switch users so we can modify the permissions without sudo
USER root

# Make core.sh executable
RUN chmod +x /home/core/core.sh

# Switch back to the core user
USER core

# Copy the docs folder from the current folder to /home/core/docs
COPY docs /home/core/docs

# Add the AWS CLI to the PATH
RUN echo 'export PATH=$PATH:/usr/local/bin/aws' >> /home/core/.bashrc

# Add the home folder to the PATH
RUN echo 'export PATH=$PATH:/home/core' >> /home/core/.bashrc

# create a folder called 'lambda' in the home directory
RUN mkdir -p /home/core/lambda

# copy the contents of the lambda folder to the lambda folder in the home directory
COPY lambda/* /home/core/lambda/

# RUN source /home/core/.venv/bin/activate && PIP_INDEX_URL=${PIP_INDEX_URL} pip install sck-core-cli

# Set the entrypoint and pass parameters
ENTRYPOINT ["/bin/bash", "-c", "source /home/core/.venv/bin/activate && exec \"$@\"", "--"]

# Default command to run if no parameters are passed
CMD ["/bin/bash"]
