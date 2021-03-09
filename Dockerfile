FROM python:3

LABEL MAINTAINER="Andreas Kasper <andreas.kasper@goo1.de>"

EXPOSE 2222

WORKDIR /app

ADD entrypoint.sh /entrypoint.sh

RUN pip3 install ssh-tarpit

ENTRYPOINT ["/bin/bash","/entrypoint.sh"]

