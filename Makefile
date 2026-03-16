IMAGE_NAME := rmnobarra/dummy-go
TAG        := latest
PORT       := 8080

.PHONY: run build test docker-build docker-run docker-stop clean

run:
	go run ./...

build:
	go build -o bin/server ./...

test:
	go test ./...

docker-build:
	docker build -t $(IMAGE_NAME):$(TAG) .

docker-run:
	docker run --rm -p $(PORT):8080 --name dummy-go $(IMAGE_NAME):$(TAG)

docker-stop:
	docker stop dummy-go

clean:
	rm -rf bin/
