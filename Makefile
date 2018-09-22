
.DEFAULT_GOAL: build

build:
	docker build . -t oodie:latest
