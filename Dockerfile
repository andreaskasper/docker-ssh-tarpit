FROM python:3

WORKDIR /app

RUN pip3 install ssh-tarpit

CMD ["ssh-tarpit"]
