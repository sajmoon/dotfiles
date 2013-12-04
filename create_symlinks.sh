printf "Configuring system\n"

printf "=> Install/Upgrad zsh configurator\n"

# #Install 
# if [ -d ~/.oh-my-zsh ]; then
#   # upgrade 
#   cd ~/.oh-my-zsh
#   git pull
# else
#   # install
#   curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
# fi

# if [ ! -L ~/.zshrc ]; then
#   ln -s ~/dotfiles/zshrc ~/.zshrc
# fi

if [ -d ~/.prezto ]; then
  #upgrade
  cd  ~/.zprezto
  git pull && git submodule update --init --recursive
else
  printf "Installing prezto"
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

if [ ! -L ~/.zpreztorc ]; then
  ln -s ~/.zprezto/runcoms/zlogin ~/.zlogin
  ln -s ~/.zprezto/runcoms/zlogout ~/.zlogout
  ln -s ~/.zprezto/runcoms/zpreztorc ~/.zpreztorc
  ln -s ~/.zprezto/runcoms/zprofile ~/.zprofile
  ln -s ~/.zprezto/runcoms/zshenv ~/.zshenv
  ln -s ~/.zprezto/runcoms/zshrc ~/.zshrc
fi

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

if [ ! -L ~/.gemrc ]; then
  ln -s ~/dotfiles/gemrc ~/.gemrc
fi

if [ ! -L ~/.tmux.conf ]; then
  ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
fi

if [ ! -L ~/.xmonad/xmonad.hs ]; then
  mkdir ~/.xmonad
  ln -s ~/dotfiles/xmonad.hs ~/.xmonad/xmonad.hs
  ln -s ~/dotfiles/xmobarrc ~/.xmobarrc
fi

printf "=> Install/upgrade rbenv\n"
#rbenv
if [ -d ~/.rbenv ]; then
  cd ~/.rbenv
  git pull
  
  cd ~/.rbenv/plugins/ruby-build
  git pull
else
  git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
  git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

printf "=>Install/Upgrad vim plugins..\n"
zsh ~/dotfiles/vim/setup.sh
