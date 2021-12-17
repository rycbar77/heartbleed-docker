FROM debian:jessie

ENV LANG C.UTF-8

RUN  sed -i s@/deb.debian.org/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list

RUN  sed -i s@/security.debian.org/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list


# Apt packages
RUN dpkg --add-architecture i386 && apt-get update && \
    apt-get install -qy \
    git apache2 \
    build-essential \
    libc6-dbg \
    libc6-dbg:i386 \
    gcc-multilib \
    gdb-multiarch \
    gcc \
    wget \
    curl \
    vim \
    glibc-source \
    php5 \
    cmake && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    cd ~ && tar -xf /usr/src/glibc/glib*.tar.xz

RUN wget http://snapshot.debian.org/archive/debian/20130319T033933Z/pool/main/o/openssl/openssl_1.0.1e-2_amd64.deb -O /tmp/openssl_1.0.1e-2_amd64.deb && \
 dpkg -i /tmp/openssl_1.0.1e-2_amd64.deb

RUN wget http://snapshot.debian.org/archive/debian/20130319T033933Z/pool/main/o/openssl/libssl1.0.0_1.0.1e-2_amd64.deb -O /tmp/libssl1.0.0_1.0.1e-2_amd64.deb && \
 dpkg -i /tmp/libssl1.0.0_1.0.1e-2_amd64.deb

ENV DEBIAN_FRONTEND noninteractive

# Setup vulnerable web server and enable SSL based Apache instance
ADD index.php /var/www/html/
RUN a2enmod ssl && \
    a2dissite 000-default.conf && \
    a2ensite default-ssl

# Clean up 
RUN apt-get autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose the port for usage with the docker -P switch
EXPOSE 443

# Run Apache 2
# CMD [/usr/sbin/apache2ctl", "-D FOREGROUND"," &"]

CMD ["/bin/bash"]
#
# Dockerfile for vulnerability as a service - CVE-2014-0160
# Vulnerable web server included, using old libssl version
#
