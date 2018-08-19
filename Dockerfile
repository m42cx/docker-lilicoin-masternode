FROM frolvlad/alpine-glibc
MAINTAINER Oliver Gugger <gugger@gmail.com>

ENV USER container
ENV HOME /home/container

RUN apk add --update --no-cache curl ca-certificates openssl libstdc++ \
    && apk add libc++ --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    && adduser -D -h /home/container container

RUN wget -O /tmp/container.tar.gz "https://terracoin.io/bin/terracoin-core-0.12.2.4/terracoin-0.12.2-x86_64-linux-gnu.tar.gz" \
    && cd /tmp/ \
    && tar zxvf container.tar.gz \
    && mv /tmp/terracoin-* /home/container/terracoin \
    && chown -R container:container /home/container \
    && rm -rf /tmp/*

RUN set -x \
    && apk add --update --no-cache python python-dev py-pip build-base git \
    && mkdir -p /sentinel \
    && cd /sentinel \
    && git clone https://github.com/terracoin/sentinel.git . \
    && pip install virtualenv \
    && virtualenv ./venv \
    && ./venv/bin/pip install -r requirements.txt \
    && touch sentinel.log \
    && chown -R ${USER} /sentinel \
    && echo '* * * * * '${USER}' cd /sentinel && SENTINEL_DEBUG=1 ./venv/bin/python bin/sentinel.py >> sentinel.log 2>&1' >> crontab.txt \
    && /usr/bin/crontab crontab.txt 

EXPOSE 13333 13332

WORKDIR ${HOME}

USER container
VOLUME ["${HOME}/.terracoincore"]
ADD ./entrypoint.sh /entrypoint.sh
CMD ["/bin/ash", "/entrypoint.sh"]

