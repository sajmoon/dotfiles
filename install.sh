#!/bin/bash
# setup thoughbot laptopscript

install-laptop() {
  # thouchbot laptio script
	curl --remote-name https://raw.githubusercontent.com/thoughtbot/laptop/master/mac
	sh mac 2>&1 | tee ~/laptop.log
}

install-vundle() {
  if [ ! -e $HOME/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  fi
  vim -u $HOME/.vimrc.bundles +PluginInstall +PluginClean! +qa
}

install-prezto() {
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  chsh -s /bin/zsh
}

install-laptop
rcup -v -d ~/dotfiles
install-vundle
install-prezto

