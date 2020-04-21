#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`
REPO=451004051173.dkr.ecr.us-east-1.amazonaws.com/udacity-capstone

# Authenticate & tag
echo "ECR URI and Image: $REPO"

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $REPO

# Build the image
docker build -t udacity-capstone .

# Tag the image
docker tag udacity-capstone:latest $REPO:latest

# Push image to ECR
docker push $REPO:latest