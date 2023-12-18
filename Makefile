up:
	@docker compose -f compose.cpu.yaml up -d
	@echo "localhost:8888"
build:
	@docker compose -f compose.cpu.yaml build
down:
	@docker compose -f compose.cpu.yaml down
exec:
	@docker compose -f compose.cpu.yaml exec notebook bash

up-gpu:
	@docker compose -f compose.gpu.yaml up -d
build-gpu:
	@docker compose -f compose.gpu.yaml build
down-gpu:
	@docker compose -f compose.gpu.yaml down
exec-gpu:
	@docker compose -f compose.gpu.yaml exec notebook bash
