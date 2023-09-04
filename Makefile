all : data_folder
	@docker compose -f ./srcs/docker-compose.yml up -d --build

data_folder:
	@mkdir -p /Users/nnakarac/data/wordpress /Users/nnakarac/data/mariadb /Users/nnakarac/data/prometheus

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
