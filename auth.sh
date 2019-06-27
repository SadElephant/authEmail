#!/bin/bash

login="gost"
pass="123123"
page=""
#export LANG=ru_RU.cp1251

#Авторизация
#curl -G "m=login2&l2=gost&key=95b89742860e2bba81e67d919a0b61ad0a261607&password=82566eb4c8a6c22bdc4f3fb3d6ec45ad431f627c" http://xn--80akaohdbdht3b.xn--p1ai/
#curl "http://xn--80akaohdbdht3b.xn--p1ai/?m=login2&l2=gost&key=95b89742860e2bba81e67d919a0b61ad0a261607&password=82566eb4c8a6c22bdc4f3fb3d6ec45ad431f627c"
curl http://xn--80akaohdbdht3b.xn--p1ai/ > ~/mail.txt

#Данные лоя авторизации ( смотри js auth3() на сайте)
key=$(sed -n 's/.*var key = "\(.*\)";.*/\1/p' ~/mail.txt)
remote_addr=$(sed -n "s/.*var remote_addr = '\(.*\)';.*/\1/p" ~/mail.txt)
passvord=$( echo -n $pass | md5sum | cut -d" " -f1)
hash_login_passvord=$(echo -n "$passvord" | openssl dgst -sha1 -hmac "$login" | sed -e 's/^.* //')
key_hash=$(echo -n "$key$remote_addr" | openssl dgst -sha1 -hmac "$hash_login_passvord" | sed -e 's/^.* //')
passvord=$(echo -n "$login" | openssl dgst -sha1 -hmac  "$passvord" | sed -e 's/^.* //')

curl "http://xn--80akaohdbdht3b.xn--p1ai/?m=login2&l2=$login&key=$key_hash&password=$passvord"
#curl -G "m=login2&l2=$login&key=$key_hash&password=$passvord" "http://xn--80akaohdbdht3b.xn--p1ai/"
echo $passvord




#поддержать бонусный счёт
#curl -d "b1edbab109=vvmke" http://xn--80akaohdbdht3b.xn--p1ai/?m=bonus

#разлогиниваемся
#curl -G "m=login2&quit=1" http://xn--80akaohdbdht3b.xn--p1ai/
#pwd
pwd