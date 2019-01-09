# Local variables that is local to this machine only

set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
set -x EDITOR nvim

if test -e ~/.variables_local.fish
  source ~/.variables_local.fish
end
