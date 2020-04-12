app = pluck
docker_run = @docker-compose run --rm $(app)

build:
	@docker-compose build

run:
	$(docker_run) ./lib/interpreter.rb

shell:
	$(docker_run) sh

bundle:
	$(docker_run) bundle

test:
	$(docker_run) bundle exec rspec

guard:
	$(docker_run) bundle exec guard

lint:
	$(docker_run) rubocop -a

clear:
	@docker-compose down

rmi:
	@docker image rm $(app) || true

reset: clear rmi build
