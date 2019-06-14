# vim:ft=zsh ts=2 sw=2 sts=2
cmd_exists() {
  command -v $1 > /dev/null 2>&1
}

ruby_version_prompt_info() {
  [[ -f Gemfile || -f Rakefile ]] || return

  local 'ruby_version'

  if cmd_exists rvm-prompt; then
    ruby_version=$(rvm current)
  elif cmd_exists rbenv; then
    ruby_version=$(rbenv version | awk '{print $1}')
  else
    return
  fi

  [[ -z $ruby_version || "${ruby_version}" == "system" ]] && return

  echo "‹ruby-$ruby_version›" 2>/dev/null
}

node_version_prompt_info() {
  [[ -f package.json || -d node_modules ]] || return

  local 'node_version'

  if cmd_exists nvm; then
    node_version=$(nvm current 2>/dev/null)
    [[ $node_version == "system" || $node_version == "node" ]] && return
  elif cmd_exists node; then
    node_version=$(node -v 2>/dev/null)
  else
    return
  fi

  echo "‹node-$node_version›" 2>/dev/null
}

purple="$FG[169]"
red="$FG[009]"
green="$FG[034]"
turquoise="$FG[038]"

PROMPT='
%{$turquoise%}$FX[bold]${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info) %{$green%}$(node_version_prompt_info)%{$reset_color%}%{$red%}$(ruby_version_prompt_info)%{$reset_color%}
$ '

# Must use Powerline font, for \uE0A0 to render.
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$purple%}\uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$red%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$green%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

