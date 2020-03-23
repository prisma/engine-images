build: build-release

build-release:
	docker build -f release.Dockerfile -t prismagraphql/build:release .

push:
	docker push prismagraphql/build:release