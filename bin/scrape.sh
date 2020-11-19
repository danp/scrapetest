#!/bin/bash

dir="$(curl --silent --fail http://outagemap.nspower.ca/resources/data/external/interval_generation_data/metadata.json | jq -r .directory)"
durl="http://outagemap.nspower.ca/resources/data/external/interval_generation_data/$dir"

for k in 030231 030233 030320 030321 030322 030323 ; do
    if curl --silent --fail --retry 3 --max-time 15 -o "$k.json" "$durl/outages/$k.json"; then
	jq -S . "$k.json" > "$k.json.tmp"
	mv "$k.json.tmp" "$k.json"
    fi
done

for f in report_servicearea; do
    curl --silent --fail --retry 3 --max-time 15 -O "$durl/$f.json"
    jq -S . "$f.json" > "$f.json.tmp"
    mv "$f.json.tmp" "$f.json"
done
