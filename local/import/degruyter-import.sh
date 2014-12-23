#!/bin/bash

import_p=$PWD/degruyter-import.properties

cd $VUFIND_HOME

./import-marc.sh -p $import_p $1
