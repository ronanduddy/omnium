.PHONY: build run shell bundle test guard lint irb stop rmi reset

app = pluck
docker_run = @docker-compose run --rm $(app)

build:
	@touch .ash_history
	@docker-compose build $(app)

run:
	$(docker_run) ./bin/pluck $(file)

shell: build
	$(docker_run) sh

bundle:
	$(docker_run) bundle

test:
	@docker-compose build test
	@docker-compose run --rm test

guard:
	$(docker_run) bundle exec guard -c

lint:
	$(docker_run) rubocop -a

irb:
	$(docker_run) irb

stop:
	@docker-compose down

rmi:
	@docker image rm $(app) || true

reset: stop rmi build
