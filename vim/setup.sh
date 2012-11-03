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
