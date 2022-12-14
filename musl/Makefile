build: build-alpine1.1 build-alpine3.0

build-alpine1.1:
	docker build -f libssl1.1.x.Dockerfile -t prismagraphql/build:alpine-libssl1.1.x .

build-alpine3.0:
	docker build -f libssl3.0.x.Dockerfile -t prismagraphql/build:alpine-libssl3.0.x .

push:
	docker push prismagraphql/build:alpine-libssl1.1.x
	docker push prismagraphql/build:alpine-libssl3.0.x
