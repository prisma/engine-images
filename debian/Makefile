build: build-1.0.x build-1.1.x build-1.0.2 build-1.1.1

build-1.0.x:
	docker build -f libssl1.0.x.Dockerfile -t prismagraphql/build-image:debian-libssl1.0.x .

build-1.1.x:
	docker build -f libssl1.1.x.Dockerfile -t prismagraphql/build-image:debian-libssl1.1.x .

# temp
build-1.0.2:
	docker build -f libssl1.0.2.Dockerfile -t prismagraphql/build-image:debian-libssl1.0.2 .

# temp
build-1.1.1:
	docker build -f libssl1.1.1.Dockerfile -t prismagraphql/build-image:debian-libssl1.1.1 .

push:
	docker push prismagraphql/build-image:debian-libssl1.1.x
	docker push prismagraphql/build-image:debian-libssl1.0.x