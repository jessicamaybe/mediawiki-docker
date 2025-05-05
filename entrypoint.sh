#!/bin/bash

# Handle signals
handle_signal (){
	PID=$!
	echo "received signal. PID is ${PID}"
	kill -s SIGHUP $PID
}

trap "handle_signal" SIGINT SIGTERM SIGHUP

sh update_extensions.sh

# Start the wiki
if [[ "$1" == "wiki" ]] ; then

	# The php:x.x-fpm uses /var/www/html as the WORKDIR and document root
	# Our custom extensions and skins will be symlinked there.
	WORKDIR=/var/www/html

	# Custom extensions
	for i in /extensions/* ; do
		ln -s $i $WORKDIR/extensions/
	done

	# Custom skins
	for i in /skins/* ; do
		ln -s $i $WORKDIR/skins/
	done

	# Configuration file
#	ln -sf /config/LocalSettings.php $WORKDIR/LocalSettings.php

	# Run post-installation scripts
	test -f /extensions/post-install.sh && sh /extensions/post-install.sh

	# Update database schema if needed
	php $WORKDIR/maintenance/update.php

	# Symlink required?
	if [ ! -z "$SYMLINK_DIR" ] ; then
		echo "Symlinking /var/www/html/$SYMLINK_DIR to /var/www/html"
		ln -s /var/www/html "/var/www/html/$SYMLINK_DIR"
	fi

	# Normal execution of apache2-foreground as done by php:7.3-apache
	exec docker-php-entrypoint apache2-foreground
fi

# Otherwise, run whatever was passed
exec "$@"
