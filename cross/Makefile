build: build-darwin build-windows build-linux-arm-ssl-1.0.x build-linux-arm-ssl-1.1.x build-linux-arm-ssl-3.0.x build-linux-musl-arm-ssl-1.1.x build-linux-musl-arm-ssl-3.0.x

build-darwin:
	docker build --platform linux/amd64 -f darwin.Dockerfile -t prismagraphql/build:cross-darwin .

build-windows:
	docker build --platform linux/amd64 -f windows.Dockerfile -t prismagraphql/build:cross-windows .

build-linux-arm-ssl-1.0.x:
	docker build --platform linux/amd64 -f linux-arm-ssl-1.0.x.Dockerfile -t prismagraphql/build:cross-linux-arm-ssl-1.0.x-integration .
	docker push prismagraphql/build:cross-linux-arm-ssl-1.0.x-integration

build-linux-arm-ssl-1.1.x:
	docker build --platform linux/amd64 -f linux-arm-ssl-1.1.x.Dockerfile -t prismagraphql/build:cross-linux-arm-ssl-1.1.x-integration .
	docker push prismagraphql/build:cross-linux-arm-ssl-1.1.x-integration

build-linux-arm-ssl-3.0.x:
	docker build --platform linux/amd64 -f linux-arm-ssl-3.0.x.Dockerfile -t prismagraphql/build:cross-linux-arm-ssl-3.0.x-integration .
	docker push prismagraphql/build:cross-linux-arm-ssl-3.0.x-integration

build-linux-musl-arm-ssl-1.1.x:
	# docker buildx build --platform linux/amd64 -f linux-musl-arm.Dockerfile --build-arg OPENSSL_VARIANT=1.1.x -t prismagraphql/build:cross-linux-musl-arm-ssl-1.1.x-integration .
	# docker push prismagraphql/build:cross-linux-musl-arm-ssl-1.1.x-integration

build-linux-musl-arm-ssl-3.0.x:
	# docker buildx build --platform linux/amd64 -f linux-musl-arm.Dockerfile --build-arg OPENSSL_VARIANT=3.0.x -t prismagraphql/build:cross-linux-musl-arm-ssl-3.0.x-integration .
	# docker push prismagraphql/build:cross-linux-musl-arm-ssl-3.0.x-integration

push:
	docker push prismagraphql/build:cross-windows
	docker push prismagraphql/build:cross-darwin
	docker push prismagraphql/build:cross-linux-arm-ssl-1.1.x
	docker push prismagraphql/build:cross-linux-arm-ssl-1.0.x
	docker push prismagraphql/build:cross-linux-arm-ssl-3.0.x
	docker push prismagraphql/build:cross-linux-musl-arm-ssl-1.1.x
	docker push prismagraphql/build:cross-linux-musl-arm-ssl-3.0.x
