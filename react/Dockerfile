FROM node:20.18.0

WORKDIR /app

COPY . .

RUN npm install --include=dev

EXPOSE 5173

CMD [ "npm", "run", "dev" ]

