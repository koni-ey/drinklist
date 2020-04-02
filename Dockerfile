# first stage - build environment
FROM debian:latest AS buildenv

# flutter dependencies
RUN apt-get update && \
    apt-get install -y curl git unzip xz-utils zip && \
    apt-get clean

# clone flutter repository & run flutter doctor to setup flutter env
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# configure flutter web
RUN flutter channel beta && \
    flutter upgrade && \
    flutter config --enable-web

# copy app files & build app
RUN mkdir /usr/local/drinklist
COPY . /usr/local/drinklist
# copy custom config if available
COPY custom_config/** /usr/local/drinklist/lib/config
WORKDIR /usr/local/drinklist
RUN flutter build web

# second stage - serving container
FROM nginx:1.17.9-alpine

# copy built app
COPY --from=buildenv /usr/local/drinklist/build/web /usr/share/nginx/html