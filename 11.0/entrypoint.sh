#!/bin/bash

set -e

# set odoo database host, port, user and password
: ${PGHOST:=$DB11_PORT_5432_TCP_ADDR}
: ${PGPORT:=$DB11_PORT_5432_TCP_PORT}
: ${PGUSER:=${DB11_ENV_POSTGRES_USER:='postgres'}}
: ${PGPASSWORD:=$DB11_ENV_POSTGRES_PASSWORD}
export PGHOST PGPORT PGUSER PGPASSWORD

case "$1" in
	--)
		shift
		exec odoo "$@"
		;;
	-*)
		exec odoo "$@"
		;;
	*)
		exec "$@"
esac

exit 1
