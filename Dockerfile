FROM node:4.2-slim

RUN groupadd user && useradd --create-home --home-dir /home/user -g user user

ENV REACT_SOURCE /usr/src/react
ENV TZ=Asia/Taipei
WORKDIR $REACT_SOURCE

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates \
    && apt-get install -y git \
    && apt-get install -y graphicsmagick \
    && apt-get install -y imagemagick \
    && rm -rf /var/lib/apt/lists/*

RUN buildDeps=' \
        gcc \
        make \
        python \
    ' \
  && set -x \
    && apt-get update && apt-get install -y $buildDeps --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Instanll pm2
RUN npm install -g pm2

# Provides cached layer for node_modules
ADD plate/package.json /tmp
RUN cd /tmp && npm install
RUN cp -a /tmp/node_modules $REACT_SOURCE/

# Add source files
ADD . /tmp/
RUN cp -a /tmp/plate/. $REACT_SOURCE/

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE 3000
CMD ["pm2", "start", "keystone.js", "--no-daemon"]
