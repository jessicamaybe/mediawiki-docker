FROM mediawiki:stable

USER 0


RUN apt-get update; \
        apt-get install -y lua5.1 git imagemagick librsvg2-2 python3-setuptools python3-pip sendmail; \
        rm -rf /var/lib/apt/lists/*;

COPY php.ini /usr/local/etc/php/conf.d/mediawiki.ini

COPY entrypoint.sh /entrypoint.sh

VOLUME ["/extensions" , "/config", "/skins"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["wiki"]

