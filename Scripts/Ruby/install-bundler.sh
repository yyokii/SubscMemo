#!/bin/sh

# bundlerをインストールする

source $(dirname $0)/source-gem-cmd.sh

if !($BUNDLER_CMD > /dev/null 2>&1); then
  BUNDLER_VERSION=`sh $(dirname $0)/get-bundler-version.sh`
  sudo $GEM_CMD install bundler -v $BUNDLER_VERSION
fi