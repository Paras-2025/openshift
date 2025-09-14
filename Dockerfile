FROM nginx:alpine

# Copy static HTML
COPY index.html /usr/share/nginx/html/

# Create a writable temp dir
RUN mkdir -p /tmp/nginx && chmod -R 777 /tmp/nginx

# Override default nginx.conf
RUN sed -i 's|/var/cache/nginx|/tmp/nginx|g' /etc/nginx/nginx.conf && \
    sed -i 's|/var/run/nginx.pid|/tmp/nginx.pid|g' /etc/nginx/nginx.conf

# Also fix default.conf to listen on 8080 (non-root port)
RUN sed -i 's|listen       80;|listen 8080;|g' /etc/nginx/conf.d/default.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
