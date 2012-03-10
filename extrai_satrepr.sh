#!/bin/bash
./gparse.sh claro tv assinar > urls.txt
./gparse.sh claro tv assine >> urls.txt
./gparse.sh claro tv hd assine >> urls.txt
./gparse.sh claro tv assinatura >> urls.txt
./gparse.sh claro tv adquira >> urls.txt
./gparse.sh claro tv hd assine >> urls.txt
./gparse.sh via embratel assine >> urls.txt
./gparse.sh viaembratel assine >> urls.txt
./gparse.sh via embratel assinar >> urls.txt
./gparse.sh viaembratel assinar >> urls.txt
./gparse.sh via embratel assinatura >> urls.txt
./gparse.sh viaembratel assinatura >> urls.txt
./gparse.sh tv satelite >> urls.txt
./gparse.sh tv satelite assine >> urls.txt
./gparse.sh sky assine >> urls.txt
./gparse.sh sky fit assine >> urls.txt
./gparse.sh sky assinar >> urls.txt
./gparse.sh sky assinatura >> urls.txt
./gparse.sh sky parceiro credenciado >> urls.txt
./gparse.sh claro tv parceiro credenciado >> urls.txt
./gparse.sh via embratel parceiro credenciado >> urls.txt
./gparse.sh sky representante >> urls.txt
./gparse.sh claro representante >> urls.txt
./gparse.sh via embratel representante >> urls.txt
cat urls.txt | awk '{gsub("http://|/.*","")}1' > domains.txt
cat domains.txt | awk '!($0 in a) {a[$0];print}' > domains_filtered.txt
cat domains_filtered.txt | grep embratel > domains_ok.txt
cat domains_filtered.txt | grep claro >> domains_ok.txt
cat domains_filtered.txt | grep sky >> domains_ok.txt
