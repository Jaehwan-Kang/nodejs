#!/bin/bash
# git webhook scripts : git clone https://github.com/velopert/nodejs-github-webhook.git

# Only Config File handling

# DIRECTORY TO THE REPOSITORY
_REPOSITORY="/usr/local/nginx/conf"
cd $_REPOSITORY;

echo "=============== START `date +%Y%m%d"-"%H%M%S` ================";
/usr/bin/git pull;


# Nginx 
function Nginx {
    /usr/local/nginx/sbin/nginx -t &> /root/tmp;
    _Return01=`cat /root/tmp| head -1 | tail -1`;
    _Return02=`cat /root/tmp| head -2 | tail -1`;
    _Checkok01=`echo $_Return01 | grep "syntax is ok"`;
    _Checkok02=`echo $_Return02 | grep "test is successful"`;
    _Checkfail01=`echo $_Return01 | grep "emerg"`;
    _Checkfail02=`echo $_Return02 | grep "test failed"`;

    if [ "$_Checkok01" != "" -a "$_Checkok02" != "" ]
        then
            echo "Syntax All ok";
            /usr/local/nginx/sbin/nginx -s stop;
            /usr/local/nginx/sbin/nginx;
            echo "Nginx Restarted";
        else
            echo "$_Checkfail01";
            echo "Please check nginx.conf is syntax failed";
    fi
    echo "===============  END  `date +%Y%m%d"-"%H%M%S` ================";
}

Nginx;