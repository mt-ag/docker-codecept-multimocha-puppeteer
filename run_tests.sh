#!/usr/bin/env bash

function file_exists() {
  FILE=$1

  if [ ! -f "$FILE" ]; then
    echo "$FILE not found."
    exit 1
  fi
}

rm -rf ./test/sampke/output || true

docker run -it --init --rm --cap-add=SYS_ADMIN -v $(pwd)/test/sample:/tests codecept-multimocha-puppeteer:latest

file_exists ./test/sample/output/Chromium_Whatsmybrowser.png

echo "Tests completed successfully..."
