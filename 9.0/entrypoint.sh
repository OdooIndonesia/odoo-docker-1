#!/bin/bash

set -e

# set odoo database host, port, user and password
: ${PGHOST:=$DB9_PORT_5432_TCP_ADDR}
: ${PGPORT:=$DB9_PORT_5432_TCP_PORT}
: ${PGUSER:=${DB9_ENV_POSTGRES_USER:='postgres'}}
: ${PGPASSWORD:=$DB9_ENV_POSTGRES_PASSWORD}
export PGHOST PGPORT PGUSER PGPASSWORD

case "$1" in
	--)
		shift
		exec openerp-server "$@"
		;;
	-*)
		exec openerp-server "$@"
		;;
	*)
		exec "$@"
esac

exit 1
