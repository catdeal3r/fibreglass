
# Open and run zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Add programs and scripts to the path
path+=("/home/catdealer/.local/bin/")
path+=("/home/catdealer/scripts/tools/")
path+=("/home/catdealer/.config/scripts/")

export path

# Run oh-my-posh and zoxide
eval "$(zoxide init --cmd cd zsh)"

# Add zinit plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Load completions
autoload -U compinit && compinit

# Add aliases
alias c=clear
alias ls="ls --color"
alias banging\?="echo NARRHHHHHH;notify-send 'dOnT baNGG!!!' 'BANGING = NARRHHHHHH'"
alias f=fetch
alias ff=fastfetch
alias please=sudo

# Key bindings
bindkey '^f' autosuggest-accept

# Fix 'delete' outputing '~'
bindkey "^[[3~" delete-char

# Fix Ctrl + Arrow keys not working normally
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Fix Home and End not working normally
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus

export EDITOR=/usr/bin/vim

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

echo '\e[1 q'

NEWLINE=$'\n'

PROMPT="$NEWLINE%n%F{245} ↣ %f(%F{blue}%(5~|%-1~/.../%3~|%4~)%f) %F{red}·%f $NEWLINE· "
RPROMPT="%F{241}%B%t%b%f"
# eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/current.toml)"
