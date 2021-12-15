.DEFAULT_GOAL=help

lint: lint-shell lint-dockerfile #? quick pre-build validations
lint-dockerfile:
	docker run --rm -tv $(PWD):/app hadolint/hadolint:latest-debian \
		sh -c "find . -name Dockerfile | xargs -L1 hadolint"
lint-shell:
	docker run --rm -tv "$(PWD):/mnt" koalaman/shellcheck:v0.5.0 \
        --color=always --shell=bash --exclude=SC2016 \
        **/*.sh

test: #? test all images
	$(MAKE) PHP_VERSION=7.4 IMAGE_VARIANT=cli OS_VERSION=alpine test-single
	$(MAKE) PHP_VERSION=7.4 IMAGE_VARIANT=fpm OS_VERSION=alpine test-single
	$(MAKE) PHP_VERSION=7.3 IMAGE_VARIANT=cli OS_VERSION=alpine test-single
	$(MAKE) PHP_VERSION=7.3 IMAGE_VARIANT=fpm OS_VERSION=alpine test-single
	$(MAKE) PHP_VERSION=7.2 IMAGE_VARIANT=cli OS_VERSION=alpine test-single
	$(MAKE) PHP_VERSION=7.2 IMAGE_VARIANT=fpm OS_VERSION=alpine test-single
	$(MAKE) PHP_VERSION=7.1 IMAGE_VARIANT=cli OS_VERSION=alpine test-single
	$(MAKE) PHP_VERSION=7.1 IMAGE_VARIANT=fpm OS_VERSION=alpine test-single
	$(MAKE) PHP_VERSION=7.0 IMAGE_VARIANT=cli OS_VERSION=alpine test-single
	$(MAKE) PHP_VERSION=7.0 IMAGE_VARIANT=fpm OS_VERSION=alpine test-single
	$(MAKE) PHP_VERSION=5.6 IMAGE_VARIANT=cli OS_VERSION=alpine test-single
test-single:
	docker pull -q php:$(PHP_VERSION)-$(IMAGE_VARIANT)-$(OS_VERSION)
	DOCKERFILE_DIR="src/$(PHP_VERSION)/$(OS_VERSION)/$(IMAGE_VARIANT)" && \
		docker-compose -f $$DOCKERFILE_DIR/docker-compose.test.yml build && \
		docker-compose -f $$DOCKERFILE_DIR/docker-compose.test.yml run --rm sut


help: #? help me
	@printf "\e[34;01mAvailable targets\033[0m\n"
	@awk '/^@?[a-zA-Z\-_0-9]+:/ { \
		nb = sub( /^#\? /, "", helpMsg ); \
		if(nb == 0) { \
			helpMsg = $$0; \
			nb = sub( /^[^:]*:.* #\? /, "", helpMsg ); \
		} \
		if (nb) \
			printf "\033[1;31m%-" width "s\033[0m %s\n", $$1, helpMsg; \
	} \
	{ helpMsg = $$0 }' \
	$(MAKEFILE_LIST) | column -ts:
