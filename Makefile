
.DEFAULT_GOAL: build

build:
	go build -o oodie .

docker-build:
	docker build . -t oodie:latest
