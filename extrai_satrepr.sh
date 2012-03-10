#!/bin/bash

# Keywords file
KEYWORDS="./keywords.txt"
URLS="./data/urls.txt"
DOMAINS="./data/domains.txt"

if [ ! -f "${URLS}" ]; then touch ${URLS}; fi

if [ ! -f "${KEYWORDS}" ]; then
	for KEYWORD in $@; do
		echo -e "Obtendo urls para:${KEYWORD}\n"
		./gparse.sh ${KEYWORD} >> ${URLS}
	done
else
	cat ${KEYWORDS} | while read KEYWORD ; do
		echo -e "Obtendo urls para:${KEYWORD}\n"
		./gparse.sh ${KEYWORD} >> ${URLS}
	done
fi
cat ${URLS} | awk '{gsub("http://|/.*","")}1' | awk '!($0 in a) {a[$0];print}' | sort > ${DOMAINS}

exit 0

# cat domains.txt | awk '!($0 in a) {a[$0];print}' > domains_filtered.txt
cat domains_filtered.txt | grep embratel > domains_ok.txt
cat domains_filtered.txt | grep claro >> domains_ok.txt
cat domains_filtered.txt | grep sky >> domains_ok.txt
