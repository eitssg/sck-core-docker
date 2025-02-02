# Get the current directory
$currentDir = Get-Location

$LOCAL_DIR = "$currentDir/local"
$AWS_DIR = "$Env:USERPROFILE/.aws"

# Run the Docker image, mount the local folder "local" to the container folder "/mnt/core",
# and mount the ~/.aws folder to the /home/core/.aws folder in the container,
# and pass command-line arguments to core.sh
docker run --rm -it `
    -v "${LOCAL_DIR}:/mnt/core" `
    -v "${AWS_DIR}:/home/core/.aws" `
    -e SCOPE="tx-" `
    -e CLIENT="eits" `
    -e AUTOMATION_ACCOUNT="154798051514" `
    -e REGION="ap-southeast-1" `
    -e LOCAL_MODE="true" `
    -e USE_S3="true" `
    -e VOLUME="/mnt/core" `
    -e LOG_DIR="/mnt/core/logs" `
    -e CONSOLE="interactive" `
    -e CONSOLE_LOG="false" `
    -e LOG_LEVEL="DEBUG" `
    core-docker:latest core $args

