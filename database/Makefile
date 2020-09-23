build: build-mssql2017 build-mssql2019

build-mssql2017:
	docker build -f mssql2017.Dockerfile -t prismagraphql/build:mssql-2017 .

build-mssql2019:
	docker build -f mssql2019.Dockerfile -t prismagraphql/build:mssql-2019 .

push:
	docker push prismagraphql/build:mssql-2017
	docker push prismagraphql/build:mssql-2019
