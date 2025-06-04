FROM ubuntu:22.04

RUN apt-get update && apt-get install -y curl unzip jq

# Install bws CLI
RUN curl -LO https://github.com/bitwarden/sdk/releases/latest/download/bws-linux-x64.zip \
    && unzip bws-linux-x64.zip \
    && mv bws /usr/local/bin/ \
    && chmod +x /usr/local/bin/bws \
    && rm bws-linux-x64.zip

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]