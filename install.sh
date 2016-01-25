#!/bin/bash
export SHELL="fish"

install-laptop() {
  # thoughtbot laptop script
  curl --remote-name https://raw.githubusercontent.com/thoughtbot/laptop/master/mac
  sh mac 2>&1 | tee ~/laptop.log
}

ln -s ~/dotfiles/laptop.base ~/.laptop.local
install-laptop
