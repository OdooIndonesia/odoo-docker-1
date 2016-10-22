About this Repo
===============

This is a fork of the official Docker image git repo for [hibou/odoo](https://hub.docker.com/r/hibou/odoo/).

This repo is automatically built on Docker Hub as [qubiq/odoo-docker](https://hub.docker.com/r/qubiq/odoo-docker/).

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
