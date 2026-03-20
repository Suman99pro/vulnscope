# ⚡ VulnScope — Vulnerability Intelligence Platform

![Docker](https://img.shields.io/badge/Docker-nginx%3Aalpine-2496ED?logo=docker&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green)
![Version](https://img.shields.io/badge/Version-2.5.0-orange)
![CVEs](https://img.shields.io/badge/CVE_Database-269K%2B-red)

> **Real-time vulnerability reconnaissance powered by NIST NVD API v2.0**

A military-grade threat intelligence UI for CVE scanning, technology fingerprinting, security header analysis, and TLS auditing — all in a single zero-dependency HTML file served via Docker.

![VulnScope Screenshot](https://raw.githubusercontent.com/suman99pro/vulnscope/main/screenshot.png)

---

## 🚀 Quick Start

### Docker (recommended)

```bash
# Pull and run
docker run -d -p 8080:8080 --name vulnscope ghcr.io/suman99pro/vulnscope:latest

# Open in browser
open http://localhost:8080
```

### Docker Compose

```bash
git clone https://github.com/suman99pro/vulnscope.git
cd vulnscope
docker compose up -d
```

### Build locally

```bash
docker build -t vulnscope .
docker run -d -p 8080:8080 vulnscope
```

---

## 🔍 Features

| Module | Description |
|--------|-------------|
| **CVE Lookup** | Correlates detected technologies against NIST NVD (269K+ entries) |
| **HTTP Headers** | Checks CSP, HSTS, X-Frame-Options, Permissions-Policy |
| **TLS/SSL Audit** | Protocol version, cipher strength, certificate validity |
| **Tech Fingerprint** | Identifies CMS, frameworks, libraries from response patterns |
| **DNS Security** | SPF, DKIM, DMARC, DNSSEC checks *(optional)* |
| **Cookie Flags** | HttpOnly, Secure, SameSite enforcement *(optional)* |
| **Subdomain Recon** | Certificate transparency log enumeration *(optional)* |
| **CORS Policy** | Detects permissive cross-origin misconfigurations *(optional)* |

### Scan Example Targets

| Input | What it detects |
|-------|-----------------|
| `apache 2.4.49` | CVE-2021-41773, CVE-2021-42013 (CVSS 9.8) |
| `openssh 8.5` | CVE-2024-6387 regreSSHion, CVE-2023-38408 |
| `linux kernel 5.4` | CVE-2022-0847 Dirty Pipe, CVE-2024-1086 |
| `redis 6.0` | CVE-2022-24834 Lua heap overflow |
| `docker` | CVE-2024-21626 Leaky Vessels container escape |
| `example.com` | HTTP/2 Rapid Reset, header misconfigs, TLS issues |

---

## 🐳 Docker Details

- **Base image:** `nginx:alpine` (~8MB)
- **Port:** `8080`
- **User:** non-root (`vulnscope`)
- **Read-only filesystem** with tmpfs for runtime dirs
- **Security headers** pre-configured in nginx
- **Multi-arch:** `linux/amd64` + `linux/arm64`

---

## ⚠️ Legal Disclaimer

**Authorized use only.** This tool is designed for:
- Security assessments on systems you **own**
- Penetration testing with **written authorization**
- Educational and research purposes in **controlled environments**

Unauthorized scanning may violate the CFAA, Computer Misuse Act, GDPR, and applicable local cybercrime laws. The authors assume no liability for misuse.

---

## 📦 Project Structure

```
vulnscope/
├── index.html              # Full application (single file)
├── nginx.conf              # nginx server config with security headers
├── Dockerfile              # Multi-stage build, non-root, nginx:alpine
├── docker-compose.yml      # Local deployment
├── .dockerignore
├── .gitignore
└── .github/
    └── workflows/
        └── docker-publish.yml   # CI/CD: build & push to GHCR on merge
```

---

## 🔧 Development

No build step required — pure HTML/CSS/JS.

```bash
# Serve locally without Docker
python3 -m http.server 8080
# or
npx serve .
```

---

## 📊 Report Export

- **JSON** — Machine-readable, suitable for CI/CD integration and SIEM ingestion
- **HTML** — Clean printable report for stakeholders

---

## 📄 License

MIT © [suman99pro](https://github.com/suman99pro)
