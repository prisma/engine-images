build: build-darwin build-windows build-linux-arm-ssl-1.1.x

build-darwin:
	docker build -f darwin.Dockerfile -t prismagraphql/build:cross-darwin .

build-windows:
	docker build -f windows.Dockerfile -t prismagraphql/build:cross-windows .

build-linux-arm-ssl-1.1.x:
	docker build -f linux-arm-ssl-1.1.x.Dockerfile -t prismagraphql/build:cross-linux-arm-ssl-1.1.x .

push:
	docker push prismagraphql/build:cross-windows
	docker push prismagraphql/build:cross-darwin
	docker push prismagraphql/build:cross-linux-arm-ssl-1.1.x
