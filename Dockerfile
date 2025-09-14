FROM nginx:alpine

# Copy static content
COPY index.html /usr/share/nginx/html/

# Change Nginx runtime directories to a location OpenShift allows
RUN mkdir -p /tmp/nginx && \
    sed -i 's|/var/cache/nginx|/tmp/nginx|' /etc/nginx/nginx.conf && \
    sed -i 's|/var/run/nginx.pid|/tmp/nginx.pid|' /etc/nginx/nginx.conf

# Expose port 8080 (non-root)
EXPOSE 8080

# Run nginx in foreground on port 8080
CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
