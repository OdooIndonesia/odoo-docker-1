About this Repo
===============

This is a fork of the official Docker image git repo for [hibou/odoo](https://hub.docker.com/r/hibou/odoo/).

This repo is automatically built on Docker Hub as [qubiq/odoo-docker](https://hub.docker.com/r/qubiq/odoo-docker/).

Additional information and command line options can be found at [Odoo](https://hub.docker.com/_/odoo/)

Goals
=====

* Provide as close to a 'drop in replacement' of the Official Docker image as possible.
(from a usability standpoint, e.g. creating the odoo user with the same uid number)
* Provide newer versions of node, NPM and LESS (less bugs, better perf.)
* Provide newer Python and Python packages. (less bugs, better perf.)
* Provide optional Python packages to enable missing Odoo features (flanker email validation, workers>0 support)
* Provide newer Postgres bindings to support backing up on Postgres > 9.4
* Provide a better developer and benchmarking suite (newrelic and watchdog)sourcetree
* Provide addintional custom addon mount point


How to use this image
=====================

This image requires a running PostgreSQL server.

Start a PostgreSQL server
=========================

According Odoo version:

8.0

```
docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo --name db postgres:9.4
```

9.0

```
docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo --name db9 postgres:9.4
```

10.0

```
docker run -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo --name db10 postgres:9.4
```



Start an Odoo instance
======================


According Odoo version:

8.0

```
docker run -p 8069:8069 --name odoo8 --link db:db -t qubiq/odoo-docker:8.0
```

9.0

```
docker run -p 8069:8069 --name odoo9 --link db9:db9 -t qubiq/odoo-docker:9.0
```

10.0

```
docker run -p 8069:8069 --name odoo10 --link db10:db10 -t qubiq/odoo-docker:10.0
```


