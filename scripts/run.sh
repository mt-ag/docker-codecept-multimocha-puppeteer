#!/usr/bin/env bash

function show_help() {
	echo "Codeceptjs Tests could not be found"
	echo " "
	echo "Please make sure you're mounting your codeceptjs directory correctly."
	echo "*** Run example test: docker run -it --rm -v $(pwd)/test/webkit:/tests image_name:latest "
	echo " "
	exit 1
}

# Check if tests are correctly mounted
if [[ -d "/tests/" ]]; then
	echo "Mounted directory has been found."

	[ -d "/tests/output" ] || mkdir /tests/output

	cp -ap /tests/. /codecept

	[ -d "/codecept/output" ] || mkdir /codecept/output

	yarn codeceptjs run --reporter mocha-multi | tee /codecept/output/output.log

	cp -r /codecept/output/* /tests/output/
else
	show_help
fi
