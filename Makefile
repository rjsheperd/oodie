
.DEFAULT_GOAL: build

RESIN_MACHINE_NAME := raspberrypi3

build:
	go build -o oodie .

detemplate:
	sh detemplate.sh $(RESIN_MACHINE_NAME)

docker-build: detemplate
	docker build -f Dockerfile.$(RESIN_MACHINE_NAME) -t oodie:$(RESIN_MACHINE_NAME)-latest .

docker-run: docker-build
	docker run -it oodie:$(RESIN_MACHINE_NAME)-latest
