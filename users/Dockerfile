FROM python:3.8
ENV PYTHONUNBUFFERED 1
WORKDIR /app
RUN apt-get update
    
RUN apt-get update && apt-get install -y \
    python3-dev

COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt


COPY . /app
