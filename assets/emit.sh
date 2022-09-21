#!/bin/sh

set -e

dir=$(cat ci_version)

prefix_params=$(echo $dir| sed 's/\//%2f/g')%2f

# give back a(n empty) version, so that the check passes when using `in`/`out`
echo "{
  \"version\": { \"path\": \"$dir\" },
  \"metadata\": [  
    { \"name\": \"path\", \"value\": \"$dir\" },
    { \"name\": \"url\", \"value\": \"$url/buckets/$bucket?prefix=$prefix_params\" } 
  ]
}"
