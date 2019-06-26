#!/bin/bash

login="gost"
pass="123123"

#Авторизация
curl -G "m=login2&l2=gost&key=95b89742860e2bba81e67d919a0b61ad0a261607&password=82566eb4c8a6c22bdc4f3fb3d6ec45ad431f627c" http://xn--80akaohdbdht3b.xn--p1ai/


#поддержать бонусный счёт

#разлогиниваемся
curl -G "m=login2&quit=1" http://xn--80akaohdbdht3b.xn--p1ai/
pwd