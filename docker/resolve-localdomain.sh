#! /bin/sh

set -e

# This command is required if running an Alpine version of nginx to be able to resolve
# the DNS to the PHP container using AWS Service Discovery
if [ "${LOCALDOMAIN}x" != "x" ]; then echo "search ${LOCALDOMAIN}" >> /etc/resolv.conf; fi

exit 0
