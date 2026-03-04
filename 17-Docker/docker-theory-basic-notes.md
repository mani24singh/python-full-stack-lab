
# Basic Docker Notes and Commands

## Important system requirements to install docker
- WSL 2 backend (Windows 11 or with 64-bit or Higher)
- Hardware (64-bit processor + 4gb RAM + BIOS-level hardware vitualization support must be enabled in BIOS Settings)
- Hyper-V backend and Windows containers - must be enabled (Windows features > Hyper-V)

## Docker Hub: 
- Docker Hub is a cloud-based repository service where developers and teams can push (upload) and pull (download) Docker container images anytime via the internet. 
- To push your image to docker hub
    - login to your docker hub account 
        - command: docker login > enter your creds
    - build docker image using naming convention: 
        - username/<docker-image>
    - docker push <image>:latest


## Basic Docker Commands:
- `docker --version` : Check docker version
- `docker pull <image_name>` : Pull an image from Docker Hub
- `docker images` : List all downloaded images
- `docker rmi <image_id>` : Remove a specific image
- `docker rmi -f <image_id>` : Remove a specific image forcefully or we can also use `docker image rm <image_id>`
- `docker image rm -f <image_name>` - Remove a specific docker image forcefully
- `docker run <image_name>` : Run a container from an image
- `docker run -d -p 80:80 <image>`: Run a container from an image in detached mode (in the background) and mapping the port 80 of the host to port 80 in the container
- `docker ps` : List running containers
- `docker ps -a` : List all containers (running and stopped)
- `docker stop <container_id>` : Stop a running container
- `docker rm <container_id>` : Remove a stopped container
- `docker exec -it <container_id> /bin/bash` : Access a running container's shell
- `docker build -t <image_name> .` : Build an image from a Dockerfile in the current directory
- `docker-compose up` : Start services defined in a docker-compose.yml file
- `docker-compose down` : Stop and remove services defined in a docker-compose.yml file
- `docker tag <image_name> <tag>`: Rename or add a tag to your docker image


## Docker Compose Overview
- Docker Compose is a tool for defining and running multi-container Docker applications. You use a YAML file (`docker-compose.yml`) to configure your application's services, networks, and volumes, then run everything with a single command.
- Key Features:
    - Manages multi-container applications
    - Simplified container orchestration
    - Service dependencies and startup order
    - Environment variable management
    - Volume and network configuration

- Essential Docker Compose Commands
    1. Basic Commands: 
        - `docker-compose up`: Create and start containers
        - `docker-compose up -d`: Start in detached background mode
        - `docker-compose down`: Stop and remove containers, networks
        - `docker-compose down -v`: Also remove volumes
        - `docker-compose ps`: List containers
        - `docker-compose logs`: View output from containers
        - `docker-compose logs -f`: Follow log output
        
    2. Management Commands:

        - `docker-compose start`: Start existing containers
        - `docker-compose stop`: Stop containers without removing
        - `docker-compose restart`: Restart containers
        - `docker-compose pause`: Pause running containers
        - `docker-compose unpause`: Unpause paused containers
        - `docker-compose kill`: Force stop containers
        - `docker-compose rm`: Remove stopped containers

    3. Build & Configuration:
        - `docker-compose build`: Build or rebuild services
        - `docker-compose pull`: Pull service images
        - `docker-compose config`: Validate and view configuration
        - `docker-compose config --services`: List services
        - `docker-compose images`: List images used by services

    4. Execution Commands:
        - `docker-compose exec <service> <cmd>`: Execute command in running container
        - `docker-compose run <service> <cmd>`: Run one-off command in new container
        - `docker-compose run --rm <service> <cmd>`: Run and remove container after

    5. Scale & Monitoring
        - `docker-compose top`: Display running processes
        - `docker-compose port <service> <port>`: Print public port for port binding
        - `docker-compose scale <service>=<num>`: Scale services (deprecated in v3)

    6. Utility Commands
        - `docker-compose events`: View real-time container events
        - `docker-compose version`: Show version information
        - `docker-compose help`: Get help on commands

- Basic Workflow Example:

```bash
    # 1. Create docker-compose.yml file
    # 2. Start services
    docker-compose up -d

    # 3. Check status
    docker-compose ps

    # 4. View logs
    docker-compose logs -f

    # 5. Execute command in a service
    docker-compose exec web bash

    # 6. Stop services
    docker-compose down
```

- Important Options
    - `-f, --file`: Specify compose file (default: docker-compose.yml)
    - `-p, --project-name`: Specify project name (default: directory name)
    - `--env-file`: Specify environment file
    `--profile`: Specify profile to enable

- Version Note
    - **Docker Compose V2** (integrated into Docker CLI): Use `docker compose` (no hyphen)
    - **Docker Compose V1**: Use `docker-compose` (with hyphen)
    - Most modern installations use V2, where commands become `docker compose up` instead of `docker-compose up`.


