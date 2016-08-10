FROM java:alpine

ADD https://raw.githubusercontent.com/colstrom/package.sh/master/bin/package /usr/local/sbin/package
ADD https://raw.githubusercontent.com/colstrom/package.sh/master/bin/package.apk /usr/local/sbin/package.apk

RUN chmod +x /usr/local/sbin/*
RUN package install openssl
RUN wget -O - https://github.com/just-containers/s6-overlay/releases/download/v1.18.1.3/s6-overlay-amd64.tar.gz | tar xzC /

RUN mkdir -p /package/host/github.com/adamw/elasticmq-0.9.3
RUN wget -O /package/host/github.com/adamw/elasticmq-0.9.3/elasticmq-server.jar https://s3-eu-west-1.amazonaws.com/softwaremill-public/elasticmq-server-0.9.3.jar
RUN ln -s /package/host/github.com/adamw/elasticmq-0.9.3 /package/host/github.com/adamw/elasticmq

ADD service /etc/services.d/elasticmq

EXPOSE 9324

ENTRYPOINT ["/init"]
