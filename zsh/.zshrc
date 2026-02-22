# Start configuration added by Zim Framework install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v
KEYTIMEOUT=1

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh
# }}} End configuration added by Zim Framework install

# Created by newuser for 5.9

# ---------------------
# Environment variables
# ---------------------

export PATH="$HOME/.local/bin:$PATH"
export EDITOR=nvim
export VISUAL=nvim
export FZF_PREVIEW_WIDTH="55%"

# Reset LS_COLORS to ensure Carbonfox black foreground on highlighted blocks
# 'ow' is other-writable, 'tw' is sticky other-writable
# 30 is the ANSI code for Black (Carbonfox Background)
export LS_COLORS="ow=42;30:tw=42;30:st=44;30:di=01;34"

# -------
# Aliases
# -------

alias cat="bat --paging=never"

# ---
# fzf
# ---

source <(fzf --zsh)

if command -v fdfind >/dev/null; then
    FD_CMD="fdfind"
else
    FD_CMD="fd"
fi

# CTRL-T: Only find files (excludes directories from the list)
export FZF_CTRL_T_COMMAND="$FD_CMD --type f --strip-cwd-prefix --hidden --exclude .git"

# ALT-C: Only find directories
export FZF_ALT_C_COMMAND="$FD_CMD --type d --strip-cwd-prefix --hidden --exclude .git"

# 3. Base options for all fzf commands (Full Screen + Carbonfox Colors)
export FZF_DEFAULT_OPTS="
  --reverse 
  --height 100% 
  --border rounded 
  --info inline
  --prompt '∼ '
  --pointer '>'
  --marker '✚'
  --color=fg:#cdcecf,bg:#161616,hl:#7bafad
  --color=info:#7199ee,prompt:#78a9ff
  --color=marker:#b279d6,spinner:#b279d6,header:#b279d6
  --color=pointer:#be95ff:bold
  --color=fg+:#78a9ff,bg+:#282828,hl+:#7bafad
  --bind 'ctrl-d:preview-page-down,ctrl-u:preview-page-up'
  --bind 'ctrl-f:preview-page-down'
  --bind 'ctrl-b:preview-page-up'
  "

# 4. CTRL-T: File search (Preview on the right, 50% width)
export FZF_CTRL_T_OPTS="
  --preview 'bat --style=numbers --color=always --line-range :500 {}'
  --preview-window right:$FZF_PREVIEW_WIDTH"

# ALT-C: Directory search
export FZF_ALT_C_OPTS="
  --preview 'tree -C --noreport {} | head -200'
  --preview-window right:$FZF_PREVIEW_WIDTH"
# 6. CTRL-R: History search (Keeps layout consistent)
export FZF_CTRL_R_OPTS="
  --preview 'echo {}'
  --preview-window down:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'"

# ---
# Bat
# ---
export BAT_THEME="Carbonfox"
