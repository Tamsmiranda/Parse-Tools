#!/bin/bash

# Whois server
# WHOIS_SERVER="whois.internic.org"
WHOIS_SERVER="whois.registro.br"

# Place to stash temporary files
WHOIS_TMP="/var/tmp/whois.$$"


#whois=`whois -h whois.registro.br --verbose $1`
#${WHOIS} -h ${WHOIS_SERVER} "=${1}" > ${WHOIS_TMP}
whois -h ${WHOIS_SERVER} ${1} > ${WHOIS_TMP}

# Get Registrar Vars
DOMAIN=`cat ${WHOIS_TMP} | awk '/domain:/ { print $NF }'`
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
PERSON=`cat ${WHOIS_TMP} | awk '/person:/ { print $NF }'`
EMAIL=`cat ${WHOIS_TMP} | awk '/e-mail:/ { print $NF }'`

echo "$DOMAIN;$OWNER;$OWNERID;$RESPONSIBLE;$COUNTRY;$OWNER_C;$ADMIN_C;$TECH_C;$BILLING_C;$PERSON;$EMAIL"
