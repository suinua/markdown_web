FROM ubuntu:20.04

LABEL "com.github.actions.name"="vis"
LABEL "com.github.actions.description"=""
LABEL "com.github.actions.icon"="plus"
LABEL "com.github.actions.color"="green"

RUN apt-get update
RUN apt-get install -y curl wget gnupg less lsof net-tools git apt-utils -y

# DART
RUN apt-get install apt-transport-https
RUN sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
RUN sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
RUN apt-get update
RUN apt-get install dart -y
ENV PATH="${PATH}:/usr/lib/dart/bin/"
ENV PATH="${PATH}:/root/.pub-cache/bin"

COPY / /

ENTRYPOINT ["sh", "/setup.sh"]
