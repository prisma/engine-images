build: build-test build-gh-actions-test

build-test:
	docker build -t prismagraphql/build:test .

build-gh-actions-test:
	docker build -f gh-actions.Dockerfile -t prismagraphql/build:test-gh-actions .

push:
	docker push prismagraphql/build:test
	docker push prismagraphql/build:test-gh-actions
