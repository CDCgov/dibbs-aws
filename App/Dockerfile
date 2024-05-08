FROM node:alpine

WORKDIR /app

COPY app.tar
COPY ./app/package.json .
RUN npm install

COPY ./src/ .

EXPOSE 3000

CMD ["node", "server.js"]