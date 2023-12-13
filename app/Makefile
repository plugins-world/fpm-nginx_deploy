.PHONY: build dev run

build:
	docker build -t app .

dev:
	docker run --rm --name app -itd -p 8000:80 -v $PWD:/var/www/html app

run:
	docker run --rm --name app -itd \
		-p 8000:80 \
		-v /path/to/storage:/var/www/html/storage
		-e DB_HOST=xxx \
		-e DB_PORT=xxx \
		-e DB_DATABASE=xxx \
		-e DB_USERNAME=xxx \
		-e DB_PASSWORD=xxx \
		app
