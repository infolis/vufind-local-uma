#!/bin/bash

COLLECTION=$1
MARC_RECORDS=$2

TMP_PROP="/tmp/ebook.properties"

touch $TMP_PROP
echo > $TMP_PROP
echo "collection = \"$COLLECTION\"" > $TMP_PROP

import_p=$PWD/ebook-import.properties

cd $VUFIND_HOME

./import-marc.sh -p $import_p $MARC_RECORDS
