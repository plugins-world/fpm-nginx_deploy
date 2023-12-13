.PHONY: build run

build:
	docker build -t fpm-nginx:latest .

run:
	docker run --rm -it -p 8000:80 fpm-nginx:latest

