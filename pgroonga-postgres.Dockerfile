# As the official groonga/pgroonga image is amd64-only, we provide this Dockerfile.
# NOTE: devcontainer on arm mac somehow fails to start the build arm64 image, so
# in that environment we pull the official image instead.

FROM postgres:15-bookworm

# Add Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# PGroonga install
ENV PGROONGA_VERSION=3.1.5-1
RUN \
    apt update && \
    apt install -y -V wget && \
    wget https://apache.jfrog.io/artifactory/arrow/debian/apache-arrow-apt-source-latest-bookworm.deb && \
    apt install -y -V ./apache-arrow-apt-source-latest-bookworm.deb && \
    rm apache-arrow-apt-source-latest-bookworm.deb && \
    wget https://packages.groonga.org/debian/groonga-apt-source-latest-bookworm.deb && \
    apt install -y -V ./groonga-apt-source-latest-bookworm.deb && \
    rm groonga-apt-source-latest-bookworm.deb && \
    apt update && \
    apt install -y -V \
    postgresql-15-pgdg-pgroonga=${PGROONGA_VERSION} \
    groonga-normalizer-mysql \
    groonga-token-filter-stem \
    groonga-tokenizer-mecab && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

CMD ["docker-entrypoint.sh", "postgres"]
