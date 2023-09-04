# Detect the operating system
ifeq ($(shell uname),Darwin)
	# macOS
	DATA_PATH := /Users/$(USER)
	ARCH := amd64
else
	# Linux or other OS
	DATA_PATH := /home/$(USER)
	ARCH := $(shell uname -m)
endif

# Translate architecture to values used by Prometheus
ifeq ($(ARCH),x86_64)
	PROM_ARCH := amd64
else ifeq ($(ARCH),aarch64)
	PROM_ARCH := arm64
else
	PROM_ARCH := $(ARCH)
endif

# Export the DATA_PATH and PROM_ARCH so that it's available for docker-compose and Dockerfile
export DATA_PATH
export PROM_ARCH

all : data_folder
	@docker compose -f ./srcs/docker-compose.yml up -d --build

data_folder:
	@mkdir -p $(DATA_PATH)/data/wordpress $(DATA_PATH)/data/mariadb $(DATA_PATH)/data/prometheus

down :
	@docker compose -f ./srcs/docker-compose.yml down

re :
	@docker compose -f ./srcs/docker-compose.yml up -d --build

remove-volumes:
	@if [ -z "$(shell docker volume ls -q)" ]; then \
		echo "No volumes found."; \
	else \
		docker volume rm $(shell docker volume ls -q); \
	fi

remove-images:
	@if [ -z "$(shell docker images -qa)" ]; then \
		echo "No images found."; \
	else \
		docker rmi -f $(shell docker images -qa); \
	fi

clean-network:
	docker network prune -f

clean : down remove-volumes remove-images clean-network

.PHONY: all data_folder down re clean remove-volumes remove-images clean-network
