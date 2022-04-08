build: build-1.1.x build-1.0.x build-3.0.x

build-1.0.x:
	docker build -f libssl1.0.x.Dockerfile -t prismagraphql/build:rhel-libssl1.0.x .

build-1.1.x:
	docker build -f libssl1.1.x.Dockerfile -t prismagraphql/build:rhel-libssl1.1.x .

build-3.0.x:
	docker build -f libssl3.0.x.Dockerfile -t prismagraphql/build:rhel-libssl3.0.x .

push:
	docker push prismagraphql/build:rhel-libssl1.0.x
	docker push prismagraphql/build:rhel-libssl1.1.x
	docker push prismagraphql/build:rhel-libssl3.0.x