#!/usr/bin/env bash

function file_exists() {
  FILE=$1

  if [ ! -f "$FILE" ]; then
    echo "$FILE not found."
    exit 1
  fi
}

rm -rf ./test/sample/output || true

mkdir ./test/sample/output
chmod -R 777 ./test/sample/output

docker run --rm --security-opt seccomp=$(pwd)/chrome-seccomp.json -v $(pwd)/test/sample:/tests codecept-multimocha-puppeteer:latest

file_exists ./test/sample/output/Chromium_Whatsmybrowser.png

if ls ./test/sample/output/*.failed.* 1>/dev/null 2>&1; then
  echo "One ore more tests failed"
  exit 1
fi

echo "Tests completed successfully..."
