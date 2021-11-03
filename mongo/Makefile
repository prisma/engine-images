build: build-4.2 build-4.4 build-5.0

push: push-4.4 push-5.0 

build-4.2:
	docker build -t prismagraphql/mongo-single-replica:4.2.17-bionic ./4.2

build-4.4:
	docker build -t prismagraphql/mongo-single-replica:4.4.3-bionic ./4.4

build-5.0:
	docker build -t prismagraphql/mongo-single-replica:5.0.3 ./5.0

push-4.2:
	docker push prismagraphql/mongo-single-replica:4.2.17-bionic

push-4.4:
	docker push prismagraphql/mongo-single-replica:4.4.3-bionic

push-5.0:
	docker push prismagraphql/mongo-single-replica:5.0.3
