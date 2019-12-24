#!/bin/bash
if [ "x$SERVER_NAMES" != "x" ]; then
    # Replace commas with spaces
    SERVER_ALIAS="`printf '%s\n' "$SERVER_NAMES" | tr ',' ' '`"
    sed -e "s|server_name .*|server_name $SERVER_ALIAS;|" \
        -i /etc/nginx/conf.d/default.conf
fi