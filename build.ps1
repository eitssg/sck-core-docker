# Get the processor architecture
$architecture = (Get-WmiObject -Class Win32_Processor).Architecture

# Determine if the CPU is ARM or x86
switch ($architecture) {
    0 { $archType = "amd64" }
    1 { $archType = "mips64" }
    2 { $archType = "Alpha Unsupported" }
    3 { $archType = "ppc64le" }
    5 { $archType = "arm64" }
    6 { $archType = "Itanium-based systems Unsupported" }
    9 { $archType = "amd64" }
    default { $archType = "Unknown" }
}

# Print a message indicating the architecture of the machine
Write-Host "Building Docker image for architecture: $archType"

# Create a "dist" folder if it doesn't exist
if (-not (Test-Path -Path .\dist)) {
    New-Item -ItemType Directory -Path .\dist
}

# Remove all files from the dist folder
Remove-Item -Path .\dist\* -Recurse -ProgressAction SilentlyContinue -ErrorAction SilentlyContinue

# Remove the folder docs if it exists
if (Test-Path -Path .\docs) {
    Remove-Item -Path .\docs -Recurse -ProgressAction SilentlyContinue -ErrorAction SilentlyContinue
}

# Copy all files recursively from ..\core-docs\build\docs to the current folder
Copy-Item -Path ..\sck-core-docs\build\docs\html -Destination .\docs -Recurse -ProgressAction SilentlyContinue -ErrorAction SilentlyContinue

# create a vairable with the docker publisher name
$dockerPublisher = "monster-jj.jvj28.com:9092"

# Generate a name of rmy image including the $archType
$packageName = "core-docker-$archType"

# Log in using environment variables
$env:NEXUS_PASSWORD | docker login $dockerPublisher `
    --username $env:NEXUS_USERNAME --password-stdin

# Create and use a new builder instance
docker buildx create --use

docker pull monster-jj.jvj28.com:9093/core-docker-base-${archType}:latest

# Build the Docker image using docker buildx
docker buildx build `
   --platform linux/$archType `
   --build-arg ARCH=$archType `
   --build-arg NEXUS_SERVER=$env:NEXUS_SERVER `
   --build-arg PIP_INDEX_URL=$env:PIP_INDEX_URL `
   -t ${dockerPublisher}/${packageName}:latest `
   --load .

# Pull the build image to ensure it is available locally
Write-Host "Pushing image to ${dockerPublisher}..."
docker push ${dockerPublisher}/${packageName}:latest

# Print a message indicating the build is complete
Write-Host "Docker image '${packageName}:latest' built successfully."
