FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y nodejs npm wget
RUN apt-get install build-essential
RUN npm -g install sails
RUN mkdir /app

WORKDIR /app

RUN wget -O /app/dynamodb_local_latest http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest
RUN tar xfz /app/dynamodb_local_latest
RUN ln -s /usr/bin/nodejs /usr/bin/node

COPY . ./

EXPOSE 8000
EXPOSE 1337

CMD ["java", "-Djava.library.path=./dynamodb_local_latest", "-jar", "DynamoDBLocal.jar"]
CMD ["bash", "/app/start.sh"]

