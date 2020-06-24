FROM nginx:mainline-alpine
RUN rm /etc/nginx/conf.d/*
COPY . nginxhello.conf /etc/nginx/conf.d/
COPY . index.html /usr/share/nginx/html/
EXPOSE 80