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

# Place to stash temporary files
PARSE_TMP="/var/tmp/parse.$$"
PARSE_TMP2="/var/tmp/parse2.$$"
URLS_TMP="/var/tmp/parse.$$"

# Set Google default language
LANGUAGE="pt-BR"

URL="http://google.com/search?hl=$LANGUAGE&safe=off&q="
STRING=`echo $SEARCH | sed 's/ /%20/g'`
URI="$URL%22$STRING%22"

lynx -dump $URI > ${PARSE_TMP}
sed 's/http/\^http/g' ${PARSE_TMP} | tr -s "^" "\n" | grep http| sed 's/\ .*//g' > ${PARSE_TMP2}
sed '/google.com/d' ${PARSE_TMP2} > ${URLS_TMP}

#echo "SUCCESS: Extracted `wc -l urls` and listed them in '`pwd`/urls' file for reference."
#echo ""
cat ${URLS_TMP}
#echo ""

#EOF

