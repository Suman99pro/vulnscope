# ── VulnScope — Threat Intelligence Platform ──────────────────────────────────
# Serves the static HTML app via nginx:alpine
# Ultra-minimal image: ~8MB total

FROM nginx:alpine

LABEL maintainer="suman99pro"
LABEL description="VulnScope — Vulnerability Intelligence Platform"
LABEL version="2.5.0"

# Create non-root user first
RUN addgroup -S vulnscope && adduser -S vulnscope -G vulnscope

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy app and config
COPY index.html /usr/share/nginx/html/index.html
COPY nginx.conf /home/vulnscope/nginx.conf

# Fix permissions in one layer
RUN chown -R vulnscope:vulnscope /var/cache/nginx \
    && chown -R vulnscope:vulnscope /var/log/nginx \
    && chown -R vulnscope:vulnscope /usr/share/nginx/html \
    && chown vulnscope:vulnscope /home/vulnscope/nginx.conf

USER vulnscope

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:8080/ || exit 1

# Pass our config file directly — bypasses /etc/nginx/conf.d entirely
CMD ["nginx", "-c", "/home/vulnscope/nginx.conf", "-g", "daemon off;"]
