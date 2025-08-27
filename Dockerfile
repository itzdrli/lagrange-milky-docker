FROM debian:latest

RUN apt-get update && \
    apt-get install -y ca-certificates libicu-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN update-ca-certificates

WORKDIR /lagrange
COPY Lagrange.Milky .

RUN chmod +x ./Lagrange.Milky

RUN useradd -r -s /bin/false lagrange && \
    chown -R lagrange:lagrange /lagrange

USER lagrange

ENTRYPOINT ["./Lagrange.Milky"]