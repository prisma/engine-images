build: build-darwin build-windows build-graviton

build-darwin:
	docker build -f darwin.Dockerfile -t prismagraphql/build:cross-darwin .

build-windows:
	docker build -f windows.Dockerfile -t prismagraphql/build:cross-windows .

build-graviton:
	docker build -f graviton.Dockerfile -t prismagraphql/build:cross-graviton .

push:
	docker push prismagraphql/build:cross-windows
	docker push prismagraphql/build:cross-darwin
	docker push prismagraphql/build:cross-graviton
