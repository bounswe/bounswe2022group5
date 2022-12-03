# syntax=docker/dockerfile:1
FROM python:3.8
WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update
RUN apt-get install gcc libc-dev g++ libffi-dev libxml2 libffi-dev unixodbc-dev -y

COPY requirements.txt /app/
RUN pip install -r requirements.txt
COPY . /app/
