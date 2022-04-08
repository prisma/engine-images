build: build-1.0.x build-1.1.x build-3.0.x

build-1.0.x:
	docker build --platform linux/amd64 -f libssl1.0.x.Dockerfile -t prismagraphql/build:debian-libssl1.0.x .

build-1.1.x:
	docker build --platform linux/amd64 -f libssl1.1.x.Dockerfile -t prismagraphql/build:debian-libssl1.1.x .

build-3.0.x:
	docker build --platform linux/amd64 -f libssl3.0.x.Dockerfile -t prismagraphql/build:debian-libssl3.0.x .

push:
	docker push prismagraphql/build:debian-libssl1.0.x
	docker push prismagraphql/build:debian-libssl1.1.x
	docker push prismagraphql/build:debian-libssl3.0.x