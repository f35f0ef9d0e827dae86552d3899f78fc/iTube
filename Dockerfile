FROM debian:jessie
MAINTAINER Gabriel Eckerson 014@savemetechs.net

RUN apt-get update && \
    apt-get upgrade -y

RUN apt-get -y install build-essential libpcre3 libpcre3-dev libssl-dev wget unzip && \
    mkdir /usr/build && \
    cd /usr/build && \
        wget http://nginx.org/download/nginx-1.9.9.tar.gz && \
        wget https://github.com/arut/nginx-rtmp-module/archive/master.zip && \
        wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-64bit-static.tar.xz && \
        tar -xvf nginx-1.9.9.tar.gz && \
        unzip master.zip && \
        tar -xvf ffmpeg-release-64bit-static.tar.xz && \
        cd nginx-1.9.9 && \
            ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master && \
            make && \
            make install && \
            mkdir /usr/local/nginx/html/stream && \
            mkdir /usr/local/nginx/html/stream/vids

ADD nginx.conf /usr/local/nginx/conf/nginx.conf
ADD index.html vlc.html /usr/local/nginx/html/stream/
EXPOSE -P 1935 80 CMD ["/usr/local/nginx/sbin/nginx"]
