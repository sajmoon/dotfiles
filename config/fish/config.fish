# Aliases
alias vi "nvim"
alias vim "nvim"
alias mex "iex -S mix"

set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

# Prompt
function fish_prompt
  set last_status $status

  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal

  printf '%s ' (__fish_git_prompt)

  set_color normal
  echo -n '> '
end

# Set brew path
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
source ~/.asdf/asdf.fish
