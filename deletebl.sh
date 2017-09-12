#!/usr/bin/env bash
KEY_ID="7M76OJBTHHPEFJS4F8T2"
KEY_SECRET="1NwDZkEPBxH7vccGKkBbVU1FEOK256wAxj1Ysdtl"
DATE=`date -u -R`

contentType="application/xml"
ContentMD5=""
reqcon='
<BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01">
</BucketLoggingStatus>'

for i in {0..10}
do
BUCKET="Test$i"
stringToSign="PUT\n${ContentMD5}\n${contentType}\n${DATE}\n/$BUCKET/?logging"
signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${KEY_SECRET} -binary | base64`

HOST="$BUCKET.cephdevel:8000"
uri="http://${HOST}/?logging"
    curl -s -v -X PUT {$uri} \
    -H "Authorization: AWS ${KEY_ID}:${signature}" \
    -H "Date: ${DATE}" \
    -H "Host: ${HOST}" \
    -H "Content-Type: ${contentType}" \
    -d "${reqcon}"
    sleep 3
done
