#!/usr/bin/env bash
KEY_ID="4701DZ67F5TFYZ030HQJ"
KEY_SECRET="GS6e3rBRNp9f4tUBtKCfgw1V5TEasQPhBaRSVzE1"
DATE=`date -u -R`
echo ${DATE}
BUCKET="demo"
contentType=""
ContentMD5=""

stringToSign="PUT\n${ContentMD5}\n${contentType}\n${DATE}\n/${BUCKET}/"
echo ${stringToSign}
signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${KEY_SECRET} -binary | base64`
echo ${signature}
HOST="$BUCKET.cephdevel:8000"
curl -s -v -X PUT "http://${HOST}/" \
-H "Authorization: AWS ${KEY_ID}:${signature}" \
-H "Date: ${DATE}" \
-H "Host: ${HOST}"
