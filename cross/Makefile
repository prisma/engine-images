build: build-darwin build-windows

build-darwin:
	docker build -f darwin.Dockerfile -t prismagraphql/build:cross-darwin .

build-windows:
	docker build -f windows.Dockerfile -t prismagraphql/build:cross-windows .

push:
	docker push prismagraphql/build:cross-windows
	docker push prismagraphql/build:cross-darwin
