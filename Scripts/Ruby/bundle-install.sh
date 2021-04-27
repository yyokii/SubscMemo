#!/bin/sh

CONFIG_PATH=vendor/bundle

source $(dirname $0)/source-bundle-cmd.sh

# Install Bundler
if !($BUNDLE_CMD -v > /dev/null 2>&1); then
  sh $(dirname $0)/install-bundler.sh
fi

GEMFILE_PATH="$(dirname $0)/../../Gemfile"

# Install Gems
echo "🫖 install gems"
$BUNDLE_CMD config path $CONFIG_PATH
$BUNDLE_CMD install --gemfile=$GEMFILE_PATH --jobs 4 --retry 3
