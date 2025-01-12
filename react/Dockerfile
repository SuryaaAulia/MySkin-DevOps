# Step 1: Build React App
FROM node:alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Step 2: Build Nginx Image
FROM nginx:alpine

RUN apk add --no-cache gettext

COPY --from=build /app/dist /usr/share/nginx/html

COPY ./nginx.conf /etc/nginx/nginx.template

COPY ./generate-nginx-conf.sh /usr/local/bin/generate-nginx-conf.sh

RUN chmod +x /usr/local/bin/generate-nginx-conf.sh

EXPOSE 80

CMD ["/bin/sh", "-c", "/usr/local/bin/generate-nginx-conf.sh && nginx -g 'daemon off;'"]

