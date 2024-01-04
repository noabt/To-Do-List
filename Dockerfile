FROM python:3.9

WORKDIR /app

RUN apt-get update 

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY . /app

EXPOSE 3000

CMD [ "python", "main.py"]