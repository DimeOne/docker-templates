FROM python:2-stretch

RUN echo "deb http://deb.debian.org/debian stretch main contrib non-free" > /etc/apt/sources.list \
  && echo "deb http://deb.debian.org/debian stretch-updates main contrib non-free" >> /etc/apt/sources.list \
  && echo "deb http://security.debian.org/ stretch/updates main contrib non-free" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    wget \
    nodejs \
    unrar \
    p7zip-full \
    libssl-dev \
    libffi-dev \
    libev-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
  && rm -rf /var/lib/apt/lists/*

ADD requirements.txt /app/
RUN pip install --no-cache /app/requirements.txt

ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN wget -q -O /pyload.tgz https://github.com/pyload/pyload/tarball/stable \
  && echo "c5bb903004b560c9c9e8617535ec8ec0ca697ab47d34b1bc0e807aa464e2884c /pyload.tgz" | sha256sum -c \
  && mkdir -p /app/pyload \
  && tar xzf /pyload.tgz -C /app/pyload --strip-components=1 \
  && rm -rf /pyload.tgz \
  && chmod 755 /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["app:start"]
