#!/bin/bash
export SHELL="fish"

install-laptop() {
  # thoughtbot laptop script
  curl --remote-name https://raw.githubusercontent.com/thoughtbot/laptop/master/mac
  sh mac 2>&1 | tee ~/laptop.log
}

cp ~/dotfiles/laptop.local ~/.laptop.local
install-laptop
