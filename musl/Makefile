build: build-musl

build-musl:
	docker build -f musl.Dockerfile -t prismagraphql/build:musl .

push:
	docker push prismagraphql/build:musl