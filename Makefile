# import config
configfile=config.env
ifdef cnf
configfile=$(cnf)
endif
include $(configfile)
export $(shell sed 's/=.*//' $(configfile))

# grep the version from the mix file
VERSION=$(shell ./version.sh)
APP_NAME=helm100

# DOCKER TASKS
# Build the container
build:
	docker build -t $(APP_NAME) ./Docker

# Build the container without cache
build-nc:
	docker build --no-cache -t $(APP_NAME) ./Docker

# Run container on port configured in `config.env`
run:
	docker run -i -t --rm --env-file=./config.env -p=$(PORT):$(PORT) --name="$(APP_NAME)" $(APP_NAME)

# Build and run the container
up: build run

stop:
	docker stop $(APP_NAME); docker rm $(APP_NAME)

# Docker tagging
tag: tag-latest tag-version

tag-latest:
	@echo 'create tag latest'
	docker tag $(APP_NAME) $(DOCKER_REPO)/$(APP_NAME):latest

tag-version:
	@echo 'create tag $(VERSION)'
	docker tag $(APP_NAME) $(DOCKER_REPO)/$(APP_NAME):$(VERSION)

# output to version
version:
	@echo $(VERSION)