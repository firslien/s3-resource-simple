#!/bin/sh

set -e

function urlencode() {
  which "curl" >/dev/null 2>&1; if [ ! $? -eq 0 ]; then echo -E "$1";return; fi
  encode_str=$(echo -E "$1" |sed "s/%/%%/g")
  printf -- "$encode_str" | curl -Gso /dev/null -w %{url_effective} --data-urlencode @- "" |cut -c 3-
}

dir=$prefix/$path

prefix_params=$(urlencode $dir)%2f

# give back a(n empty) version, so that the check passes when using `in`/`out`
echo "{
  \"version\": { \"path\": \"$dir\" },
  \"metadata\": [  
    { \"name\": \"path\", \"value\": \"$dir\" },
    { \"name\": \"url\", \"value\": \"$url/buckets/$bucket?prefix=$prefix_params\" } 
  ]
}"
