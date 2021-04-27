#!/bin/sh

# bundlerをインストールする

source $(dirname $0)/source-bundle-cmd.sh
source $(dirname $0)/source-gem-cmd.sh

if !($BUNDLE_CMD > /dev/null 2>&1); then
  echo "🫖 install bundler"
  BUNDLER_VERSION=`sh $(dirname $0)/get-bundler-version.sh`
  sudo $GEM_CMD install bundler -v $BUNDLER_VERSION
fi
