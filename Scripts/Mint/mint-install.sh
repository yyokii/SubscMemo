#!/bin/sh

# Mintを利用してインストールを実行する

MINT_CMD=mint
MINTFILE_PATH=$(dirname $0)/../../Mintfile

source $(dirname $0)/install-mint.sh

# Install packages
$MINT_CMD bootstrap -m $MINTFILE_PATH