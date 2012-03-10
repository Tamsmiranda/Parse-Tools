#!/bin/bash
if [ -z $1 ]
then
 echo "ERROR: No search string supplied."
 echo "USAGE: ./gocmd.sh <search srting>"
 echo ""
 echo -n "Anyways for now, supply the search string here: "
 read SEARCH
else
 SEARCH=$@
fi

# Base temporary file name
BASEFILE=`echo $SEARCH | sed 's/ /_/g'`

# Place to stash temporary files
PARSE_TMP="/var/tmp/parse.${BASEFILE}"
PARSE_TMP2="/var/tmp/parse2.${BASEFILE}"
URLS_TMP="/var/tmp/parse.${BASEFILE}"

# Set Google default language
LANGUAGE="pt-BR"

# Set Google Url
URL="http://google.com/search?hl=${LANGUAGE}&safe=off&q="

QUERIES=`echo $SEARCH | sed 's/ /%20/g'`
URI="$URL%22$QUERIES%22"

if [ ! -f "${PARSE_TMP}" ]; then lynx -dump $URI > ${PARSE_TMP}; fi

sed 's/http/\^http/g' ${PARSE_TMP} | tr -s "^" "\n" | grep http| sed 's/\ .*//g' > ${PARSE_TMP2}
sed '/google.com/d' ${PARSE_TMP2} > ${URLS_TMP}

#echo "SUCCESS: Extracted `wc -l urls` and listed them in '`pwd`/urls' file for reference."
#echo ""
cat ${URLS_TMP}
#echo ""

#EOF

