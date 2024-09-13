#!/bin/bash
# Launches a python 3.11 docker to test the setup-environment script
if ! command -v docker &> /dev/null
then
    echo "Docker is not installed. Please install Docker and try again."
    exit 1
fi

FORCE_REBUILD=false
if [ "$1" = "--force-rebuild" ]; then
    FORCE_REBUILD=true
fi

# Build the Docker image
if ! docker image inspect pearai-test-setup &> /dev/null || [ "$FORCE_REBUILD" = true ]; then
    echo "Building Docker image 'pearai-test-setup'..."
    docker build -t pearai-test-setup \
        --build-arg CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD) \
		--no-cache \
        -f Dockerfile .
else
    echo "Docker image 'pearai-test-setup' already exists. Skipping build step."
fi

docker run -it --rm \
  --name pearai-test-setup \
  -w /workspace \
  -e CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD) \
  -v "$(pwd)/setup-prereqs.sh:/workspace/setup-prereqs.sh" \
  pearai-test-setup \
  /bin/bash -c "/workspace/setup-prereqs.sh"
