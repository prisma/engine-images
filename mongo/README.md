## Mongo Replica Set Image
This image is a modified version of the 4.4.x image from https://github.com/docker-library/mongo/tree/master/4.4

It adds an instantiate for replica set "rs0" on startup. Used for uncomplicated single-cluster setup for our tests and development environment.

All credit for the original work goes to the original authors.

## Config
`REPLICA_BIND_HOST`: If absent, the cluster will bind to `localhost`. If set, will bind to the provided value. 
This is important for networking inside docker. The config will initialize like (`rs.config()`):
```js
//...
	"members" : [
		{
			"_id" : 0,
			"host" : "bind_host_var_val:27017",
			"arbiterOnly" : false,
			"buildIndexes" : true,
			"hidden" : false,
			"priority" : 1,
			"tags" : {

			},
			"slaveDelay" : NumberLong(0),
			"votes" : 1
		}
	],
//...
```

If not set and the replica set is resolved via the container name, e.g. like:
```yml
app:
    image: prismagraphql/mongo-single-replica:4.4.3-bionic
    environment:
        DB_URL: mongodb://mongo4:27017
    ports:
      - "8080:8080"
    networks:
      - internal

mongo4:
    image: prismagraphql/mongo-single-replica:4.4.3-bionic
    ports:
      - "27017:27017"
    networks:
      - internal

# ...
```

The above will not resolve correctly because the cluster is initialized with localhost, so the server selection fails.
Why? Because the config initializes with localhost:
```js
//...
	"members" : [
		{
			"_id" : 0,
			"host" : "localhost:27017",
			"arbiterOnly" : false,
			"buildIndexes" : true,
			"hidden" : false,
			"priority" : 1,
			"tags" : {

			},
			"slaveDelay" : NumberLong(0),
			"votes" : 1
		}
	],
//...
```
The driver will fetch the replica set config and look for `localhost`, which won't work, it needs to look up the server as `mongo4`.
