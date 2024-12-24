# core-docker

The docker image contains the docker image build repository.

## Building

Run the build command

```bash

./build.sh

```

## Running

Run the Simple Cloud Kit core engine by creating a script to 
help you run it.

core.sh
```bash
#!/bin/zsh

LOCAL_DIR="$(pwd)/local"

# Run the Docker image, mount the local folder "local" to the container folder "/mnt/core", and pass command-line arguments to hello.sh
docker run --rm -it -v "$LOCAL_DIR:/mnt/core" core-docker:latest core.sh "$@"

```

**NOTE:** you can set the LOCAL_DIR to the location you wish to store
files for core automation.  Do not change the mount point /mnt/core

Now that you hve a script, you can run the core container to deploy resources to AWS

```bash

./core.sh -h

./core.sh --client client run upload compile deploy release -p portfolio -a app -b branch -i build

```

## Acknowledgements

Exclusive Information Technology Services - James Barwick &lt;<jbarwick@eits.com.sg>&gt;
