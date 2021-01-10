FROM alpine:latest

RUN version=$(wget -qO- https://api.github.com/repos/sgerrand/alpine-pkg-glibc/releases/latest | sed 's/^ *"tag_name": "\(.*\)",$/\1/p' -n) && \
    wget -q \
      https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$version/glibc-$version.apk \
      https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    mv sgerrand.rsa.pub /etc/apk/keys && \
    apk add --no-cache glibc-*.apk && \
    rm /etc/apk/keys/sgerrand.rsa.pub glibc-*.apk
