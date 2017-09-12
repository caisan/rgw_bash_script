#!/usr/bin/env bash
KEY_ID="7M76OJBTHHPEFJS4F8T2"
KEY_SECRET="1NwDZkEPBxH7vccGKkBbVU1FEOK256wAxj1Ysdtl"
DATE=`date -u -R`

BUCKET="Test"
contentType=""
ContentMD5=""
stringToSign="GET\n${ContentMD5}\n${contentType}\n${DATE}\n/$BUCKET/?policy"
signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${KEY_SECRET} -binary | base64`

HOST="$BUCKET.cephdevel:8000"
uri="http://${HOST}/?policy"

curl -s -v -X GET ${uri} \
-H "Authorization: AWS ${KEY_ID}:${signature}" \
-H "Date: ${DATE}" \
-H "Host: ${HOST}" | jq .
