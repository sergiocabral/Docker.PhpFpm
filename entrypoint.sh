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

IS_FIRST_CONFIGURATION=$(which php-fpm || which php-fpm7 || echo "");
IS_FIRST_CONFIGURATION=$((test -z $IS_FIRST_CONFIGURATION && echo true) || echo false);

if [ $IS_FIRST_CONFIGURATION = true ];
then
    printf "This is the FIRST RUN.\n";

    printf "Setting repository sources.\z";

    if [ "$PHP_VERSION" == "5" ];
    then
        APK_REPOSITORY_VERSION="3.4";
    fi
    if [ "$PHP_VERSION" == "7" ];
    then
        APK_REPOSITORY_VERSION="3.12";
    fi

    echo "http://dl-cdn.alpinelinux.org/alpine/v$APK_REPOSITORY_VERSION/main" > /etc/apk/repositories;
    echo "http://dl-cdn.alpinelinux.org/alpine/v$APK_REPOSITORY_VERSION/community" >> /etc/apk/repositories;

    cat /etc/apk/repositories;
    apk update;

    printf "Installing PHP.\n";

    if [ "$PHP_VERSION" == "5" ];
    then
        apk add \
            php5-fpm \
            php5-mcrypt \
            php5-soap \
            php5-openssl \
            php5-gmp \
            php5-pdo_odbc \
            php5-json \
            php5-dom \
            php5-pdo \
            php5-zip \
            php5-mysql \
            php5-mysqli \
            php5-sqlite3 \
            php5-apcu \
            php5-pdo_pgsql \
            php5-bcmath \
            php5-gd \
            php5-xcache \
            php5-odbc \
            php5-pdo_mysql \
            php5-pdo_sqlite \
            php5-gettext \
            php5-xmlreader \
            php5-xmlrpc \
            php5-bz2 \
            php5-memcache \
            php5-mssql \
            php5-iconv \
            php5-pdo_dblib \
            php5-curl \
            php5-ctype;
    fi
    if [ "$PHP_VERSION" == "7" ];
    then
        apk add \
            php7-fpm \
            php7-mcrypt \
            php7-soap \
            php7-openssl \
            php7-gmp \
            php7-pdo_odbc \
            php7-json \
            php7-dom \
            php7-pdo \
            php7-zip \
            php7-mysqli \
            php7-sqlite3 \
            php7-apcu \
            php7-pdo_pgsql \
            php7-bcmath \
            php7-gd \
            php7-odbc \
            php7-pdo_mysql \
            php7-pdo_sqlite \
            php7-gettext \
            php7-xmlreader \
            php7-xmlrpc \
            php7-bz2 \
            php7-iconv \
            php7-pdo_dblib \
            php7-curl \
            php7-ctype;
    fi
fi

if [ "$PHP_VERSION" == "5" ];
then
    PHPFPM_EXECUTABLE_NAME="php-fpm";
    DIR_CONF="/etc/php5";
    DIR_NAME_CONF_FPM="fpm.d";
fi
if [ "$PHP_VERSION" == "7" ];
then
    PHPFPM_EXECUTABLE_NAME="php-fpm7";
    DIR_CONF="/etc/php7";
    DIR_NAME_CONF_FPM="php-fpm.d";
fi
SUFFIX_TEMPLATE=".template";
PHPFPM_EXECUTABLE=$(which $PHPFPM_EXECUTABLE_NAME || echo "");
DIR_CONF_BACKUP="$DIR_CONF.original";
DIR_CONF_DOCKER="$DIR_CONF.conf";
DIR_CONF_D="$DIR_CONF/conf.d";
DIR_CONF_FPM="$DIR_CONF/$DIR_NAME_CONF_FPM";
DIR_CONF_TEMPLATES="$DIR_CONF.templates";
DIR_CONF_D_TEMPLATES="$DIR_CONF.templates.d";
DIR_CONF_FPM_TEMPLATES="$DIR_CONF.templates.fpm";
DIR_SCRIPTS="${DIR_SCRIPTS:-/root}";

if [ $IS_FIRST_CONFIGURATION = true ];
then
    printf "Running PHP for first time.\n";

    $PHPFPM_EXECUTABLE;
    sleep 1;

    pkill $PHPFPM_EXECUTABLE_NAME || echo "";
    sleep 1;

    printf "Making configuration backup.\n";

    mkdir -p $DIR_CONF_DOCKER;
    cp -R $DIR_CONF/* $DIR_CONF_DOCKER/;
    mv $DIR_CONF $DIR_CONF_BACKUP;
    ln -s $DIR_CONF_DOCKER $DIR_CONF;

    mkdir -p $DIR_CONF_TEMPLATES;
    mkdir -p $DIR_CONF_D_TEMPLATES;
    mkdir -p $DIR_CONF_FPM_TEMPLATES;

    printf "Adjusting configuration,\n";

    if [ -f "$DIR_CONF_FPM/www.conf" ];
    then
        sed -i -e "/^listen =/ s/^/;/" $DIR_CONF_FPM/www.conf;
        echo "" >> $DIR_CONF_FPM/www.conf;
    else    
        echo "[www]" > $DIR_CONF_FPM/www.conf;
    fi
    sed -i -e "/^listen =/ s/^/;/" $DIR_CONF/php-fpm.conf;
    echo "listen = 0.0.0.0:9000" >> $DIR_CONF_FPM/www.conf;

    if [ -d "$DIR_CONF_TEMPLATES" ] && [ ! -z "$(ls -A $DIR_CONF_TEMPLATES)" ];
    then
        printf "Warning: The $DIR_CONF_TEMPLATES directory already existed and will not have its content overwritten.\n";
    else
        printf "Creating files templates in $DIR_CONF_TEMPLATES\n";

        cp $DIR_CONF/*.ini $DIR_CONF_TEMPLATES/;
        cp $DIR_CONF/*.conf $DIR_CONF_TEMPLATES/;

        ls -1 $DIR_CONF_TEMPLATES | \
            grep -v $SUFFIX_TEMPLATE | \
            xargs -I {} mv $DIR_CONF_TEMPLATES/{} $DIR_CONF_TEMPLATES/{}$SUFFIX_TEMPLATE;
    fi

    if [ -d "$DIR_CONF_D_TEMPLATES" ] && [ ! -z "$(ls -A $DIR_CONF_D_TEMPLATES)" ];
    then
        printf "Warning: The $DIR_CONF_D_TEMPLATES directory already existed and will not have its content overwritten.\n";
    else
        printf "Creating files templates in $DIR_CONF_D_TEMPLATES\n";

        cp $DIR_CONF_D/* $DIR_CONF_D_TEMPLATES/;

        ls -1 $DIR_CONF_D_TEMPLATES | \
            grep -v $SUFFIX_TEMPLATE | \
            xargs -I {} mv $DIR_CONF_D_TEMPLATES/{} $DIR_CONF_D_TEMPLATES/{}$SUFFIX_TEMPLATE;
    fi

    if [ -d "$DIR_CONF_FPM_TEMPLATES" ] && [ ! -z "$(ls -A $DIR_CONF_FPM_TEMPLATES)" ];
    then
        printf "Warning: The $DIR_CONF_FPM_TEMPLATES directory already existed and will not have its content overwritten.\n";
    else
        printf "Creating files templates in $DIR_CONF_FPM_TEMPLATES\n";

        cp $DIR_CONF_FPM/* $DIR_CONF_FPM_TEMPLATES/;

        ls -1 $DIR_CONF_FPM_TEMPLATES | \
            grep -v $SUFFIX_TEMPLATE | \
            xargs -I {} mv $DIR_CONF_FPM_TEMPLATES/{} $DIR_CONF_FPM_TEMPLATES/{}$SUFFIX_TEMPLATE;
    fi
    
    USER=root;
    chown -R $USER:$USER $DIR_CONF_BACKUP;
    chown -R $USER:$USER $DIR_CONF_DOCKER;
    chown -R $USER:$USER $DIR_CONF_TEMPLATES;
    chown -R $USER:$USER $DIR_CONF_D_TEMPLATES;
    chown -R $USER:$USER $DIR_CONF_FPM_TEMPLATES;

    printf "Configured directories:\n";

    ls -Flad $DIR_CONF*;
else
    printf "This is NOT the first run.\n";
fi

printf "Tip: Use files $DIR_CONF_TEMPLATES/*$SUFFIX_TEMPLATE to make the files in the $DIR_CONF directory with replacement of environment variables with their values.\n";
$DIR_SCRIPTS/envsubst-files.sh "$SUFFIX_TEMPLATE" "$DIR_CONF_TEMPLATES" "$DIR_CONF";
printf "Tip: Use files $DIR_CONF_D_TEMPLATES/*$SUFFIX_TEMPLATE to make the files in the $DIR_CONF_D directory with replacement of environment variables with their values.\n";
$DIR_SCRIPTS/envsubst-files.sh "$SUFFIX_TEMPLATE" "$DIR_CONF_D_TEMPLATES" "$DIR_CONF_D";
printf "Tip: Use files $DIR_CONF_FPM_TEMPLATES/*$SUFFIX_TEMPLATE to make the files in the $DIR_CONF_FPM directory with replacement of environment variables with their values.\n";
$DIR_SCRIPTS/envsubst-files.sh "$SUFFIX_TEMPLATE" "$DIR_CONF_FPM_TEMPLATES" "$DIR_CONF_FPM";

$PHPFPM_EXECUTABLE;

sleep infinity;
