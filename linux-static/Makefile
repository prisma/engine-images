.PHONY: build push build-x64 build-arm64

build: build-x64 build-arm64

build-x64:
	docker build -f linux-static-x64.Dockerfile -t prismagraphql/build:linux-static-x64 .

build-arm64:
	docker build -f linux-static-arm64.Dockerfile -t prismagraphql/build:linux-static-arm64 .

push:
	docker push prismagraphql/build:linux-static-x64
	docker push prismagraphql/build:linux-static-arm64
