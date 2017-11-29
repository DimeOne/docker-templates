FROM python:2-stretch

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN echo "deb http://deb.debian.org/debian stretch main contrib non-free" > /etc/apt/sources.list \
  && echo "deb http://deb.debian.org/debian stretch-updates main contrib non-free" >> /etc/apt/sources.list \
  && echo "deb http://security.debian.org/ stretch/updates main contrib non-free" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    locales \
    gosu \
    wget \
    nodejs \
    unrar \
    p7zip-full \
    libssl-dev \
    libffi-dev \
    libev-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
  && pip install \
    requests \
    pycurl \
    pycrypto \
    pyOpenSSL \
    bjoern \
    Pillow \
    beaker \
    pyxmpp \
    thrift \
    Send2Trash \
    beautifulsoup \
    django \
    jinja2 \
    feedparser \
    colorlog \
    simplejson \
    tesseract \
    markupsafe \
    MultipartPostHandler \
    bottle \
    colorama \
    gunicorn \
    cherrypy>=3.0.8,<9.0.0 \
    wsgiserver \
  && rm -rf /var/lib/apt/lists/* \
  && locale-gen en_US.UTF-8

ADD docker-entrypoint.sh /docker-entrypoint.sh

RUN wget -q -O /pyload.tgz https://github.com/pyload/pyload/tarball/stable \
  && echo "c5bb903004b560c9c9e8617535ec8ec0ca697ab47d34b1bc0e807aa464e2884c /pyload.tgz" | sha256sum -c \
  && mkdir -p /app/pyload \
  && tar xzf /pyload.tgz -C /app/pyload --strip-components=1 \
  && rm -rf /pyload.tgz \
  && chmod 777 /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["app:start"]
