# vim:ft=zsh ts=2 sw=2 sts=2

rvm_current() {
  rvm current 2>/dev/null
}

rbenv_version() {
  rbenv version 2>/dev/null | awk '{print $1}'
}

purple="$FG[177]"
red="$FG[009]"
green="$FG[034]"
cyan="$FG[039]"

PROMPT='
%{$cyan%}$FX[bold]${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info)
$ '

# Must use Powerline font, for \uE0A0 to render.
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$purple%}\uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$red%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$green%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

if [ -e ~/.rvm/bin/rvm-prompt ]; then
  RPROMPT='%{$red%}‹$(rvm_current)›%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    RPROMPT='%{$red%}$(rbenv_version)%{$reset_color%}'
  fi
fi

