VERSION=v1

build:
	docker build -t radar:latest --build-arg VERSION=${VERSION} .

run:
	docker run --rm -p 8080:80 -e SERVER_NAMES="localhost 127.0.0.1" radar:latest