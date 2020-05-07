app = pluck
docker_run = @docker-compose run --rm $(app)

build:
	@touch .ash_history
	@docker-compose build

run:
	$(docker_run) ./lib/pluck.rb

shell: build
	$(docker_run) sh

bundle:
	$(docker_run) bundle

test:
	$(docker_run) bundle exec rspec

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
