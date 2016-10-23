#!/bin/bash

set -e

# set odoo database host, port, user and password
: ${PGHOST:=$DB10_PORT_5432_TCP_ADDR}
: ${PGPORT:=$DB10_PORT_5432_TCP_PORT}
: ${PGUSER:=${DB10_ENV_POSTGRES_USER:='postgres'}}
: ${PGPASSWORD:=$DB10_ENV_POSTGRES_PASSWORD}
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
