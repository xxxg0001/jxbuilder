FROM centos:centos6

RUN yum install -y tar
RUN yum install -y gcc g++ gcc-c++
RUN  yum install -y glibc-devel.i686
RUN yum install -y libuuid-devel.i686
RUN yum install -y ncurses-devel.i686
RUN yum install -y libstdc++.i686

ADD tool /tool
WORKDIR /tool

#RUN curl -O https://storage.googleapis.com/golang/go1.4.linux-amd64.tar.gz
#RUN curl -O http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.5.tar.gz

#install golang
#
RUN rm -rf /usr/local/go
RUN tar -C /usr/local -xzf go1.4.linux-amd64.tar.gz

#install ruby
#
RUN tar -zxvf ruby-2.1.5.tar.gz
WORKDIR  ruby-2.1.5
RUN ./configure
RUN make && make install && make clean

#clean
#
RUN rm -rf /tool

#
ADD dev_tools /usr/dev_tools
WORKDIR /usr/dev_tools
RUN chmod 777 *
ENV PATH=$PATH:/usr/dev_tools:/usr/local/go/bin
ENV GOPATH=/gocode
RUN yum -y remove tar
