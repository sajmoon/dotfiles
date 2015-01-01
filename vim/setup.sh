#!/usr/bin/env zsh

mkdir -p ~/.vim/bundle

cd ~/.vim/bundle

for plugin in `cat ../plugins.txt`; do
  pluginname=`echo $plugin | sed -e 's/.*\/\(.*\)\.git/\1/'`
  if [[ -e $pluginname ]]; then
    echo "> updating $pluginname"
    (cd $pluginname && git pull )
  else
    echo "> installing $pluginname"
    git clone $plugin $pluginname
  fi
done

# clang
# mkdir -p ~/.vim/tags/stl
# cd ~/.vim/tags
# ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++
# rm -rf stl

# mkdir stl
# mv tags stl/

# cd YouCompleteMe
# git submodule update --init --recursive
# sh install.sh
