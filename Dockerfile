
FROM golang:bookworm

RUN mkdir -p /etc/apt/keyrings \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        gpg \
        ca-certificates \
        gnupg \
        build-essential \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN CGO_ENABLED=1 go install -tags extended github.com/gohugoio/hugo@latest
