FROM alpine:latest
ARG PKGS="git make gcc libc-dev"
ENV LHOST=0.0.0.0
ENV LPORT=18184
ENV RHOST=localhost
ENV RPORT=8888
ADD entrypoint.sh /entrypoint.sh
RUN apk add --no-cache $PKGS
RUN git clone https://github.com/vakuum/tcptunnel.git
RUN cd /tcptunnel && ./configure --prefix=/usr/bin && make && make install
RUN apk del $PKGS
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
