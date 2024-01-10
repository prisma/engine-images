build: build-22.1.0 build-22.2 build-23.1 build-23.1.13 build-23.2.0-rc.2

build-22.1.0:
	docker build -t prismagraphql/cockroachdb-custom:22.1.0 ./22.1.0

build-22.2:
	docker build -t prismagraphql/cockroachdb-custom:22.2 ./22.2

build-23.1:
	docker build -t prismagraphql/cockroachdb-custom:23.1 ./23.1

build-23.1.13:
	docker build -t prismagraphql/cockroachdb-custom:23.1.13  ./23.1.13 

# Unstable
# TODO: remove it when adding 23.2.0
build-23.2.0-rc.2:
	docker build -t prismagraphql/cockroachdb-custom:23.2.0-rc.2  ./23.2.0-rc.2

push:
	docker push prismagraphql/cockroachdb-custom:22.1.0
	docker push prismagraphql/cockroachdb-custom:22.2
	docker push prismagraphql/cockroachdb-custom:23.1
	docker push prismagraphql/cockroachdb-custom:23.1.13
	docker push prismagraphql/cockroachdb-custom:23.2.0-rc.2
