FROM centos:centos6
MAINTAINER Arnaud Meuret <arnaud@actime.biz>

RUN yum update -y					\
 && yum groupinstall -y 'Development tools'		\
 && yum -y install zlib-devel openssl-devel cpio expat-devel gettext-devel curl-devel sqlite-devel tar perl-ExtUtils-MakeMaker \
 && yum clean all

# Install git from source
RUN curl -L https://www.kernel.org/pub/software/scm/git/git-2.5.2.tar.gz | tar xz \
 && cd git-*					\
 && make prefix=/usr/local			\
 && make prefix=/usr/local install		\
 && cd / && rm -rf git-*

# Install ZeroMQ from source
RUN curl -L http://download.zeromq.org/zeromq-4.0.5.tar.gz | tar xz \
 && cd zeromq*					\
 && ./configure					\
 && make					\
 && make install				\
 && ldconfig /usr/local/lib			\
 && cd / && rm -rf zeromq*

# Install libsqlite 3.8.7 from source
# because CentOS5 includes 3.8.6 which lacks sqlite3_prepare_v2()
#RUN curl -L https://www.sqlite.org/2014/sqlite-autoconf-3080700.tar.gz | tar xz	\
# && cd sqlite*					\
# && ./configure					\
# && make					\
# && make install				\
# && ldconfig /usr/local/lib			\
# && cd / && rm -rf sqlite*


RUN git clone --depth 1 https://github.com/mongrel2/mongrel2.git \
 && cd mongrel2* 				\
 && make clean all				\
 && make install                                \
 && cd / && rm -rf mongrel2*

RUN groupadd -g 500 -o web \
 && useradd -u 500 -o -g 500 web

EXPOSE 8080
CMD mongrel2 /etc/mongrel2/config.sqlite d2c7aa90-400f-0133-c091-56847afe9799

