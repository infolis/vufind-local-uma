#!/bin/bash

PORT="8080"
HOST='localhost'
QUERY="$1"
INDEX="biblio"

update_solr() {
    curl "http://$HOST:$PORT/solr/$INDEX/update" \
        --data "$1" \
        -H 'Content-type: text/xml; charset=utf-8'
}


echo "About to delete all documents matching '$QUERY'"
echo "Please confirm you want to do this [y/n]"
read yesno
if [[ "$yesno" == "y" ]];then
    echo "Sending delete request for '$QUERY'"
    update_solr "<delete><query>$QUERY</query></delete>"
    echo "Commit"
    update_solr '<commit/>'
fi

