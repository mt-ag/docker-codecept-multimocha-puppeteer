# Docker Codecept Multimocha Puppeteer

This Image uses the Zenika's [alpine-chrome](https://github.com/Zenika/alpine-chrome) Image as base and setups [Codecept](https://codecept.io/) and [Multimocha](https://codecept.io/reports/#multi-reports) with it. You can mount your Codecept project into a container where it will get executed without additional setup.

To take advantage of the [Sandbox features](https://chromium.googlesource.com/chromium/src/+/master/docs/design/sandbox.md) of Chrome and securely run any tests, you need to provide a seccomp file ( (chrome-seccomp.json)[./chrome-seccomp.json] ) to the container.

You can do this by providing these additional parameters to the docker run command: `--security-opt seccomp=$(pwd)/chrome-seccomp.json`

Credits go to the alpine-chrome Image for [providing this method](https://github.com/Zenika/alpine-chrome#-the-best-with-seccomp).

## How to use

Run your codecept project

```sh
docker run -it --rm --security-opt seccomp=$(pwd)/chrome-seccomp.json -v /path/to/your/codecept/folder:/tests codecept-multimocha-puppeteer:latest
```

Run the example test:

```sh
docker run -it --rm --security-opt seccomp=$(pwd)/chrome-seccomp.json -v $(pwd)/test/sample:/tests codecept-multimocha-puppeteer:latest
```

Note that you need Playwright in your Codecept config and multimocha:

```js
exports.config = {
  tests: "./*.test.js",
  output: "./output",
  helpers: {
    Puppeteer: {
      url: "http://localhost",
      show: false,
    },
  },
  mocha: {
    reporterOptions: {
      "codeceptjs-cli-reporter": {
        stdout: "-",
        options: {
          verbose: false,
          steps: true,
        },
      },
      "mocha-junit-reporter": {
        stdout: "./output/console.log",
        options: {
          mochaFile: "./output/result.xml",
        },
        attachments: true,
      },
    },
  },
  ...
};
```

[Full example config](./test/sample/codecept.conf.js)

## Development

Build Image

```sh
docker build . -t codecept-multimocha-puppeteer
```

Debug:

```sh
docker run -it --rm --security-opt seccomp=$(pwd)/chrome-seccomp.json -v $(pwd)/test/sample:/tests codecept-multimocha-puppeteer:latest /bin/ash
```

## Tests

```sh
./run_tests.sh
```
