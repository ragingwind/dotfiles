#!/bin/sh

>&2 echo $1

export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8

di() {
query=$(echo $1 | iconv -f utf-8 -t euc-kr)
curl -s -G -H "Content-Type: text/html; charset=euc-kr" 'http://dic.impact.pe.kr/ecmaster-cgi/search.cgi?bool=and&word=yes' --data-urlencode "kwd=$query" > $TMPDIR/index.html && open $TMPDIR/index.html
}

di $1
