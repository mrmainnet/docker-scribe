FROM 1science/alpine:3.1

MAINTAINER Stas Alekseev <stas.alekseev@gmail.com>

ENV THRIFT_VERSION 0.9.3

# Install thrift, fb303
RUN apk add --update \
	  autoconf \
	  automake \
	  binutils \
	  binutils-libs \
	  bison \
	  boost \
	  boost-date_time \
	  boost-dev \
	  boost-doc \
	  boost-filesystem \
	  boost-graph \
	  boost-iostreams \
	  boost-math \
	  boost-prg_exec_monitor \
	  boost-program_options \
	  boost-python \
	  boost-random \
	  boost-regex \
	  boost-serialization \
	  boost-signals \
	  boost-system \
	  boost-thread \
	  boost-unit_test_framework \
	  boost-wave \
	  boost-wserialization \
	  expat \
	  file \
	  flex \
	  g++ \
	  gcc \
	  gdbm \
	  git \
	  gmp5 \
	  libbz2 \
	  libc-dev \
	  libevent \
	  libevent-dev \
	  libffi \
	  libgcc \
	  libgomp \
	  libltdl \
	  libstdc++ \
	  libtool \
	  linux-headers \
	  m4 \
	  make \
	  mpc1 \
	  mpfr3 \
	  musl-dbg \
	  musl-dev \
	  openssl-dev \
	  openssl-doc \
	  pcre \
	  perl \
	  pkgconf \
	  pkgconfig \
	  python \
	  python-doc \
	  python-tests \
	  py-gdbm \
	  python-dev \
	  sqlite-libs \
	  zlib-dev \
	  zlib-doc \
	&& git clone -b $THRIFT_VERSION https://git.apache.org/thrift.git \
    && cd /thrift \
    && ./bootstrap.sh \
    && ./configure \
      --without-tests --disable-static \
    && make \
    && make install \
    && cd /thrift/contrib/fb303 \
    && sed -i 's|$(thrift_home)/include/thrift|$(thrift_home)/include|' cpp/Makefile.am \
    && ./bootstrap.sh \
    && ./configure \
      --without-java --without-php --without-python --disable-static \
    && make \
    && make install \
	&& cd py \
	&& python setup.py install \
	&& make distclean \
    && cd / \
    && rm -rf /thrift \
	&& find /usr/local -type f -print | xargs file | grep 'not stripped' | cut -d: -f1 | xargs -r strip --strip-unneeded \
    && apk del \
	  autoconf \
	  automake \
	  binutils \
	  binutils-libs \
	  bison \
	  boost \
	  boost-date_time \
	  boost-dev \
	  boost-doc \
	  boost-graph \
	  boost-iostreams \
	  boost-math \
	  boost-prg_exec_monitor \
	  boost-program_options \
	  boost-python \
	  boost-random \
	  boost-regex \
	  boost-serialization \
	  boost-signals \
	  boost-thread \
	  boost-unit_test_framework \
	  boost-wave \
	  boost-wserialization \
	  file \
	  flex \
	  g++ \
	  gcc \
	  git \
	  gmp5 \
	  libc-dev \
	  libevent-dev \
	  libgomp \
	  libltdl \
	  libtool \
	  linux-headers \
	  m4 \
	  make \
	  mpc1 \
	  mpfr3 \
	  musl-dbg \
	  musl-dev \
	  openssl-dev \
	  openssl-doc \
	  pcre \
	  perl \
	  pkgconf \
	  pkgconfig \
	  python-doc \
	  python-tests \
	  py-gdbm \
	  python-dev \
	  sqlite-libs \
	  zlib-dev \
	  zlib-doc \
    && rm -rf /var/cache/apk/*

RUN apk add --update \
	  autoconf \
	  automake \
	  binutils \
	  binutils-libs \
	  bison \
	  boost \
	  boost-date_time \
	  boost-dev \
	  boost-doc \
	  boost-filesystem \
	  boost-graph \
	  boost-iostreams \
	  boost-math \
	  boost-prg_exec_monitor \
	  boost-program_options \
	  boost-python \
	  boost-random \
	  boost-regex \
	  boost-serialization \
	  boost-signals \
	  boost-system \
	  boost-thread \
	  boost-unit_test_framework \
	  boost-wave \
	  boost-wserialization \
	  file \
	  flex \
	  g++ \
	  gcc \
	  git \
	  gmp5 \
	  libc-dev \
	  libevent \
	  libevent-dev \
	  libgomp \
	  libltdl \
	  libtool \
	  linux-headers \
	  m4 \
	  make \
	  mpc1 \
	  mpfr3 \
	  musl-dbg \
	  musl-dev \
	  openssl-dev \
	  openssl-doc \
	  pcre \
	  perl \
	  pkgconf \
	  pkgconfig \
	  python-doc \
	  python-tests \
	  py-gdbm \
	  python-dev \
	  zlib-dev \
	  zlib-doc \
    && git clone https://github.com/InMobi/scribe.git \
    && cd /scribe \
	&& sed -i 's|AM_INIT_AUTOMAKE|# AM_INIT_AUTOMAKE|' configure.ac \
    && ./bootstrap.sh \
      --with-boost-system=boost_system --with-boost-filesystem=boost_filesystem --disable-static \
    && make \
    && make install \
	&& cd lib/py \
	&& python setup.py install \
	&& make distclean \
    && cd / \
    && rm -rf /scribe \
	&& (find /usr/local -type f -print | xargs file | grep 'not stripped' | cut -d: -f1 | xargs -r strip --strip-unneeded) \
    && apk del \
	  autoconf \
	  automake \
	  binutils \
	  binutils-libs \
	  bison \
	  boost \
	  boost-date_time \
	  boost-dev \
	  boost-doc \
	  boost-graph \
	  boost-iostreams \
	  boost-math \
	  boost-prg_exec_monitor \
	  boost-program_options \
	  boost-python \
	  boost-random \
	  boost-regex \
	  boost-serialization \
	  boost-signals \
	  boost-thread \
	  boost-unit_test_framework \
	  boost-wave \
	  boost-wserialization \
	  file \
	  flex \
	  g++ \
	  gcc \
	  git \
	  gmp5 \
	  libc-dev \
	  libevent-dev \
	  libgomp \
	  libltdl \
	  libtool \
	  linux-headers \
	  m4 \
	  make \
	  mpc1 \
	  mpfr3 \
	  musl-dbg \
	  musl-dev \
	  openssl-dev \
	  openssl-doc \
	  pcre \
	  perl \
	  pkgconf \
	  pkgconfig \
	  python-doc \
	  python-tests \
	  py-gdbm \
	  python-dev \
	  zlib-dev \
	  zlib-doc \
    && rm -rf /var/cache/apk/*

CMD ["/bin/bash"]
