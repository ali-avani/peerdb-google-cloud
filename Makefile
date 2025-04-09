# Paths
COMPOSE_DIR=peerdb-base
COMPOSE_FILES=-f $(COMPOSE_DIR)/docker-compose.yml -f docker-compose.gc.yml

# Docker Compose Commands
up:
	docker compose $(COMPOSE_FILES) --env-file .env up -d

down:
	docker compose $(COMPOSE_FILES) --env-file .env down

restart: down up

logs:
	docker compose $(COMPOSE_FILES) --env-file .env logs -f

ps:
	docker compose $(COMPOSE_FILES) --env-file .env ps

build:
	docker compose $(COMPOSE_FILES) --env-file .env build

stop:
	docker compose $(COMPOSE_FILES) --env-file .env stop

start:
	docker compose $(COMPOSE_FILES) --env-file .env start

config:
	docker compose $(COMPOSE_FILES) --env-file .env config

nuke:
	docker compose $(COMPOSE_FILES) --env-file .env down -v --remove-orphans
