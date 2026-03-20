# ── VulnScope — Threat Intelligence Platform ──────────────────────────────────
# Serves the static HTML app via nginx:alpine
# Ultra-minimal image: ~8MB total

FROM nginx:alpine

LABEL maintainer="suman99pro"
LABEL description="VulnScope — Vulnerability Intelligence Platform"
LABEL version="2.5.0"

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy app
COPY index.html /usr/share/nginx/html/index.html

# Custom nginx config — security headers + gzip
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Non-root user for security
RUN addgroup -S vulnscope && adduser -S vulnscope -G vulnscope \
    && chown -R vulnscope:vulnscope /usr/share/nginx/html \
    && chown -R vulnscope:vulnscope /var/cache/nginx \
    && chown -R vulnscope:vulnscope /var/log/nginx \
    && touch /var/run/nginx.pid \
    && chown -R vulnscope:vulnscope /var/run/nginx.pid

USER vulnscope

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:8080/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
