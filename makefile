################ Main Targets ################
init: init-submodules update-submodule start

start:
	@docker compose up --build -d

stop:
	@docker compose down

################ Utility Targets ################
init-submodules:
	@git submodule update --init --recursive

update-submodule:
	@git submodule update --remote --merge --recursive

status:
	@docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"

reload: reload-nginx

reload-nginx:
	@docker exec -it nginx nginx -s reload

reload-postgres:
	@docker compose stop postgres
	@docker compose rm -f postgres
	@docker volume rm $$(docker volume ls -q | grep postgres || true)
	@docker compose up -d postgres
	@printf $(COLOR) "Postgres fully reset."

rebuild-all: rebuild-client rebuild-healthcare

rebuild-client:
	@cd ./Client-Interface && npm i && npm run build
	@printf $(COLOR) "Static files rebuilt successfully."
	@docker exec -it nginx nginx -s reload
	@printf $(LIME) "Nginx reloaded successfully."
	@cd ..

rebuild-healthcare:
	@cd ./healthcare-interface && npm i && npm run build
	@printf $(COLOR) "healthcare-interface rebuilt successfully."
	@docker exec -it nginx nginx -s reload
	@printf $(LIME) "Nginx reloaded successfully."
	@cd ..

################ Colors and Variables ################
COLOR := "\e[1;36m%s\e[0m\n"
RED :=   "\e[1;31m%s\e[0m\n"
LIME := "\e[1;92m%s\e[0m\n"
PARENT_NAME := $(notdir $(abspath $(dir $(lastword $(MAKEFILE_LIST)))))
