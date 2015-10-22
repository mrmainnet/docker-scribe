FROM 1science/alpine:3.1

MAINTAINER Stas Alekseev <stas.alekseev@gmail.com>

RUN apk add --update \
      file \
      boost-dev \
      git \
      gcc \
      g++ \
      make \
      expat \
      libtool \
      automake \
      autoconf \
      openssl-dev \
      libevent-dev \
      bison \
      flex \
    && git clone -b 0.9.3 https://github.com/apache/thrift.git \
    && cd /thrift \
    && ./bootstrap.sh \
    && ./configure \
      --with-java=no --with-erlang=no --with-php=no --with-perl=no --with-php_extension=no --with-ruby=no --with-haskell=no --with-go=no \
    && make \
    && make install \
    && cd /thrift/contrib/fb303 \
    && ./bootstrap.sh \
    && ./configure \
      --without-java --without-php \
    && make \
    && make install \
    && cd / \
    && rm -rf /thrift \
    && git clone https://github.com/facebook/scribe.git \
    && cd /scribe \
    && ./bootstrap.sh \
    && ./configure \
      CPPFLAGS="-DHAVE_INTTYPES_H -DHAVE_NETINET_IN_H -DBOOST_FILESYSTEM_VERSION=2" LIBS="-lboost_system -lboost_filesystem" \
    && make \
    && make install \
    && cd / \
    && rm -rf /scribe \
    && apk remove \
      file \
      boost-dev \
      boost-doc \
      git \
      gcc \
      g++ \
      make \
      expat \
      libtool \
      automake \
      autoconf \
      openssl-doc \
      openssl-dev \
      perl \
      m4 \
      musl-dbg \
      musl-dev \
      libc-dev \
      linux-headers \
      binutils \
      libevent-dev \
      bison \
      flex \
      zlib-doc \
      zlib-dev \
    && rm -rf /var/cache/apk/*

CMD ["/bin/bash"]
