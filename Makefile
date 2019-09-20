# Macros
.BOLD=\x1b[01m
.CLEAR=\x1b[0m

# targets
.DEFAULT_GOAL := default

.PHONY: default
default: help

## This help message
.PHONY: help
help: 
	@printf "Usage: make [target]\n";

	@awk '{ \
			if ($$0 ~ /^.PHONY: [a-zA-Z\-\_0-9]+$$/) { \
				helpCommand = substr($$0, index($$0, ":") + 2); \
				if (helpMessage) { \
					printf "\033[36m%-20s\033[0m %s\n", \
						helpCommand, helpMessage; \
					helpMessage = ""; \
				} \
			} else if ($$0 ~ /^[a-zA-Z\-\_0-9.]+:/) { \
				helpCommand = substr($$0, 0, index($$0, ":")); \
				if (helpMessage) { \
					printf "\033[36m%-20s\033[0m %s\n", \
						helpCommand, helpMessage; \
					helpMessage = ""; \
				} \
			} else if ($$0 ~ /^##/) { \
				if (helpMessage) { \
					helpMessage = helpMessage"\n                     "substr($$0, 3); \
				} else { \
					helpMessage = substr($$0, 3); \
				} \
			} else { \
				if (helpMessage) { \
					print "\n                     "helpMessage"\n" \
				} \
				helpMessage = ""; \
			} \
		}' \
		$(MAKEFILE_LIST)


## -- The most common targets are: --

## Builds, (re)creates, starts, and attaches to containers for a service
.PHONY: start
start:  stop
	@docker container rm php_web || true
	@docker-compose up -d

## Stop and removes containers, networks, volumes, and images created by up
.PHONY: stop
stop: 
	@docker-compose down

## Guess what! :-)
.PHONY: restart
restart: stop start

## Alias of start
.PHONY: up
up: start

## Alias of stop
.PHONY: down
down: stop

## Show container logs
.PHONY: logs
logs:
	@docker container logs php_web --follow

## Interact within the container
.PHONY: interact
interact:
	@docker container exec -it php_web bash

## Inspect the container
.PHONY: inspect
inspect:
	@docker container inspect php_web

## Clean/Pull/Create
.PHONY: full-recreate
full-recreate:
	@docker-compose rm --all
	@docker-compose pull
	@docker-compose build --no-cache
	@docker-compose up -d --force-recreate
