FROM node:22-slim

RUN apt-get update && \
    apt-get install -y curl unzip jq git && \
    curl -L -o kubo.tar.gz https://dist.ipfs.io/kubo/v0.25.0/kubo_v0.25.0_linux-amd64.tar.gz && \
    tar -xzf kubo.tar.gz && \
    cd kubo && \
    mv ipfs /usr/local/bin/ && \
    cd .. && \
    rm -rf kubo kubo.tar.gz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .
RUN ipfs init
RUN npm i -g kuuga-cli@0.12.1

EXPOSE 4001

CMD sh -c "ipfs daemon & sleep 5 && kuuga pin"
