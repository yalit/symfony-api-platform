help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

## —— Install & deploy ————————————————————————————————————————————————————————————
composer: ## Trigger the installation of PHP dependencies
	composer install

pnpm: ## Trigger the installation of js dependencies
	pnpm install

install: ## Install the dependencies
	make composer
	make pnpm

deploy: install ## Trigger the step for new deployment in PROD
	make assets
	make encore
	make cc env=prod

deploy-dev: install ## Trigger the step for new deployment in dev
	make assets-symlink
	make encore-dev
	make cc env=dev

assets: ## Trigger the install of assets for PROD
	bin/console assets:install

assets-symlink: ## Trigger the install of assets for DEV
	bin/console assets:install --symlink

encore: ## Trigger the build of the project assets for PROD
	pnpm encore prod

encore-dev: ## Trigger the build of the project assets for DEV
	pnpm encore dev

cc: ## Trigger the clear of the cache @@var : env
	bin/console c:c --env=$(env)

## —— Database ————————————————————————————————————————————————————————————
db-init: ## Trigger the creation of the db
	bin/console d:s:c

db-migrations: ## Trigger the generation of migrations
	bin/console make:migration

db-migrate: ## Trigger the actual db migrations
	bin/console d:m:m

db-update: ## Trigger the update of the db without migrations
	bin/console d:s:u --force

db-fixtures: ## Trigger the load of the fixtures
	bin/console d:f:l
