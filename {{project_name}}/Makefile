.PHONY: run

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

TTY_DEVICES_ARGS=$(shell find /dev \( -iname 'ttyACM*' -or -iname 'ttyUSB*' \) -exec printf "--device=%s " {} \;)

run:
	@docker run \
		--rm \
		-v "$(ROOT_DIR):/app" \
		-w "/app" \
		$(TTY_DEVICES_ARGS) \
		-it \
		--entrypoint "/app/scripts/docker_init.sh" \
		'espressif/idf' \
