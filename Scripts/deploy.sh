#!/bin/bash


# Timer that will display the time the docker build takes
timer() {
    local start_time=$(date +%s)
    local pid=$docker_pid

    echo -n "⏳  Building services... Elapsed time: 00:00"

    while kill -0 "$pid" 2>/dev/null; do
        sleep 1
        local current_time=$(date +%s)
        local elapsed=$((current_time - start_time))
        local minutes=$((elapsed / 60))
        local seconds=$((elapsed % 60))
        printf "\r⏳  Building services... Elapsed time: %02d:%02d" "$minutes" "$seconds"
    done

    echo -e "\r✅  Services built in $minutes minutes and $seconds seconds.    "
}


# Exposing trap that can reach the backgrounded & detached docker-compose service
cleanup_on_exit() {
    echo -e "\n🚨  Deployment interrupted. Cleaning up..."
    if [ -n "$docker_pid" ]; then
        kill "$docker_pid" 2>/dev/null
    fi
    exit 1
}

trap cleanup_on_exit SIGINT

# Function to clean up Docker resources
cleanup_docker() {
    echo -e "\n🧹  Cleaning up Docker resources..."
    
    # Stop and remove all containers
    docker-compose down
    
    # Remove all images, containers, and volumes Suppress build cache object IDs, but keep total reclaimed space
    docker system prune -af --volumes | awk '
        # Supress build cache deleted images and object IDs (because its ugly), but keep total reclaimed space
        # We are on EBS storage and need to keep it LOW because it costs money so space reclaimed is valueable info
        /Deleted Images:/ { skip=1; next }
        /Deleted build cache objects:/ { skip=1; next }
        /^Total reclaimed space:/ {
        skip=0
        print "    🧽  " $0
        next
        }
        skip==0 { print }
    '
}

# ─────────────────────────────────────────────────────────────
#    Deployment Starts Here
# ─────────────────────────────────────────────────────────────
echo "🚀  Starting deployment process..."

# Pull latest repo updates
echo "🔄  Checking repository status..."
pull_output=$(git pull)
if [[ "$pull_output" == "Already up to date." ]]; then
    echo "✅  Repo is already up to date."
else
    echo "$pull_output"
fi

# Clean up Docker resources
cleanup_docker

# Start the services
echo -e "\n🐳  Launching microservices..."
(docker-compose up -d > /dev/null 2>&1) &
docker_pid=$!
timer
echo -e "✅  All services started successfully!\n"