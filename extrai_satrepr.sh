#!/bin/bash

# Keywords file
FILE_TMP="/var/tmp/file.${BASEFILE}"
KEYWORDS="./keywords.txt"
BLACKLIST="./black.lst"
WHITELIST="./white.lst"
URLS="./data/urls.txt"
DOMAINS="./data/domains.txt"

if [ ! -f "${URLS}" ]; then 
	touch ${URLS};
else
	rm ${URLS}
	touch ${URLS};
fi

if [ ! -f "${KEYWORDS}" ]; then
	for KEYWORD in $@; do
		echo -e "Obtendo urls para:${KEYWORD}\n"
		./gparse.sh ${KEYWORD} >> ${URLS}
	done
else
	LINES=`cat ${KEYWORDS} | wc -l`
	cat ${KEYWORDS} | while read KEYWORD ; do
		LINE=$((LINE+1))
		echo -e "Obtendo urls para (${LINE}/${LINES}):${KEYWORD}\n"
		./gparse.sh ${KEYWORD} >> ${URLS}
	done
fi
cat ${URLS} | awk '{gsub("http://|/.*","")}1' | awk '!($0 in a) {a[$0];print}' | sort > ${DOMAINS}

# black list filter
LINES=`cat ${BLACKLIST} | wc -l`
cat ${BLACKLIST} | while read BLACKITEM ; do
	LINE=$((LINE+1))
	echo -e "Removendo dominio (${LINE}/${LINES}):${BLACKITEM}\n"
	cat ${DOMAINS} | grep -v ${BLACKITEM} > ${FILE_TMP}
	mv ${FILE_TMP} ${DOMAINS}
done

# white list filter
LINES=`cat ${WHITELIST} | wc -l`
cat ${WHITELIST} | while read WHITEITEM ; do
	LINE=$((LINE+1))
	echo -e "Permitindo dominios contendo (${LINE}/${LINES}):${WHITEITEM}\n"
	cat ${DOMAINS} | grep ${WHITEITEM} >> ${FILE_TMP}
done
cat ${FILE_TMP} | awk '!($0 in a) {a[$0];print}' | sort >  ${DOMAINS}

exit 0

# cat domains.txt | awk '!($0 in a) {a[$0];print}' > domains_filtered.txt
cat domains_filtered.txt | grep embratel > domains_ok.txt
cat domains_filtered.txt | grep claro >> domains_ok.txt
cat domains_filtered.txt | grep sky >> domains_ok.txt
