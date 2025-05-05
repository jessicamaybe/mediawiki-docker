
branch="$(echo REL$MEDIAWIKI_MAJOR_VERSION | sed 's/\./_/g')"


if [ ! -f /extensions/$branch ]; then

rm -rf /extensions/ConfirmAccount
git clone -b $branch https://github.com/wikimedia/mediawiki-extensions-ConfirmAccount /extensions/ConfirmAccount

rm -rf /extensions/DeleteBatch
git clone -b $branch https://github.com/wikimedia/mediawiki-extensions-DeleteBatch /extensions/DeleteBatch

rm -rf /extensions/JsonConfig
git clone -b $branch https://github.com/wikimedia/mediawiki-extensions-JsonConfig /extensions/JsonConfig

rm -rf /extensions/TemplateStyles
git clone -b $branch https://github.com/wikimedia/mediawiki-extensions-TemplateStyles /extensions/TemplateStyles

touch /extensions/$branch

fi