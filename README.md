# Docker Codecept Multimocha Puppeteer

This Image uses the Zenika's [Alpine-Chrome](https://github.com/Zenika/alpine-chrome) Image as base and setups [Codecept](https://codecept.io/) and [Multimocha](https://codecept.io/reports/#multi-reports) with it. You can mount your Codecept project into a container where it will get executed without additional setup.

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
