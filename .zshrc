# --------------------------------------------- Paths ---------------------------------------------------
export PATH=~/.npm-global/bin:$HOME/Applications/:$HOME/.cargo/bin:~/.local/bin/:$PATH:~/.emacs.d/bin/:~/.npm-global/bin/

PATH=$PATH:"/mnt/c/Program Files/Neovide"

export FPATH="/home/theol/Documents/github/eza/completions/zsh:$FPATH"

# Cross-Platform Tools (Windows/WSL)
if [[ $(uname -r) =~ (m|M)icrosoft ]]; then
  # Add Windows paths if in WSL, e.g., C:/Program Files/
  export PATH="/mnt/c/Program Files/Neovide:$PATH"

  neovide() {
    $(command neovide.exe --wsl "$@")
  }
  # Adding wsl-open as a browser for Bash for Windows
  if [[ -z $BROWSER ]]; then
    export BROWSER=wsl-open
  else
    export BROWSER=$BROWSER:wsl-open
  fi
fi

# --------------------------------------------- Env Vars ------------------------------------------------
HYPHEN_INSENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
EDITOR='nvim'
VISUAL='nvim'
KEYTIMEOUT=1
setopt HIST_IGNORE_ALL_DUPS

setopt autocd

if [[ ${(t)key} != association ]]; then
  unset key
  typeset -gA key=()
  [[ ${(t)key_info} == association ]] &&
    key=( "${(@kv)key_info}" )
fi

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

# ------------------------------------------- Sources --------------------------------------------
zstyle ':znap:*' repos-dir ~/Documents/zshplugins
source ~/Documents/github/zsh-snap/znap.zsh

znap eval atuin 'atuin init zsh --disable-up-arrow'
# znap fpath _atuin 'atuin gen-completions --shell zsh'

znap eval zoxide 'zoxide init zsh'
alias cd='z'

# znap eval beet 'beet completion'
# znap eval zellij 'zellij setup --generate-auto-start zsh'

# source ~/.venv/bin/activate

# -l for long
alias ls='eza -h --icons --group-directories-first'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'batcat --style=numbers --color=always {}'"
alias fd='fdfind'

# --------------------------------------------Key Bindings & Editor Mode --------------------------------------------------
bindkey -v

bindkey '^H' backward-kill-word
bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word

# --------------------------------------------- Plugins -------------------------------------------------
# don't use completion plugins in warp
if [[ "$TERM_PROGRAM" == "WarpTerminal"* ]]; then
  return
fi

znap eval starship 'starship init zsh --print-full-init'
znap prompt 

# ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_NEX
# ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
# ZVM_INIT_MODE=sourcing
# ZVM_KEYTIMEOUT=0
# ZVM_ESCAPE_KEYTIMEOUT=0
# ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
# znap source jeffreytse/zsh-vi-mode
znap source zdharma/fast-syntax-highlighting
znap source zsh-users/zsh-completions

zstyle ':autocomplete:*' min-input 4
zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
zstyle ':autocomplete:*history*:*' insert-unambiguous yes
zstyle ':autocomplete:menu-search:*' insert-unambiguous yes
zstyle ':autocomplete:tab:*' widget-style menu-select
zstyle ':autocomplete:tab:*' fzf-completion yes
zstyle ':autocomplete:*:too-many-matches' message ''
znap source marlonrichert/zsh-autocomplete

bindkey -M menuselect ^D kill-whole-line
bindkey $key[Tab] menu-complete "$terminfo[kcbt]" reverse-menu-complete
bindkey $key[Tab] menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect $key[Tab] menu-complete "$terminfo[kcbt]" reverse-menu-complete

bindkey -M menuselect  '^[[D' .backward-char  '^[OD' .backward-char
bindkey -M menuselect  '^[[C'  .forward-char  '^[OC'  .forward-char
zstyle ':completion:*' completer _complete _complete:-fuzzy _correct _approximate _ignored

ZSH_AUTOSUGGEST_STRATEGY=(atuin_top completion match_prev_cmd history)
ZSH_AUTOSUGGEST_USE_ASYNC=yes
znap source zsh-users/zsh-autosuggestions
bindkey '^ ' autosuggest-accept

_zsh_autosuggest_strategy_atuin_top() {
  suggestion=$(atuin search --limit 1 --format "{command}" --search-mode prefix --cwd $PWD $1)
  if [[ ! $suggestion = *[![:space:]]* ]]; then
    suggestion=$(atuin search --limit 1 --format "{command}" --search-mode prefix $1)
  fi
}

HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=yes
HISTORY_SUBSTRING_SEARCH_FUZZY=yes
znap source zsh-users/zsh-history-substring-search
bindkey $key[Up] history-substring-search-up
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey $key[Down] history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd $key[Up] history-substring-search-up
bindkey -M vicmd $key[Down] history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

