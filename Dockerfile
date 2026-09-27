FROM node:18-alpine

WORKDIR /usr/src/app

COPY package*.json ./
COPY server.js ./
COPY routes ./routes
COPY views ./views
COPY LICENSE ./

RUN npm install --production

EXPOSE 80

CMD ["node", "server.js"]