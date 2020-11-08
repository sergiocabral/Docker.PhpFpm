#!/bin/bash

set -e;

printf "                                                     .                  \n";
printf "   ___      _                                       ":"                 \n";
printf "  / __\__ _| |__  _ __ ___  _ __   ___  ___       ___:____     |"\/"|   \n";
printf " / /  / _' | '_ \| '__/ _ \| '_ \ / _ \/ __|    ,'        '.    \  /    \n";
printf "/ /__| (_| | |_) | | | (_) | | | |  __/\__ \    |  O        \___/  |    \n";
printf "\____/\__,_|_.__/|_|  \___/|_| |_|\___||___/  ~^~^~^~^~^~^~^~^~^~^~^~^~ \n";
printf "          ___ _  _ ___                                                  \n";
printf "         | _ \ || | _ \              https://github.com                 \n";
printf "         |  _/ __ |  _/                    /sergiocabral                \n";
printf "         |_| |_||_|_|                     /Docker.PhpFpm                \n";
printf "\n";

printf "Entrypoint for docker image: PHP\n";

if [ "$PHP_VERSION" != "5" ] && [ "$PHP_VERSION" != "7" ];
then
    printf "Invalid PHP version. Use 5 or 7.\n" >> /dev/stderr;
    exit 1;
fi

printf "Using PHP version $PHP_VERSION\n";

PHP_INSTALED=$(ls -Fla /etc | grep php2 || echo "");
IS_FIRST_CONFIGURATION=$((test -z $PHP_INSTALED && echo true) || echo false);

if [ $IS_FIRST_CONFIGURATION = true ];
then
    printf "This is the FIRST RUN.\n";
else
    printf "This is NOT the first run.\n";
fi

sleep infinity;
