#!/bin/bash
export SHELL="fish"

installlaptop() {
  # thoughtbot laptop script
  curl --remote-name https://raw.githubusercontent.com/thoughtbot/laptop/master/mac
  sh mac 2>&1 | tee ~/laptop.log
}

cp ~/dotfiles/laptop.base ~/.laptop.local
installlaptop
