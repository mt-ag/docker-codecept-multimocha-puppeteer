FROM zenika/alpine-chrome:89-with-puppeteer

LABEL org.opencontainers.image.source https://github.com/mt-ag/docker-codecept-multimocha-puppeteer

USER root

RUN mkdir /codecept && \ 
  chown -R chrome:chrome /codecept

COPY . /codecept

RUN cd /codecept && yarn --prod

USER chrome

WORKDIR /codecept

# Run tests
CMD ["ash", "/codecept/scripts/run.sh"]
