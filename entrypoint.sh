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

if [ "$PHP_VERSION" != "5" ] && [ "$PHP_VERSION" != "7" ] && [ "$PHP_VERSION" != "8" ] && [ "$PHP_VERSION" != "8.1" ] && [ "$PHP_VERSION" != "8.2" ];
then
    printf "Invalid PHP version. Use 5, 7, 8, 8.1 or 8.2\n" >> /dev/stderr;
    exit 1;
fi

printf "Using PHP version $PHP_VERSION\n";

IS_FIRST_CONFIGURATION=$(which php-fpm || which php-fpm7 || which php-fpm8 || printf "");
IS_FIRST_CONFIGURATION=$((test -z $IS_FIRST_CONFIGURATION && echo true) || echo false);

if [ $IS_FIRST_CONFIGURATION = true ];
then
    printf "This is the FIRST RUN.\n";

    printf "Setting repository sources.\z";

    if [ "$PHP_VERSION" == "5" ];
    then
        echo "http://dl-cdn.alpinelinux.org/alpine/v3.4/main" > /etc/apk/repositories;
        echo "http://dl-cdn.alpinelinux.org/alpine/v3.4/community" >> /etc/apk/repositories;
    fi
    if [ "$PHP_VERSION" == "7" ];
    then
        echo "http://dl-cdn.alpinelinux.org/alpine/v3.15/main" > /etc/apk/repositories;
        echo "http://dl-cdn.alpinelinux.org/alpine/v3.15/community" >> /etc/apk/repositories;
    fi
    if [ "$PHP_VERSION" == "8" ];
    then
        echo "http://dl-cdn.alpinelinux.org/alpine/v3.16/main" > /etc/apk/repositories;
        echo "http://dl-cdn.alpinelinux.org/alpine/v3.16/community" >> /etc/apk/repositories;
    fi
    if [ "$PHP_VERSION" == "8.1" ];
    then
        echo "http://dl-cdn.alpinelinux.org/alpine/v3.17/main" > /etc/apk/repositories;
        echo "http://dl-cdn.alpinelinux.org/alpine/v3.17/community" >> /etc/apk/repositories;
    fi
    if [ "$PHP_VERSION" == "8.2" ];
    then
        # TODO: Trocar, quando disponível, para versão específica do repositório do alpine.
        echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories;
        echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories;
        echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories;
    fi

    cat /etc/apk/repositories;
    apk update;

    printf "Installing PHP.\n";

    if [ "$PHP_VERSION" == "5" ];
    then
#           php5 \
#           php5-apache2 \
        apk add \
            openssl \
            php5-apcu \
            php5-bcmath \
            php5-bz2 \
            php5-calendar \
            php5-cgi \
            php5-cli \
            php5-common \
            php5-ctype \
            php5-curl \
            php5-dba \
            php5-dbg \
            php5-dev \
            php5-doc \
            php5-dom \
            php5-embed \
            php5-enchant \
            php5-exif \
            php5-fpm \
            php5-ftp \
            php5-gd \
            php5-gettext \
            php5-gmp \
            php5-iconv \
            php5-imap \
            php5-intl \
            php5-json \
            php5-ldap \
            php5-mailparse \
            php5-mcrypt \
            php5-memcache \
            php5-mssql \
            php5-mysql \
            php5-mysqli \
            php5-odbc \
            php5-opcache \
            php5-openssl \
            php5-pcntl \
            php5-pdo \
            php5-pdo_dblib \
            php5-pdo_mysql \
            php5-pdo_odbc \
            php5-pdo_pgsql \
            php5-pdo_sqlite \
            php5-pear \
            php5-pear-auth_sasl \
            php5-pear-mail_mime \
            php5-pear-mdb2 \
            php5-pear-mdb2-driver-mysql \
            php5-pear-mdb2-driver-mysqli \
            php5-pear-mdb2-driver-pgsql \
            php5-pear-mdb2-driver-sqlite \
            php5-pear-net_idna2 \
            php5-pear-net_smtp \
            php5-pear-net_socket \
            php5-pgsql \
            php5-phalcon \
            php5-phar \
            php5-phpdbg \
            php5-phpmailer \
            php5-posix \
            php5-pspell \
            php5-shmop \
            php5-snmp \
            php5-soap \
            php5-sockets \
            php5-sqlite3 \
            php5-sysvmsg \
            php5-sysvsem \
            php5-sysvshm \
            php5-wddx \
            php5-xcache \
            php5-xml \
            php5-xmlreader \
            php5-xmlrpc \
            php5-xsl \
            php5-zip \
            php5-zlib;
    fi
    if [ "$PHP_VERSION" == "7" ];
    then
#           php7 \
#           php7-apache2 \
        apk add \
            openssl \
            php7-bcmath \
            php7-brotli \
            php7-bz2 \
            php7-calendar \
            php7-cgi \
            php7-common \
            php7-ctype \
            php7-curl \
            php7-dba \
            php7-dbg \
            php7-dev \
            php7-doc \
            php7-dom \
            php7-embed \
            php7-enchant \
            php7-exif \
            php7-ffi \
            php7-fileinfo \
            php7-fpm \
            php7-ftp \
            php7-gd \
            php7-gettext \
            php7-gmp \
            php7-iconv \
            php7-imap \
            php7-intl \
            php7-json \
            php7-ldap \
            php7-litespeed \
            php7-mbstring \
            php7-mysqli \
            php7-mysqlnd \
            php7-odbc \
            php7-opcache \
            php7-openssl \
            php7-pcntl \
            php7-pdo \
            php7-pdo_dblib \
            php7-pdo_mysql \
            php7-pdo_odbc \
            php7-pdo_pgsql \
            php7-pdo_sqlite \
            php7-pear \
            php7-pecl-amqp \
            php7-pecl-apcu \
            php7-pecl-ast \
            php7-pecl-couchbase \
            php7-pecl-event \
            php7-pecl-gmagick \
            php7-pecl-igbinary \
            php7-pecl-lzf \
            php7-pecl-mailparse \
            php7-pecl-maxminddb \
            php7-pecl-mcrypt \
            php7-pecl-memcache \
            php7-pecl-memcached \
            php7-pecl-mongodb \
            php7-pecl-msgpack \
            php7-pecl-oauth \
            php7-pecl-protobuf \
            php7-pecl-psr \
            php7-pecl-rdkafka \
            php7-pecl-redis \
            php7-pecl-ssh2 \
            php7-pecl-timezonedb \
            php7-pecl-uploadprogress \
            php7-pecl-uploadprogress-doc \
            php7-pecl-uuid \
            php7-pecl-vips \
            php7-pecl-xdebug \
            php7-pecl-xhprof \
            php7-pecl-xhprof-assets \
            php7-pecl-yaml \
            php7-pecl-zmq \
            php7-pecl-zstd \
            php7-pgsql \
            php7-phalcon \
            php7-phar \
            php7-phpdbg \
            php7-posix \
            php7-pspell \
            php7-session \
            php7-shmop \
            php7-simplexml \
            php7-snmp \
            php7-soap \
            php7-sockets \
            php7-sodium \
            php7-sqlite3 \
            php7-sysvmsg \
            php7-sysvsem \
            php7-sysvshm \
            php7-tideways_xhprof \
            php7-tidy \
            php7-tokenizer \
            php7-xml \
            php7-xmlreader \
            php7-xmlrpc \
            php7-xmlwriter \
            php7-xsl \
            php7-zip;
    fi
    if [ "$PHP_VERSION" == "8" ];
    then
#           php8 \
#           php8-apache2 \
#           php8-pecl-couchbase \
        apk add \
            openssl \
	    php8-bcmath \
            php8-brotli \
            php8-bz2 \
            php8-calendar \
            php8-cgi \
            php8-common \
            php8-ctype \
            php8-curl \
            php8-dba \
            php8-dbg \
            php8-dev \
            php8-doc \
            php8-dom \
            php8-embed \
            php8-enchant \
            php8-exif \
            php8-ffi \
            php8-fileinfo \
            php8-fpm \
            php8-ftp \
            php8-gd \
            php8-gettext \
            php8-gmp \
            php8-iconv \
            php8-imap \
            php8-intl \
            php8-ldap \
            php8-litespeed \
            php8-mbstring \
            php8-mysqli \
            php8-mysqlnd \
            php8-odbc \
            php8-opcache \
            php8-openssl \
            php8-pcntl \
            php8-pdo \
            php8-pdo_dblib \
            php8-pdo_mysql \
            php8-pdo_odbc \
            php8-pdo_pgsql \
            php8-pdo_sqlite \
            php8-pear \
            php8-pecl-amqp \
            php8-pecl-apcu \
            php8-pecl-ast \
            php8-pecl-event \
            php8-pecl-igbinary \
            php8-pecl-lzf \
            php8-pecl-mailparse \
            php8-pecl-maxminddb \
            php8-pecl-mcrypt \
            php8-pecl-memcache \
            php8-pecl-memcached \
            php8-pecl-mongodb \
            php8-pecl-msgpack \
            php8-pecl-oauth \
            php8-pecl-protobuf \
            php8-pecl-psr \
            php8-pecl-rdkafka \
            php8-pecl-redis \
            php8-pecl-ssh2 \
            php8-pecl-swoole \
            php8-pecl-swoole-dev \
            php8-pecl-timezonedb \
            php8-pecl-uploadprogress \
            php8-pecl-uploadprogress-doc \
            php8-pecl-uuid \
            php8-pecl-vips \
            php8-pecl-xdebug \
            php8-pecl-xhprof \
            php8-pecl-xhprof-assets \
            php8-pecl-yaml \
            php8-pecl-zstd \
            php8-pgsql \
            php8-phar \
            php8-phpdbg \
            php8-posix \
            php8-pspell \
            php8-session \
            php8-shmop \
            php8-simplexml \
            php8-snmp \
            php8-soap \
            php8-sockets \
            php8-sodium \
            php8-sqlite3 \
            php8-sysvmsg \
            php8-sysvsem \
            php8-sysvshm \
            php8-tideways_xhprof \
            php8-tidy \
            php8-tokenizer \
            php8-xml \
            php8-xmlreader \
            php8-xmlwriter \
            php8-xsl \
            php8-zip;
    fi
    if [ "$PHP_VERSION" == "8.1" ];
    then
        apk add \
            openssl \
            php81-fpm \
            php81-pecl-mcrypt \
            php81-soap \
            php81-openssl \
            php81-gmp \
            php81-pdo_odbc \
            php81-json \
            php81-dom \
            php81-pdo \
            php81-zip \
            php81-mysqli \
            php81-sqlite3 \
            php81-apcu \
            php81-pdo_pgsql \
            php81-bcmath \
            php81-gd \
            php81-odbc \
            php81-pdo_mysql \
            php81-pdo_sqlite \
            php81-gettext \
            php81-xmlreader \
            php81-pecl-xmlrpc \
            php81-bz2 \
            php81-iconv \
            php81-pdo_dblib \
            php81-curl \
            php81-ctype \
            php81-mbstring \
            php81-tokenizer \
            php81-common \
            php81-xml \
            php81-session;
    fi
    if [ "$PHP_VERSION" == "8.2" ];
    then
        apk add \
            openssl \
            php82-fpm \
            php82-pecl-mcrypt \
            php82-soap \
            php82-openssl \
            php82-gmp \
            php82-pdo_odbc \
            php82-json \
            php82-dom \
            php82-pdo \
            php82-zip \
            php82-mysqli \
            php82-sqlite3 \
            php82-apcu \
            php82-pdo_pgsql \
            php82-bcmath \
            php82-gd \
            php82-odbc \
            php82-pdo_mysql \
            php82-pdo_sqlite \
            php82-gettext \
            php82-xmlreader \
            php82-pecl-xmlrpc \
            php82-bz2 \
            php82-iconv \
            php82-pdo_dblib \
            php82-curl \
            php82-ctype \
            php82-mbstring \
            php82-tokenizer \
            php82-common \
            php82-xml \
            php82-session;
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
if [ "$PHP_VERSION" == "8" ];
then
    PHPFPM_EXECUTABLE_NAME="php-fpm8";
    DIR_CONF="/etc/php8";
    DIR_NAME_CONF_FPM="php-fpm.d";
fi
if [ "$PHP_VERSION" == "8.1" ];
then
    PHPFPM_EXECUTABLE_NAME="php-fpm81";
    DIR_CONF="/etc/php81";
    DIR_NAME_CONF_FPM="php-fpm.d";
fi
if [ "$PHP_VERSION" == "8.2" ];
then
    PHPFPM_EXECUTABLE_NAME="php-fpm82";
    DIR_CONF="/etc/php82";
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
    echo "listen = [::]:9000" >> $DIR_CONF_FPM/www.conf;
    echo "access.log = /var/log/$pool.access.log" >> $DIR_CONF_FPM/www.conf;

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
