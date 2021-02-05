FROM node:14-slim

# Install latest chrome dev package and fonts to support major charsets (Chinese, Japanese, Arabic, Hebrew, Thai and a few others)
# Note: this installs the necessary libs to make the bundled version of Chromium that Puppeteer
# installs, work.
RUN apt-get update \
  && apt-get install -y wget gnupg \
  && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
  && apt-get update \
  && apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# If running Docker >= 1.13.0 use docker run's --init arg to reap zombie processes, otherwise
# uncomment the following lines to have `dumb-init` as PID 1
# ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_x86_64 /usr/local/bin/dumb-init
# RUN chmod +x /usr/local/bin/dumb-init
# ENTRYPOINT ["dumb-init", "--"]

# Uncomment to skip the chromium download when installing puppeteer. If you do,
# you'll need to launch puppeteer with:
#     browser.launch({executablePath: 'google-chrome-stable'})
# ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# Run everything after as non-privileged user.
#RUN  groupadd -r pptruser && useradd -r -g pptruser -G audio,video pptruser \
#  && mkdir -p /home/pptruser/Downloads \
#  && chown -R pptruser:pptruser /home/pptruser

# Run as non-privileged user
RUN groupadd -r pptruser && \
  usermod -a -G pptruser node && \
  usermod -a -G audio node && \
  usermod -a -G video node && \
  mkdir -p /home/node/Downloads  && \
  chown -R node:node /home/node

# Add codecept dir
RUN mkdir /codecept && \ 
  chown -R node:node /codecept

COPY . /codecept

RUN cd /codecept && yarn --prod

USER node

WORKDIR /codecept

# Run tests
CMD ["bash", "/codecept/scripts/run.sh"]
