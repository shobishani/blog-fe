FROM nginx
COPY ./build /usr/share/nginx/html
RUN sed -i '/worker_processes/c\worker_processes auto;' /etc/nginx/nginx.conf
EXPOSE 80
