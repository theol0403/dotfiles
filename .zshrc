# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
export PATH=~/.npm-global/bin:$HOME/Applications/:$HOME/.cargo/bin:~/.local/bin/:$PATH:~/.emacs.d/bin/:~/.npm-global/bin/
# export PATH=/home/theol/Downloads/gcc-arm-none-eabi-10.3-2021.10/bin/:$PATH
# export PATH=/home/theol/Downloads/gcc-arm-10.3-2021.07-x86_64-aarch64-none-linux-gnu/bin/:$PATH
export PATH=/home/theol/Downloads/arm-gnu-toolchain-12.2.mpacbti-rel1-x86_64-arm-none-eabi/bin/:$PATH

zstyle ':znap:*' repos-dir ~/Documents/zshplugins
source ~/Documents/github/zsh-snap/znap.zsh

HYPHEN_INSENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
EDITOR='nvim'
VISUAL='nvim'
KEYTIMEOUT=1
setopt HIST_IGNORE_ALL_DUPS

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

ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_NEX
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
ZVM_INIT_MODE=sourcing
znap source jeffreytse/zsh-vi-mode
znap source zdharma/fast-syntax-highlighting
znap source zsh-users/zsh-completions
znap source xPMo/zsh-toggle-command-prefix

# zstyle ':autocomplete:*' min-input 4
# # zstyle ':autocomplete:*' list-lines 6
# # zstyle ':autocomplete:tab:*' insert-unambiguous yes
# zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
# zstyle ':autocomplete:*history*:*' insert-unambiguous yes
# zstyle ':autocomplete:menu-search:*' insert-unambiguous yes
# zstyle ':autocomplete:tab:*' widget-style menu-select
# # zstyle ':autocomplete:tab:*' widget-style menu-complete
# zstyle ':autocomplete:tab:*' fzf-completion yes
# zstyle ':autocomplete:*:too-many-matches' message ''
# znap source marlonrichert/zsh-autocomplete
# bindkey -M menuselect ^D kill-whole-line
# bindkey -M menuselect $key[Return] .accept-line
# bindkey $key[Tab] menu-complete "$terminfo[kcbt]" reverse-menu-complete
# # bindkey $key[Tab] menu-select "$terminfo[kcbt]" menu-select
# # bindkey -M menuselect $key[Tab] menu-complete "$terminfo[kcbt]" reverse-menu-complete

ZSH_AUTOSUGGEST_STRATEGY=(atuin_top completion match_prev_cmd history)
# ZSH_AUTOSUGGEST_STRATEGY=(histdb_top completion match_prev_cmd history)
ZSH_AUTOSUGGEST_USE_ASYNC=yes
znap source zsh-users/zsh-autosuggestions
# autoload -Uz add-zsh-hook
bindkey '^ ' autosuggest-accept

_zsh_autosuggest_strategy_atuin_top() {
    suggestion=$(atuin search --limit 1 --format "{command}" --search-mode prefix --cwd $PWD $1)
    if [[ ! $suggestion = *[![:space:]]* ]]; then 
      suggestion=$(atuin search --limit 1 --format "{command}" --search-mode prefix $1)
    fi
}

znap eval atuin 'atuin init zsh'
znap compdef _atuin 'atuin gen-completions --shell zsh'
znap eval zoxide 'zoxide init zsh'
# znap eval beet 'beet completion'

HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=yes
HISTORY_SUBSTRING_SEARCH_FUZZY=yes
znap source zsh-users/zsh-history-substring-search
bindkey $key[Up] history-substring-search-up
bindkey $key[Down] history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd $key[Up] history-substring-search-up
bindkey -M vicmd $key[Down] history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# znap source ohmyzsh/ohmyzsh lib/{cli,clipboard,compfix,correction,diagnostics,directories,functions,git,grep,history,misc,nvm,prompt_info_functions,spectrum,termsupport}
VSCODE=code-insiders
znap source ohmyzsh/ohmyzsh plugins/{vscode,tmux,colored-man-pages,sublime-merge,docker-compose}

znap compdef _rustup  'rustup completions zsh'
znap compdef _cargo   'rustup completions zsh cargo'

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/theol/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/theol/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/theol/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/theol/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
