#! /usr/bin/env bash

mkdir dist
cp data/asctb_tables/*.csv dist
cp public/* dist
mv dist/index-template.md dist/index.md
jq -r '.references[]|"\(.name)|\(.asctb_name)"' data/organ_data.json |\
  awk -F "|" 'BEGIN{OFS=""} {print "- [",$2,"](https://hubmapconsortium.github.io/asctb-azimuth-data-comparison/",$1,".csv)"}' |\
  sort > dist/csv_download_list.md
cat dist/csv_download_list.md >> dist/index.md