#!/bin/sh

source $(dirname $0)/../Ruby/source-gem-cmd.sh
source $(dirname $0)/../Ruby/source-bundle-cmd.sh

# Install Pods
$BUNDLE_CMD exec pod install