#BASE
FROM alpine

#RUN
RUN apk add nginx; \
    mkdir /run/nginx/; \
    echo "<h1>Hello World</h1>" > /var/www/localhost/htdocs/index.html;

#NGINX Config
ADD $PWD/config/default.conf /etc/nginx/http.d/default.conf

# Keys and certs
ADD $PWD/config/*.key /etc/ssl/private
ADD $PWD/config/*.crt /etc/ssl/certs

WORKDIR /var/www/localhost/htdocs

COPY $PWD/config/entrypoint.sh /usr/local/bin

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/bin/sh", "/usr/local/bin/entrypoint.sh"]

EXPOSE 80
EXPOSE 443

# RUN COMMAND
CMD ["/bin/sh", "-c", "nginx -g 'daemon off;'; nginx -s reload;"]