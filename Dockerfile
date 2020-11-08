FROM alpine:latest

RUN apk add --no-cache \
	bash

COPY ./entrypoint.sh /root/

RUN chmod 755 /root/*.sh

ENTRYPOINT ["/root/entrypoint.sh"]
