build: build-musl build-alpine

build-musl:
	docker build -f musl.Dockerfile -t prismagraphql/build:musl .

build-alpine:
	docker build -f alpine.Dockerfile -t prismagraphql/build:alpine .

push:
	docker push prismagraphql/build:musl
	docker push prismagraphql/build:alpine
