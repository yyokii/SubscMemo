#!/bin/sh

source $(dirname $0)/../Ruby/source-gem-cmd.sh
source $(dirname $0)/../Ruby/source-bundle-cmd.sh

# Install Gems
if !($GEM_CMD contents cocoapods > /dev/null 2>&1); then
  sh $(dirname $0)/../Ruby/bundle-install.sh
fi

# Install Pods
$BUNDLE_CMD exec pod install