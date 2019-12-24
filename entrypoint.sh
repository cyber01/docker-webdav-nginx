#!/bin/bash
if [ "x$SERVER_NAMES" != "x" ]; then
    # Replace commas with spaces
    SERVER_ALIAS="`printf '%s\n' "$SERVER_NAMES" | tr ',' ' '`"
    sed -e "s|server_name .*|server_name $SERVER_ALIAS;|" \
        -i /etc/nginx/conf.d/default.conf
fi

if [ ! -e "/user.passwd" ]; then
    touch "/user.passwd"
    # Only generate a password hash if both username and password given.
    if [ "x$USERNAME" != "x" ] && [ "x$PASSWORD" != "x" ]; then
            htpasswd -B -b -c "/user.passwd" $USERNAME $PASSWORD
    fi
fi