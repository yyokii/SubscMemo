#!/bin/sh

# Mintをインストールする

MINT_PATH=https://github.com/yonaskolb/Mint.git

# Install Mint
if !(type $MINT_CMD > /dev/null 2>&1); then
  git clone --depth 1 MINT_PATH
  cd Mint
  make
fi
