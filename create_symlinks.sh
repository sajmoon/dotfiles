printf "Configuring system\n"

printf "=> Checking for configfiles\n"
if [ ! -L ~/.vim ]; then
  ln -s ~/dotfiles/vim ~/.vim;
fi

if [ ! -L ~/.vimrc ]; then
  ln -s ~/dotfiles/vim/vimrc ~/.vimrc;
fi

if [ ! -L ~/.gitconfig ]; then
  ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
fi

if [ ! -L ~/.zshrc ]; then
  ln -s ~/dotfiles/zshrc ~/.zshrc
fi

if [ ! -L ~/.gemrc ]; then
  ln -s ~/dotfiles/gemrc ~/.gemrc
fi

if [ ! -L ~/.xmonad/xmonad.hs ]; then
  mkdir ~/.xmonad
  ln -s ~/dotfiles/xmonad.hs ~/.xmonad/xmonad.hs
  ln -s ~/dotfiles/xmobarrc ~/.xmobarrc
fi

printf "=> Install/Upgrad OhMyZsh\n"
#Install 
if [ -d ~/.oh-my-zsh ]; then
  # upgrade 
  cd ~/.oh-my-zsh
  git pull
else
  # install
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi


printf "=> Install/upgrade rbenv\n"
#rbenv
if [ -d ~/.rbenv ]; then
  cd ~/.rbenv
  git pull
else
  git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

printf "=>Install/Upgrad vim plugins..\n"
zsh ~/dotfiles/vim/setup.sh
