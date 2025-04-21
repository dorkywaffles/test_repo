#!/bin/bash

create_snapshot() {
    echo "Creating snapshot..."
    curl -X POST http://localhost:8080/snapshots/create -d "description=Automated snapshot before shutdown"
}

create_snapshot

echo "Shutting down containers..."
docker-compose down