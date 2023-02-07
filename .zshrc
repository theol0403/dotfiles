export PATH=~/.npm-global/bin:$HOME/Applications/:$HOME/.cargo/bin:~/.local/bin/:$PATH:~/.emacs.d/bin/:~/.npm-global/bin/
export PATH=/home/theol/Downloads/gcc-arm-none-eabi-10.3-2021.10/bin/:$PATH
export PATH=$PATH:~/Documents/github/flutter/bin/

zstyle ':znap:*' repos-dir ~/Documents/zshplugins
source ~/Documents/github/zsh-snap/znap.zsh

# TERM=screen-256color
HYPHEN_INSENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
EDITOR='nvim'
VISUAL='nvim'
KEYTIMEOUT=1
setopt HIST_IGNORE_ALL_DUPS
bindkey -v

if [[ ${(t)key} != association ]]; then
  unset key
  typeset -gA key=()
  [[ ${(t)key_info} == association ]] &&
      key=( "${(@kv)key_info}" )
fi

: ${key[Control-Space]:=$'\0'}
: ${key[Tab]:=$'\t'}
: ${key[Shift-Tab]:=${(v)key[(I)(#i)Backtab]:-$'\e[Z'}}
: ${key[Return]:=$'\r'}
: ${key[Up]:=$'\e[A'}
: ${key[Alt-Up]:=$'\e\e[A'}
: ${key[Down]:=$'\e[B'}
: ${key[Alt-Down]:=$'\e\e[B'}
: ${key[Right]:=$'\e[C'}
: ${key[Left]:=$'\e[D'}
: ${key[End]:=$'\e[F'}
: ${key[Home]:=$'\e[H'}
: ${key[PageUp]:=$'\e[5~'}
: ${key[PageDown]:=$'\e[6~'}
: ${key[Delete]:=$'\C-[[3~'}

znap eval starship 'starship init zsh --print-full-init'
znap prompt starship

znap eval zoxide 'zoxide init zsh'
znap eval beet 'beet completion'

znap source zdharma/fast-syntax-highlighting
znap source zsh-users/zsh-completions
znap source xPMo/zsh-toggle-command-prefix

# ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
# znap source jeffreytse/zsh-vi-mode
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

zstyle ':autocomplete:*' min-input 4
# zstyle ':autocomplete:*' list-lines 6
zstyle ':autocomplete:tab:*' insert-unambiguous yes
zstyle ':autocomplete:tab:*' widget-style menu-select
# zstyle ':autocomplete:tab:*' widget-style menu-complete
zstyle ':autocomplete:tab:*' fzf-completion yes
zstyle ':autocomplete:*:too-many-matches' message ''
znap source marlonrichert/zsh-autocomplete
bindkey -M menuselect ^D kill-whole-line
bindkey -M menuselect $key[Return] accept-line

HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=yes
HISTORY_SUBSTRING_SEARCH_FUZZY=yes
znap source zsh-users/zsh-history-substring-search
bindkey $key[Up] history-substring-search-up
bindkey $key[Down] history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

ZSH_AUTOSUGGEST_STRATEGY=(histdb_top completion match_prev_cmd history)
ZSH_AUTOSUGGEST_USE_ASYNC=yes
znap source zsh-users/zsh-autosuggestions
autoload -Uz add-zsh-hook
bindkey '^ ' autosuggest-accept

# plugins=(docker)
# znap source ohmyzsh/ohmyzsh lib/{cli,clipboard,compfix,correction,diagnostics,directories,functions,git,grep,history,misc,nvm,prompt_info_functions,spectrum,termsupport}
# VSCODE=code-insiders
# znap source ohmyzsh/ohmyzsh plugins/{vscode,tmux,colored-man-pages,sublime-merge,docker-compose}

znap compdef _rustup  'rustup completions zsh'
znap compdef _cargo   'rustup completions zsh cargo'

znap source theol0403/zsh-histdb sqlite-history.zsh
_zsh_autosuggest_strategy_histdb_top() {
    local query="select commands.argv from
history left join commands on history.command_id = commands.rowid
left join places on history.place_id = places.rowid
where commands.argv LIKE '$(sql_escape $1)%'
group by commands.argv
order by places.dir != '$(sql_escape $PWD)', count(*) desc limit 1"
    suggestion=$(_histdb_query "$query")
}

# znap source marlonrichert/zsh-edit
# znap source marlonrichert/zsh-hist
# bindkey "^Z" undo

# bindings
bindkey $key[Home] beginning-of-line
bindkey $key[End] end-of-line
bindkey -M vicmd $key[Home] beginning-of-line
bindkey -M vicmd $key[End] end-of-line
bindkey '^H' backward-kill-word
bindkey $key[Delete] delete-char

setopt autocd

tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

if [[ "$TERM" == "dumb" ]]; then
    unset zle_bracketed_paste
    unset zle
    PS1='$ '
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

