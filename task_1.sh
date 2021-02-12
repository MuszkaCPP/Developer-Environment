#!/bin/bash

WORDS=""
REV_NUMBER=$1
URL="$2"
FOLDERS=$(svn list $URL/@$REV_NUMBER --depth=infinity)

for folder in $FOLDERS; do
	if [[ "$(svn info $URL/$folder | grep 'Node Kind:')" == "Node Kind: file" ]]; then
		WORDS=$WORDS" "$(svn cat $URL/$folder);
	fi
done


echo $WORDS | tr " " "\n" | grep -v "^\s*$" | sort | uniq -c;
