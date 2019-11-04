build: build-1.0.x build-1.1.x

build-1.0.x:
	docker build -f libssl1.0.x.Dockerfile -t prismagraphql/build-image:debian-libssl1.0.x .

build-1.1.x:
	docker build -f libssl1.1.x.Dockerfile -t prismagraphql/build-image:debian-libssl1.1.x .

push:
	docker push prismagraphql/build-image:debian-libssl1.1.x
	docker push prismagraphql/build-image:debian-libssl1.0.x