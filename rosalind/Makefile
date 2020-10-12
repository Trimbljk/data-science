include set_env.mk

## help                                        : Show this help message
.PHONY : help
help : Makefile
	@echo ""
	@echo " Welcome to the practice_problems repository!"
	@echo ""
	@echo " make..."
	@sed -n 's/^##//p' $<
	@echo ""

GIT_MASTER_HEAD_SHA:=$(shell git rev-parse --short=12 --verify HEAD)

## build-image                                 : Build the docker image for notebooks
build-image: Dockerfile
	docker build -t agbiome/practice_problems . \
	&& touch $@

## tag-image                                   : Tag docker image
.PHONY : tag-image
tag-image: build-image
	docker tag agbiome/practice_problems:latest agbiome/practice_problems:$(GIT_MASTER_HEAD_SHA)

## push-image                                  : Push docker image
.PHONY : push-image
push-image: tag-image
	@docker push agbiome/practice_problems

TEST:=$(shell docker info | grep "Username")

## check-docker-login                          : Check if user logged in to docker
.PHONY : check-docker-login
check-docker-login:
	@if [ "$(TEST)" ]; then echo "Logged in to dockerhub."; else echo "Please log in to dockerhub."; exit 1; fi

## git-init                                    : Initialize git repo
.PHONY : git-init
git-init:
	@curl --user ${GITHUB_TOKEN}:x-oauth-basic --request POST \
		--data '{"name":"practice_problems","private":true,"gitignore_template":"Python"}' \
		https://api.github.com/orgs/agbiome/repos && \
	git init && \
	git remote add origin git@github.com:AgBiome/practice_problems.git && \
	git remote -v && \
	git pull origin master && \
	git add . && \
	git commit -m "start project" && \
	git push -u origin master && \
	echo "data\n" | cat - .gitignore > .gitignore

## science                                     : Start project
science: check-docker-login build-image git-init

## run-notebook                                : Run the notebook server
.PHONY: run-notebook
run-notebook: build-image stop-notebook
	DATA_DIR=$(DATA_DIR) ./jupyter-lab.sh

## stop-notebook                               : Stop the notebook server
.PHONY: stop-notebook
stop-notebook:
	docker stop practice_problems_$(HOSTNAME)_$(UID) || echo "already stopped"
	sleep 1

## get-url                                     : Get the URL of the notebook server
.PHONY: get-url
get-url:
	@docker exec --user jovyan -it practice_problems_$(HOSTNAME)_$(UID) jupyter notebook list \
	| sed -E "s/(0.0.0.0|localhost)/$(HOSTNAME)/"
