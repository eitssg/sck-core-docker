#!/bin/bash

export SCOPE="tx-"
export CLIENT="eits"
export AUTOMATION_ACCOUNT="154798051514"
export REGION="ap-southeast-1"
export LOCAL_MODE="true"
export USE_S3="true"
export VOLUME=${VOLUME:-/mnt/core}
export LOG_DIR="${VOLUME}\logs"
export CONSOLE="interactive"
export CONSOLE_LOG="false"
export LOG_LEVEL="DEBUG"

# execute the core_cli
core $@

# echo the arguments to a file /mnt/core/arguments.txt
echo $@ > $VOLUME/arguments.txt
