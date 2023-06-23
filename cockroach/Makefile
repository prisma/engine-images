build: build-21.2.0-patched build-22.1.0-alpha.1 build-22.1.0-beta.2 build-22.1.0-beta.5 build-22.1.0 build-22.2 build-23.1

build-21.2.0-patched:
	docker build -t prismagraphql/cockroachdb-custom:21.2.0-patched ./21.2.0-patched

build-22.1.0-alpha.1:
	docker build -t prismagraphql/cockroachdb-custom:22.1.0-alpha.1 ./22.1.0-alpha.1

build-22.1.0-beta.2:
	docker build -t prismagraphql/cockroachdb-custom:22.1.0-beta.2 ./22.1.0-beta.2

build-22.1.0-beta.5:
	docker build -t prismagraphql/cockroachdb-custom:22.1.0-beta.5 ./22.1.0-beta.5

build-22.1.0:
	docker build -t prismagraphql/cockroachdb-custom:22.1.0 ./22.1.0

build-22.2:
	docker build -t prismagraphql/cockroachdb-custom:22.2 ./22.2

build-23.1:
	docker build -t prismagraphql/cockroachdb-custom:23.1 ./23.1

push:
	docker push prismagraphql/cockroachdb-custom:21.2.0-patched
	docker push prismagraphql/cockroachdb-custom:22.1.0-alpha.1
	docker push prismagraphql/cockroachdb-custom:22.1.0-beta.2
	docker push prismagraphql/cockroachdb-custom:22.1.0-beta.5
	docker push prismagraphql/cockroachdb-custom:22.1.0
	docker push prismagraphql/cockroachdb-custom:22.2
	docker push prismagraphql/cockroachdb-custom:23.1