#!/bin/bash

# Get the latest version tag from the GitHub API
VERSION=$(curl -s https://api.github.com/repos/restic/restic/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')

# Check if the VERSION variable is empty
if [ -z "$VERSION" ]; then
    echo "Failed to retrieve the latest version. Exiting."
    exit 1
fi

# Strip the leading "v" from the VERSION tag if it exists
VERSION_NUMBER=${VERSION#v}

# Define the URL to download the Restic binary
URL="https://github.com/restic/restic/releases/download/${VERSION}/restic_${VERSION_NUMBER}_linux_amd64.bz2"

# Temporarily change to /tmp directory for downloading
cd /tmp

# Download the Restic binary
wget -q ${URL}

# Check if the download was successful
if [ $? -ne 0 ]; then
    echo "Failed to download Restic version ${VERSION}. Exiting."
    exit 1
fi

# Extract the downloaded file
bunzip2 restic_${VERSION_NUMBER}_linux_amd64.bz2

# Check if bunzip2 succeeded
if [ $? -ne 0 ]; then
    echo "Failed to extract Restic version ${VERSION}. Exiting."
    exit 1
fi

# Make the Restic binary executable
chmod +x restic_${VERSION_NUMBER}_linux_amd64

# Move the Restic binary to /usr/local/bin/ with sudo
sudo mv restic_${VERSION_NUMBER}_linux_amd64 /usr/local/bin/restic

# Clean up downloaded files
rm -f restic_${VERSION_NUMBER}_linux_amd64.bz2

# Verify the installed Restic version
/usr/local/bin/restic version
