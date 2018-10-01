build:
	docker build -t graphcool/scala-sbt-docker .

push:
	docker push graphcool/scala-sbt-docker

build-rust:
	docker build -t graphcool/scala-sbt-docker:rust .

push-rust:
	docker push graphcool/scala-sbt-docker:rust