FROM python:3

LABEL MAINTAINER="Andreas Kasper <andreas.kasper@goo1.de>"

EXPOSE 2222

WORKDIR /app

RUN pip3 install ssh-tarpit

CMD ["ssh-tarpit"]
