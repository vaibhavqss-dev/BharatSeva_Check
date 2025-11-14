COLOR := "\e[1;36m%s\e[0m\n"
RED :=   "\e[1;31m%s\e[0m\n"

################ Main Targets ################
start:
	@docker compose up --build -d

stop:
	@docker compose down

init-submodules:
	@git submodule update --init --recursive

restart: stop start

rm-vol:
	@docker volume prune -f

rm-img:
	@docker compose down --rmi all