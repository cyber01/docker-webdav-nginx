#!/bin/bash
if [ "x$SERVER_NAMES" != "x" ]; then
    # Use first domain as Apache ServerName.
    SERVER_NAME="${SERVER_NAMES%%,*}"
    sed -e "s|server_name .*|server_name $SERVER_NAME|" \
        -i /etc/nginx/conf.d/default.conf

    # Replace commas with spaces and set as Apache ServerAlias.
    SERVER_ALIAS="`printf '%s\n' "$SERVER_NAMES" | tr ',' ' '`"
    sed -e "/server_name/a\ \ ServerAlias $SERVER_ALIAS" \
        -i /etc/nginx/conf.d/default.conf
fi

if [ ! -e "/user.passwd" ]; then
    touch "/user.passwd"
    # Only generate a password hash if both username and password given.
    if [ "x$USERNAME" != "x" ] && [ "x$PASSWORD" != "x" ]; then
        if [ "$AUTH_TYPE" = "Digest" ]; then
            # Can't run `htdigest` non-interactively, so use other tools.
            HASH="`printf '%s' "$USERNAME:$REALM:$PASSWORD" | md5sum | awk '{print $1}'`"
            printf '%s\n' "$USERNAME:$REALM:$HASH" > /user.passwd
        else
            htpasswd -B -b -c "/user.passwd" $USERNAME $PASSWORD
        fi
    fi
fi