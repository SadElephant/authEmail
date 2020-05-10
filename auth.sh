#!/bin/bash

login="login"
pass="123123"
USER_AGENT="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:67.0) Gecko/20100101 Firefox/67.0"

curl -A "$USER_AGENT" -c /tmp/onlime.cookies http://xn--80akaohdbdht3b.xn--p1ai/ > ~/mail.txt

#Данные лоя авторизации ( смотри js auth3() на сайте)
key=$(sed -n 's/.*var key = "\(.*\)";.*/\1/p' ~/mail.txt)
remote_addr=$(sed -n "s/.*var remote_addr = '\(.*\)';.*/\1/p" ~/mail.txt)
passvord=$( echo -n $pass | md5sum | cut -d" " -f1)
hash_login_passvord=$(echo -n "$passvord" | openssl dgst -sha1 -hmac "$login" | sed -e 's/^.* //')
key_hash=$(echo -n "$key$remote_addr" | openssl dgst -sha1 -hmac "$hash_login_passvord" | sed -e 's/^.* //')
passvord=$(echo -n "$login" | openssl dgst -sha1 -hmac  "$passvord" | sed -e 's/^.* //')

#Авторизация
curl -A "$USER_AGENT" -b /tmp/onlime.cookies -c /tmp/onlime.cookies "http://xn--80akaohdbdht3b.xn--p1ai/?m=login2&l2=$login&key=$key_hash&password=$passvord">>/dev/null

#поддержать бонусный счёт
curl  -A "$USER_AGENT" -b /tmp/onlime.cookies -c /tmp/onlime.cookies -d "b1edbab109=vvmke" "http://xn--80akaohdbdht3b.xn--p1ai/?m=bonus" >> /dev/null

#разлогиниваемся
curl  -A "$USER_AGENT" -b /tmp/onlime.cookies -c /tmp/onlime.cookies  "http://xn--80akaohdbdht3b.xn--p1ai/?m=login2&quit=1" >> /dev/null
#pwd
