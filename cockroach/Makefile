build: build-22.1.0 build-21.2.0-patched

build-22.1.0:
	docker build -t prismagraphql/cockroachdb-custom:22.1.0 ./22.1.0

build-21.2.0-patched:
	docker build -t prismagraphql/cockroachdb-custom:21.2.0-patched ./21.2.0-patched

push:
	docker push prismagraphql/cockroachdb-custom:22.1.0
	docker push prismagraphql/cockroachdb-custom:21.2.0-patched
