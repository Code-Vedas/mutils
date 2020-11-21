#!/bin/bash

set -euo pipefail

mkdir -p $HOME/.gem
touch $HOME/.gem/credentials
chmod 0600 $HOME/.gem/credentials
printf -- "---\n:rubygems_api_key: ${RUBYGEMS_AUTH_TOKEN}\n" > $HOME/.gem/credentials
gem build *.gemspec
gem push *.gem
