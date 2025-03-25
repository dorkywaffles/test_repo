#!/bin/bash

# ─────────────────────────────────────────────────────────────
#  Select Deployment Mode (Menu)
# ─────────────────────────────────────────────────────────────
echo -e "\n📌  Select Deployment Mode:"
echo -e "   [1] 🐳 Containerized (Docker)"
echo -e "   [2] 🔨 Uncontainerized (Local dotnet run)"
echo -n "👉  Enter choice (1 or 2): "
read -r choice

case $choice in
    1) DEPLOY_MODE="containerized";;
    2) DEPLOY_MODE="uncontainerized";;
    *) echo "❌  Invalid choice! Exiting..."; exit 1;;
esac

# Array to store background process PIDs
declare -a SERVICE_PIDS

# ─────────────────────────────────────────────────────────────
#  Cleanup function for both containerized and uncontainerized
#  Handles cleanup when script is interrupted stopping either docker
#  containers or local processes (the microservices) based on the
#  deployment mode.
# ─────────────────────────────────────────────────────────────
cleanup() {
    echo -e "\n🚨  Cleaning up processes..."
    
    if [[ "$DEPLOY_MODE" == "containerized" ]]; then
        if [ -n "$BUILD_PID" ]; then
            kill "$BUILD_PID" 2>/dev/null
        fi
        docker-compose down
    else
        # Kill all background service processes
        for pid in "${SERVICE_PIDS[@]}"; do
            if [ -n "$pid" ]; then
                echo "Stopping process $pid..."
                kill "$pid" 2>/dev/null
            fi
        done
    fi
    
    exit 1
}

trap cleanup SIGINT SIGTERM

# ─────────────────────────────────────────────────────────────
#  Docker cleanup
# Remove all images, containers, and volumes Suppress build cache object IDs, but keep total reclaimed space
# Suppress build cache deleted images and object IDs (because its ugly), but keep total reclaimed space
# We are on EBS storage and need to keep it LOW because it costs money so space reclaimed is valueable info
# ─────────────────────────────────────────────────────────────
cleanup_docker() {
    echo -e "\n🧹  Cleaning up Docker resources..."
    docker-compose down
    docker system prune -af --volumes | awk '
        /Deleted Images:/ { skip=1; next }
        /Deleted build cache objects:/ { skip=1; next }
        /^Total reclaimed space:/ {
            skip=0
            print "🧽 " $0
            next
        }
        skip==0 { print }
    '
}

# ─────────────────────────────────────────────────────────────
#  Timer display during builds for feedback
# ─────────────────────────────────────────────────────────────
timer() {
    local start_time=$(date +%s)
    local pid=$1

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

# ─────────────────────────────────────────────────────────────
#  Function to build and run services without containers
# ─────────────────────────────────────────────────────────────
build_uncontainerized() {
    echo -e "\n🔨  Building services locally..."
    
    # Get the project root directory
    PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    
    # Function to build and run the five services
    build_and_run_service() {
        local service_path=$1
        local service_name=$2
        local port=$3
        
        echo -e "\n📦  Building $service_name..."
        cd "$PROJECT_ROOT/$service_path" || {
            echo "❌  Failed to change to directory: $service_path"
            return 1
        }
        
        # Build the service
        if ! dotnet build; then
            echo "❌  Failed to build $service_name"
            return 1
        fi
        
        # Run the service in the background with explicit URL binding and HTTPS disabled
        echo -e "🚀  Starting $service_name on port $port..."
        ASPNETCORE_URLS="http://0.0.0.0:$port" \
        ASPNETCORE_ENVIRONMENT="Development" \
        dotnet run --no-launch-profile &
        local pid=$!
        SERVICE_PIDS+=($pid)
        
        # Check if service started successfully
        sleep 2
        if ! kill -0 $pid 2>/dev/null; then
            echo "❌  Failed to start $service_name"
            return 1
        fi
        
        echo "✅  $service_name started successfully (PID: $pid)"
        cd - > /dev/null || exit 1
    }
    
    # Build and run each service
    local services=(
        "Team-3-BucStop_APIGateway/APIGateway|API Gateway|8081"
        "Team-3-BucStop_Snake/Snake|Snake|8082"
        "Team-3-BucStop_Pong/Pong|Pong|8083"
        "Team-3-BucStop_Tetris/Tetris|Tetris|8084"
        "Bucstop WebApp/BucStop|BucStop WebApp|8080"
    )
    
    for service in "${services[@]}"; do
        IFS="|" read -r path name port <<< "$service"
        if ! build_and_run_service "$path" "$name" "$port"; then
            echo "❌  Deployment failed. Cleaning up..."
            cleanup
        fi
    done
    
    echo -e "\n✅  All services built and started successfully!"
    echo -e "📝  Services are running on:"
    echo -e "   - BucStop WebApp: http://3.232.16.65:8080"
    echo -e "   - API Gateway: http://3.232.16.65:8081"
    echo -e "   - Snake: http://3.232.16.65:8082"
    echo -e "   - Pong: http://3.232.16.65:8083"
    echo -e "   - Tetris: http://3.232.16.65:8084\n"
}

# ─────────────────────────────────────────────────────────────
#  Deployment Magic Starts Here
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

if [[ "$DEPLOY_MODE" == "containerized" ]]; then
    # Clean up Docker resources
    cleanup_docker
    
    # Start the services in containers
    echo -e "\n🐳  Launching microservices..."
    (docker-compose up -d > /dev/null 2>&1) &
    BUILD_PID=$!
    timer $BUILD_PID
    echo -e "✅  All containerized services started successfully!\n"
else
    # Build and run services without containers
    build_uncontainerized
fi