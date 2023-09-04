# Detect the operating system and set DATA_PATH accordingly
ifeq ($(shell uname),Darwin)
	# macOS
	DATA_PATH := /Users/$(USER)
else
	# Linux or other OS
	DATA_PATH := /home/$(USER)
endif

# Export the DATA_PATH so that it's available for docker-compose
export DATA_PATH

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
