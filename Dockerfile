FROM mediawiki:lts

ENV GIT_VERSION_STR=REL1_43

USER 0

RUN apt-get update; \
        apt-get install -y lua5.1 git imagemagick librsvg2-2 python3-setuptools python3-pip sendmail; \
        rm -rf /var/lib/apt/lists/*;

RUN echo "Extensions"; \
        git clone -b $GIT_VERSION_STR https://github.com/wikimedia/mediawiki-extensions-DeleteBatch /var/www/html/extensions/DeleteBatch; \
        git clone -b $GIT_VERSION_STR https://github.com/wikimedia/mediawiki-extensions-ConfirmAccount /var/www/html/extensions/ConfirmAccount; \
        git clone -b $GIT_VERSION_STR https://github.com/wikimedia/mediawiki-extensions-JsonConfig /var/www/html/extensions/JsonConfig; \
        git clone -b $GIT_VERSION_STR https://github.com/wikimedia/mediawiki-extensions-TemplateStyles /var/www/html/extensions/TemplateStyles; \

        git clone -b $GIT_VERSION_STR https://github.com/wikimedia/mediawiki-extensions-SyntaxHighlight_GeSHi /var/www/html/extensions/SyntaxHighlight_GeSHi; \
        chmod a+x /var/www/html/extensions/SyntaxHighlight_GeSHi/pygments/pygmentize; \

        git clone -b $GIT_VERSION_STR https://github.com/wikimedia/mediawiki-extensions-MsUpload /var/www/html/extensions/MsUpload; \
        
        # branchless plugins
        git clone https://github.com/jayktaylor/mw-discord /var/www/html/extensions/mw-discord;


COPY php.ini /usr/local/etc/php/conf.d/mediawiki.ini

COPY entrypoint.sh /entrypoint.sh

VOLUME ["/extensions" , "/config", "/skins"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["wiki"]

