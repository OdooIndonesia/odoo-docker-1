FROM python:2.7.12
MAINTAINER Hibou Corp. <hello@hibou.io>

# add user with the same user id as in core odoo package
# unfortunately python comes with group 107 already defined so I used www-data as group
RUN useradd -m -d /var/lib/odoo -s /bin/false -u 104 -g 33 odoo

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
            ca-certificates \
            curl \
        && curl -o wkhtmltox.deb -SL http://nightly.odoo.com/extra/wkhtmltox-0.12.1.2_linux-jessie-amd64.deb \
        && echo '40e8b906de658a2221b15e4e8cd82565a47d7ee8 wkhtmltox.deb' | sha1sum -c - \
        && dpkg --force-depends -i wkhtmltox.deb \
        && apt-get -y install -f --no-install-recommends \
        && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false npm \
        && rm -rf /var/lib/apt/lists/* wkhtmltox.deb

# support for Postgresql9.5
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main 9.6" > /etc/apt/sources.list.d/postgresql.list \
        && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
        && apt-get update \
        && apt-get upgrade -y postgresql-common \
        && apt-get upgrade -y postgresql-client

# install newer node and lessc (mostly for less compatibility)
RUN set -x; \
        apt-get install -y nodejs npm

RUN npm install -g less \
    && npm install -g less-plugin-clean-css \
    && ln -s `which nodejs` /bin/node \
    && ln -s `which lessc` /bin/lessc

# python python-minimal python2.7 python2.7-minimal
RUN apt-get purge -y python.*

# Install Odoo
ENV ODOO_VERSION 9.0
ENV ODOO_RELEASE latest
RUN set -x; \
        apt-get install -y libsasl2-dev libldap2-dev libssl-dev gcc \
        && curl -o odoo.tar.gz -SL https://nightly.odoo.com/${ODOO_VERSION}/nightly/src/odoo_${ODOO_VERSION}c.${ODOO_RELEASE}.tar.gz \
        && tar xzf odoo.tar.gz \
        && cd odoo-${ODOO_VERSION}c-${ODOO_RELEASE} \
        && pip install . \
        && cd .. && rm -rf ./odoo* \
        && pip install --upgrade \
            cryptography \
            inotify \
            watchdog \
            psycogreen \
            psycopg2 \
            gevent \
            pyinotify \
            newrelic \
            flanker \
        && apt-get purge -y \
            gcc \
            libsasl2-dev \
            libldap2-dev \
            libssl-dev


# missing from above package (workers>0)
RUN curl -o /usr/local/bin/openerp-gevent -SL https://raw.githubusercontent.com/odoo/odoo/${ODOO_VERSION}/openerp-gevent \
        && chmod a+x /usr/local/bin/openerp-gevent


# Copy entrypoint script and Odoo configuration file
COPY ./entrypoint.sh /
COPY ./openerp-server.conf /etc/odoo/
RUN chown odoo /etc/odoo/openerp-server.conf

# Mount /var/lib/odoo to allow restoring filestore and /mnt/extra-addons for users addons

RUN mkdir -p /mnt/custom-addons \
     && chown -R odoo /mnt/custom-addons

RUN mkdir -p /mnt/extra-addons \
        && chown -R odoo /mnt/extra-addons
VOLUME ["/var/lib/odoo", "/mnt/extra-addons","/mnt/custom-addons"]

# Expose Odoo services
EXPOSE 8069 8071

# Set the default config file
ENV OPENERP_SERVER /etc/odoo/openerp-server.conf

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["openerp-server"]
