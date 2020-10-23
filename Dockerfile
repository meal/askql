FROM node:14-stretch-slim

LABEL maintainer "Matt Kozak <mateusz@mkozak.pl>"

RUN mkdir /app

COPY package.json /app

WORKDIR /app

COPY ./ /app

RUN buildDeps='autoconf build-essential automake autoconf g++'  \
    && DEBIAN_FRONTEND=noninteractive apt-get update -qq \
    && apt install $buildDeps -y -qq --no-install-recommends \
    && npm install \
    && npm run build \
    && npm link \
    && apt-get purge -y --auto-remove $buildDeps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["askql"]
