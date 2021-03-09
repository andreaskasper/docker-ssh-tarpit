FROM python:3

LABEL MAINTAINER="Andreas Kasper <andreas.kasper@goo1.de>"

EXPOSE 2222

WORKDIR /app

ENV BIND_ADDRESS=0.0.0.0
ENV BIND_PORT=2222
ENV VERBOSE=info

ADD entrypoint.sh /entrypoint.sh

RUN pip3 install ssh-tarpit

ENTRYPOINT ["/bin/bash","/entrypoint.sh"]
