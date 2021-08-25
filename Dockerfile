FROM alpine:latest
ARG PKGS="git make gcc libc-dev"
ADD entrypoint.sh /entrypoint.sh
RUN apk add --no-cache ${PKGS}
RUN git clone https://github.com/vakuum/tcptunnel.git
RUN cd /tcptunnel && ./configure --prefix=/usr/bin && make && make install
RUN apk del ${PKGS}
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
