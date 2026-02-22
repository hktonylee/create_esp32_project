.PHONY: run

ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

TTY_DEVICES_ARGS=$(shell find /dev \( -iname 'ttyACM*' -or -iname 'ttyUSB*' \) -exec printf "--device=%s " {} \;)

DOCKER_IMAGE := espressif/idf

CONTAINER_ID := $(shell docker ps -q --filter "ancestor=$(DOCKER_IMAGE)" --latest)

run:
	@docker run \
		--rm \
		-v "$(ROOT_DIR):/app" \
		-w "/app" \
		$(TTY_DEVICES_ARGS) \
		-it \
		--entrypoint "/app/scripts/docker_init.sh" \
		$(DOCKER_IMAGE) \

install-minicom:
	@docker exec -it "$(CONTAINER_ID)" apt-get update
	@docker exec -it "$(CONTAINER_ID)" apt-get install -y minicom

connect-minicom:
	@docker exec -it "$(CONTAINER_ID)" minicom -D /dev/ttyUSB0 -b 115200


