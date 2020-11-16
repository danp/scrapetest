#!/bin/bash

dir="$(curl --silent --fail http://outagemap.nspower.ca/resources/data/external/interval_generation_data/metadata.json | jq -r .directory)"

for k in 030231 030233 030320 030321 030322 030323; do
    if curl --silent --fail --retry 3 --max-time 15 -o "$k.json" "http://outagemap.nspower.ca/resources/data/external/interval_generation_data/$dir/outages/$k.json"; then
	jq -S . "$k.json" > "$k.json.tmp"
	mv "$k.json.tmp" "$k.json"
    fi
done
