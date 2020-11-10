# Docker.PhpFpm

PHP as FastCGI Process Manager (FPM) server. Server to process PHP scripts on demand through FastCGI.

## Configuration

It is possible to configure the service through the `php.ini` and `*.conf` files.

It is possible to use template `php.ini.template` and `*.conf.template` files to generate the final files with the appropriate substitutions of the values of the environment variables.

## Environment Variables

**Configuring your services or websites:**

`PHP_VERSION` = `5` or `7`

- Mandatory value.
- Inform the version for PHP processor.

## Suggested Directory Volumes

`/etc/php7.templates`
`/etc/php7.templates.d`
`/etc/php7.templates.fpm`

- Use files `*.template` in these directories to make the files in the respective directory without `.template` part. The final files will have the replacement of environment variables with their values.

`/etc/php7.conf`

- Configuration directory used by the PHP processor. All configuration files are here.
- The default `/etc/php7/` directory is a symbolic link that points to this directory.

`/home`

- Suggest host directories of each websites.
- Set the same value in the nginx container.

`/var/log`

- Log files for PHP processor.

NOTE: If variable `PHP_VERSION` is `5` consider above names `php7` as `php5`.

## Exposed Port

The default port for PHP FastCGI Process Manager (PHP-FPM) server is 9000.

## Example for *docker-compose.yml*

```
version: "3.3"
services:
  php5:
    image: sergiocabral/phpfpm
    ports:
      - 9000:9000
    volumes:      
      - /docker-volumes/php7/templates:/etc/php7.templates
      - /docker-volumes/php7/templates.d:/etc/php7.templates.d
      - /docker-volumes/php7/templates.fpm:/etc/php7.templates.fpm
      - /docker-volumes/php7/conf:/etc/php7.conf
      - /docker-volumes/php7/log:/var/log
      - /docker-volumes/nginx/sites:/home/
    environment:
      - PHP_VERSION=7
```

NOTE AGAIN: If variable `PHP_VERSION` is `5` consider above names `php7` as `php5`.
