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

# Create a "dist" folder if it doesn't exist
if (-not (Test-Path -Path .\dist)) {
    New-Item -ItemType Directory -Path .\dist
}

# Remove all files from the dist folder
Remove-Item -Path .\dist\* -Recurse

# Remove the folder docs if it exists
if (Test-Path -Path .\docs) {
    Remove-Item -Path .\docs -Recurse
}

# Get the ..\core-db\dist\*.whl files and put in the dist folder from the current directory
Copy-Item -Path ..\core-framework\dist\*.whl -Destination .\dist
Copy-Item -Path ..\core-db\dist\*.whl -Destination .\dist
Copy-Item -Path ..\core-execute\dist\*.whl -Destination .\dist
Copy-Item -Path ..\core-runner\dist\*.whl -Destination .\dist
Copy-Item -Path ..\core-component-compiler\dist\*.whl -Destination .\dist
Copy-Item -Path ..\core-deployspec-compiler\dist\*.whl -Destination .\dist
Copy-Item -Path ..\core-invoker\dist\*.whl -Destination .\dist
Copy-Item -Path ..\core-api\dist\*.whl -Destination .\dist

# Copy all files recursively from ..\core-docs\build\docs to the current folder
Copy-Item -Path ..\core-docs\build\docs\html -Destination .\docs -Recurse

# Print a message indicating the architecture of the machine
Write-Host "Building Docker image for architecture: $archType"

# Create and use a new builder instance
docker buildx create --use

# Build the Docker image using docker buildx
docker buildx build --platform linux/$archType -t core-docker:latest --build-arg ARCH=$archType --load .

# Print a message indicating the build is complete
Write-Host "Docker image 'core-docker:latest' built successfully."
