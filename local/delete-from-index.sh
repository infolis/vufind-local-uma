#!/bin/bash

PORT="8080"
HOST='localhost'
QUERY="$1"
INDEX="biblio"

update_solr() {
    curl -v "http://$HOST:$PORT/solr/$INDEX/update" \
        --data "$1" \
        -H 'Content-type: text/xml; charset=utf-8'
}


echo "Sending delete request for '$QUERY'"
update_solr "<delete><query>$QUERY</query></delete>"

echo "Commit"
update_solr '<commit/>'
