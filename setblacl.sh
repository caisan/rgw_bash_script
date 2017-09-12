#!/usr/bin/env bash
KEY_ID="7M76OJBTHHPEFJS4F8T2"
KEY_SECRET="1NwDZkEPBxH7vccGKkBbVU1FEOK256wAxj1Ysdtl"
DATE=`date -u -R`

BUCKET="TBucket"
contentType="application/xml"
ContentMD5=""
reqc="<AccessControlPolicy xmlns=\"http://s3.amazonaws.com/doc/2006-03-01/\">
<Owner>
<ID>test</ID>
<DisplayName>test</DisplayName>
</Owner>
  <AccessControlList>
    <Grant>
      <Grantee xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:type=\"CanonicalUser\">
      <ID>test</ID>
      <DisplayName>test</DisplayName>
      </Grantee>
      <Permission>FULL_CONTROL</Permission>
    </Grant>
    <Grant>
      <Grantee xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:type=\"CanonicalUser\">
      <ID>bl_deliver</ID>
      <DisplayName>user_bl_deliver</DisplayName>
      </Grantee>
      <Permission>WRITE</Permission>
    </Grant>
   <Grant>
      <Grantee xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:type=\"CanonicalUser\">
      <ID>bl_deliver</ID>
      <DisplayName>user_bl_deliver</DisplayName>
      </Grantee>
      <Permission>READ_ACP</Permission>
    </Grant>
  </AccessControlList>
</AccessControlPolicy>"

stringToSign="PUT\n${ContentMD5}\n${contentType}\n${DATE}\n/$BUCKET/?acl"

signature=`echo -en ${stringToSign} | openssl sha1 -hmac ${KEY_SECRET} -binary | base64`

HOST="$BUCKET.cephdevel:8000"
uri="http://${HOST}/?acl"

curl -s -v -X PUT ${uri} \
-H "Authorization: AWS ${KEY_ID}:${signature}" \
-H "Date: ${DATE}" \
-H "Host: ${HOST}" \
-H "Content-Type: ${contentType}" \
-d "${reqc}"

