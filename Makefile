.PHONY: setup test server console lint help

help:
	@echo "Available commands:"
	@echo "  make setup   - Setup project (copy .env, install gems, create DB)"
	@echo "  make test    - Run all tests"
	@echo "  make server  - Start Rails server"
	@echo "  make console - Start Rails console"
	@echo "  make lint    - Run RuboCop"

setup:
	cp -n .env.example .env || true
	bundle install
	yarn install
	rails db:create db:migrate

test:
	rails test

server:
	rails server

console:
	rails console

lint:
	rubocop
