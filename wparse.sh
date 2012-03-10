#!/bin/bash

# Whois server
# WHOIS_SERVER="whois.internic.org"
WHOIS_SERVER="whois.registro.br"

# Place to stash temporary files
WHOIS_TMP="/var/tmp/whois.${1}"
LIST_TMP="/var/tmp/list"


parse() {
	# Get Registrar Vars
	echo -e "${WHOIS_TMP}\n"
	cat ${WHOIS_TMP}
	DOMAIN=`cat ${WHOIS_TMP} | awk '/domain:/ { print $NF }'`
	echo -e "$DOMAIN\n";
	OWNER=`cat ${WHOIS_TMP} | awk -F: '/owner:/ { print $NF }'`
	OWNERID=`cat ${WHOIS_TMP} | awk '/ownerid:/ { print $NF }'`
	RESPONSIBLE=`cat ${WHOIS_TMP} | awk -F: '/responsible:/ { print $NF }'`
	COUNTRY=`cat ${WHOIS_TMP} | awk '/country:/ { print $NF }'`
	OWNER_C=`cat ${WHOIS_TMP} | awk '/owner-c:/ { print $NF }'`
	ADMIN_C=`cat ${WHOIS_TMP} | awk '/admin-c:/ { print $NF }'`
	TECH_C=`cat ${WHOIS_TMP} | awk '/tech-c:/ { print $NF }'`
	BILLING_C=`cat ${WHOIS_TMP} | awk '/billing-c:/ { print $NF }'`
	#CREATED=`cat ${WHOIS_TMP} | awk '/created:/ { print $NF }'`
	#EXPIRES=`cat ${WHOIS_TMP} | awk '/expires:/ { print $NF }'`
	PERSON=`cat ${WHOIS_TMP} | awk -F: '/person:/ { print $NF }'`
	EMAIL=`cat ${WHOIS_TMP} | awk '/e-mail:/ { print $NF }'`
	echo -e "$DOMAIN;$OWNER;$OWNERID;$RESPONSIBLE;$COUNTRY;$OWNER_C;$ADMIN_C;$TECH_C;$BILLING_C;$PERSON;$EMAIL;\n"
}

if [ ! -f "$1" ]; then 
	#whois=`whois -h whois.registro.br --verbose $1`
	#${WHOIS} -h ${WHOIS_SERVER} "=${1}" > ${WHOIS_TMP}
	if [ ! -f "${WHOIS_TMP}" ]; then whois -h ${WHOIS_SERVER} ${1} > ${WHOIS_TMP}; fi
	parse
	show
else
	if [ ! -f "${LIST_TMP}" ]; then 
		rm ${LIST_TMP}
		touch ${LIST_TMP}
	fi
	cat ${1} | while read DOMAIN ; do
		WHOIS_TMP="/var/tmp/whois.${DOMAIN}"
		if [ ! -f "${WHOIS_TMP}" ]; then whois -h ${WHOIS_SERVER} ${DOMAIN} > ${WHOIS_TMP}; fi
		echo -e "${DOMAIN}\n"
		echo -e "${WHOIS_TMP}\n"
		parse
	done
	#cat ${LIST_TMP}
fi
