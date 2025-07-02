#!/bin/bash

set -e

install_docker() {
    echo "Installing Docker and docker-compose..."
    sudo apt update
    sudo apt install -y docker.io docker-compose
    sudo usermod -aG docker "$USER"
}

build_images() {
    echo "Building Docker images..."
    docker-compose build
}

start_compose() {
    echo "Starting Docker containers..."
    docker-compose up
}

usage() {
    echo "Usage: $0 [--install] [--build] [--up]"
}

if [ $# -eq 0 ]; then
    read -p "Install Docker and docker-compose? [y/N] " ans
    if [[ $ans =~ ^[Yy]$ ]]; then
        install_docker
    fi

    read -p "Build Docker images? [y/N] " ans
    if [[ $ans =~ ^[Yy]$ ]]; then
        build_images
    fi

    read -p "Run docker-compose up? [y/N] " ans
    if [[ $ans =~ ^[Yy]$ ]]; then
        start_compose
    fi
else
    for arg in "$@"; do
        case $arg in
            --install)
                install_docker
                ;;
            --build)
                build_images
                ;;
            --up)
                start_compose
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                usage
                exit 1
                ;;
        esac
    done
fi

