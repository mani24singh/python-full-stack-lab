# Docker & Docker Compose Quick Reference

## Dockerfile Template

``` dockerfile
# Base image
FROM node:18-alpine
WORKDIR /app
ENV NODE_ENV=production
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3000
USER node
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1
CMD ["node", "server.js"]
```

## docker-compose Template

``` yaml
version: '3.8'  # Recommended version
services:
  app:
    build: .
    container_name: myapp
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - DATABASE_URL=${DATABASE_URL}
    env_file:
      - .env
    volumes:
      - ./src:/app/src
      - app_data:/app/data
    depends_on:
      - db
      - redis
    networks:
      - backend
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
  db:
    image: postgres:15-alpine
    container_name: postgres_db
    environment:
      POSTGRES_USER: ${DB_USER}
      POSTGRES_PASSWORD: ${DB_PASSWORD}
      POSTGRES_DB: ${DB_NAME}
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    networks:
      - backend
  redis:
    image: redis:7-alpine
    container_name: redis_cache
    command: redis-server --appendonly yes
    volumes:
      - redis_data:/data
    networks:
      - backend
  nginx:
    image: nginx:alpine
    container_name: nginx_proxy
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./certs:/etc/nginx/certs
    depends_on:
      - app
    networks:
      - backend
volumes:
  postgres_data:
  redis_data:
  app_data:
networks:
  backend:
    driver: bridge
```

## Key Sections Explained
- Dockerfile Directives:
    - FROM - Base image
    - WORKDIR - Working directory inside container
    - COPY/ADD - Copy files from host to container
    - RUN - Execute commands during build
    - CMD/ENTRYPOINT - Default command when container starts
    - EXPOSE - Document which ports the app uses
    - ENV - Set environment variables
    - USER - Switch to non-root user (security)

- Compose Service Options:
    - build - Build from Dockerfile
    - image - Use pre-built image
    - ports - Port mapping (host:container)
    - volumes - Persistent/bind mounts
    - environment - Set env variables
    - depends_on - Service dependencies
    - networks - Network connections
    - restart - Restart policy

## Architecture Visualization
    Docker Compose Architecture (Conceptual)

    [ User ]
        |
        v
    [ Nginx ]
        |
        v
    [ App Container ] -----> [ Redis ]
        |
        v
    [ Postgres DB ]

    Volumes persist data outside container lifecycle.
    Networks allow isolated service communication.


## Essential Commands Cheat She
``` bash
docker-compose up -d
docker compose up -d
docker-compose down
docker-compose down -v
docker-compose logs -f
docker-compose exec service_name sh
docker-compose build --no-cache
docker-compose ps
docker-compose images
```

## Minimal Example
``` yaml
    # docker-compose.yml (simple)
    version: '3.8'

    services:
      web:
        build: .
        ports:
          - "8080:80"
        volumes:
          - ./html:/usr/share/nginx/html

      db:
        image: mysql:8
        environment:
          MYSQL_ROOT_PASSWORD: rootpass
  ```

``` dockerfile
    # Dockerfile (simple)
    FROM nginx:alpine
    COPY index.html /usr/share/nginx/html
    EXPOSE 80
```

## Pro Tips
1. Use `.dockerignore`
2. Use named volumes
3. restart: unless-stopped
4. Env variables
5. Order Dockerfile commands
6. Multi-stage builds
7. Use version tags
