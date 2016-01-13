FROM nodesource/jessie:5.0.0

MAINTAINER Monster "monster@monstermakes.com"

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list

ENV NGINX_VERSION 1.9.7-1~jessie

RUN apt-get update && \
    apt-get install -y ca-certificates nginx=${NGINX_VERSION} && \
    rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD ./resources/nginx/nginx.conf /etc/nginx/
ADD ./resources/nginx/default.conf /etc/nginx/conf.d/

# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Release web app
RUN rm -rfv /usr/share/nginx/html/*
ADD dist /usr/share/nginx/html

# Define mountable directories.
VOLUME ["/usr/share/nginx/html"]

# Expose ports
EXPOSE 81

# Set the default command to execute
# when creating a new container
CMD ["service", "nginx", "start"]