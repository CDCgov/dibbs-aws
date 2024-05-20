FROM node:alpine

WORKDIR /app

COPY app.tar
COPY ./app/package.json .
RUN npm install

COPY ./src/ .

EXPOSE 8080

CMD ["node", "server.js"]