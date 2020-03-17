FROM node AS frontend-app
LABEL maintainer="shabab@gmail.com"
RUN apt-get update -y
RUN apt-get install -y apt-utils
RUN apt-get update -y
RUN apt-get -y install curl
RUN apt-get update -y
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN apt update -y
RUN apt-get install yarn -y
RUN yarn --version
WORKDIR /user/src/blog
COPY . /user/src/blog
RUN yarn install
RUN yarn build
RUN ls -a
RUN pwd

FROM nginx
COPY --from=frontend-app /user/src/blog/build /usr/share/nginx/html
RUN sed -i '/worker_processes/c\worker_processes auto;' /etc/nginx/nginx.conf
EXPOSE 80
