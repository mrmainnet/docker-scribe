FROM oraclelinux:6.7

MAINTAINER Chris Ulrich <culrich@athenahealth.com>

COPY rpms /rpms

RUN yum --assumeyes install /rpms/*.rpm \
    && mkdir -p /var/spool/scribed \
    && yum --assumeyes clean all \
    && rm -rf /var/cache/yum/*

RUN ln -sf /usr/share/zoneinfo/Asia/Saigon /etc/localtime

COPY scribe.conf /etc/scribed/scribed.conf

VOLUME /etc/scribed
VOLUME /var/spool/scribed

EXPOSE 1463

CMD ["/usr/sbin/scribed", "-c", "/etc/scribed/scribed.conf"]
