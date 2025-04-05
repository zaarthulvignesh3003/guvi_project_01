#!/bin/bash

# Variables
DOCKER_USERNAME="vignesh221193"  # 👈 Your Docker Hub username
REPO_NAME="react-static-site"
TAG="prod"
CONTAINER_NAME="react-static-container"
PORT=8080

# Full image name
IMAGE_NAME="$DOCKER_USERNAME/$REPO_NAME:$TAG"

echo "🔁 Stopping and removing old container (if any)..."
docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

echo "📥 Pulling latest image: $IMAGE_NAME"
docker pull $IMAGE_NAME

echo "🚀 Running new container..."
docker run -d \
  --name $CONTAINER_NAME \
  -p $PORT:80 \
  $IMAGE_NAME

echo "✅ Deployment done! App running at: http://localhost:$PORT"
