# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="refined"

VI_MODE_SET_CURSOR=true
VI_MODE_CURSOR_NORMAL=2
VI_MODE_CURSOR_INSERT=6
MODE_INDICATOR="%F{red}[N]%f"
INSERT_MODE_INDICATOR="%F{green}[I]%f"

plugins=(
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
    vi-mode
)



source $ZSH/oh-my-zsh.sh

# Vi mode: prompt symbol muda entre modos (❯ insert, ❮ normal)
function _vi_prompt_symbol() {
  if [[ ${VI_KEYMAP:-main} == vicmd ]]; then
    echo "%F{red}❮%f "
  else
    echo "%(?.%F{magenta}.%F{red})❯%f "
  fi
}
PROMPT='$(_vi_prompt_symbol)'
RPROMPT='$(vi_mode_prompt_info)'


# Check archlinux plugin commands here
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux


# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos



### From this line is for pywal-colors
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
#(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
#cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
#source ~/.cache/wal/colors-tty.sh

# My alias 

alias cty='tty-clock -S -c -C 6 -t -n -D'
alias fucking='sudo'
alias n='nvim'
alias t='tmux'
alias ta='tmux attach'
alias tl='tmux ls'
alias cd..='cd ..'
alias gc='git clone '
alias ga='git add .'
alias gcm='git commit -m '
alias gp='git push -u orign main'
alias gs='git status'
alias ll='ls -Alh'
alias ls='lsd --group-dirs first'
alias cat='bat'
alias gc='g++ -o o'
alias py='python3'
alias py='python3'
alias c='sudo rsync -avhW --no-compress --progress '
alias code='code --ozone-platform=x11'
alias kiro='kiro --ozone-platform=x11'
alias y='yazi'
alias md1='sudo mount /dev/sda5 /mnt/vmachines'
alias md2='sudo mount /dev/sda4 /mnt/windows-drive'
alias web='tmuxifier load-session web-dev'
alias lg='lazygit'
alias nivm='nvim'
alias pdf='firefox'
alias cd='z'
alias s='yay -Ss '
alias i='yay -S '
alias u='yay -Syu '
alias tk='tmux kill-server'
alias ntest='bash /home/ahmad/.config/hypr/UserScripts/networkTest.sh'
alias server='ssh -i ~/.ssh/ssh-key-2025-09-06.key ubuntu@140.245.24.242'

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory


# exports
# export LC_TIME=ur_PK.UTF-8
export PATH="$HOME/.local/bin:$HOME/.tmuxifier/bin:$PATH"
export LIBVIRT_DEFAULT_URI='qemu:///system'
eval "$(zoxide init zsh)"
eval "$(tmuxifier init -)"
export PATH=$PATH:/home/ahmad/.spicetify
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/var/lib/snapd/snap/bin:$PATH"

# gpick - Git repository picker with database configuration
# Usage:
#   gpick              → opens interactive menu (fzf)
#   gpick 1            → clones project 1 from the list
#   gpick 2 -r         → opens repository 2 in browser
#   gpick 3 -db        → shows database configuration for project 3
function gpick() {
    local index=""
    local read_only=false
    local show_db=false
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -r) read_only=true; shift ;;
            -db) show_db=true; shift ;;
            [0-9]*) index=$1; shift ;;
            *) shift ;;
        esac
    done
    
    # Repository data as simple arrays
    local repo_names=(
        "Attendace Backend - attendance-totem"
        "admin-Bff - admin-attendance-bff"
        "admin-front - admin-totem-attendance"
        "totem-front"
        "totem-bff"
    )
    
    local repo_urls=(
        "git@github.com:Mottu-ops/attendance-totem.git"
        "git@github.com:Mottu-ops/admin-attendance-bff.git"
        "git@github.com:Mottu-ops/admin-totem-attendance.git"
        "git@github.com:Mottu-ops/totem-front.git"
        "git@github.com:Mottu-ops/attendance-totem-bff.git"
    )
    
    local db_hosts=(
        "db-rental-hml-mottu-321312.mottu.internal"
        "-"
        "-"
        "-"
        "-"
    )
    
    local db_ports=("5432" "0" "0" "0" "0")
    local db_users=("app_attendance_v2_hml" "-" "-" "-" "-")
    local db_passes=("attendance_v2_hml" "-" "-" "-" "-")
    local db_names=("attendance_v2_hml" "-" "-" "-" "-")
    
    # Function to show database config
    show_db_config() {
        local idx=$1
        echo ""
        echo -e "\033[36m🗃️  Database Configuration for ${repo_names[$idx]}\033[0m"
        echo "──────────────────────────────────────"
        echo -e "\033[33mHost:     ${db_hosts[$idx]}\033[0m"
        echo -e "\033[32mPort:     ${db_ports[$idx]}\033[0m"
        echo -e "\033[35mUser:     ${db_users[$idx]}\033[0m"
        echo -e "\033[90mPassword: ${db_passes[$idx]}\033[0m"
        echo -e "\033[34mDB Name:  ${db_names[$idx]}\033[0m"
        echo ""
    }
    
    # Function to clone repository
    clone_repo() {
        local idx=$1
        git clone "${repo_urls[$idx]}"
        local folder=$(basename "${repo_urls[$idx]}" .git)
        echo -e "\033[32m✅ Clonado '${repo_names[$idx]}' em ./$folder\033[0m"
    }
    
    # If index is provided, handle direct actions
    if [[ -n "$index" ]]; then
        if [[ $index -lt 1 || $index -gt 5 ]]; then
            echo -e "\033[31m❌ Índice inválido. Use 1-5.\033[0m"
            return 1
        fi
        
        # Show database configuration
        if $show_db; then
            show_db_config $index
            return 0
        fi
        
        # Open repository in browser
        if $read_only; then
            local url="${repo_urls[$index]%.git}"
            xdg-open "$url" 2>/dev/null || firefox "$url" 2>/dev/null
            return 0
        fi
        
        # Clone repository
        clone_repo $index
        return 0
    fi
    
    # Interactive menu with fzf
    if ! command -v fzf &> /dev/null; then
        echo -e "\033[31m⚠️  fzf não encontrado. Instale com 'yay -S fzf'.\033[0m"
        return 1
    fi
    
    local selected=$(printf '%s\n' "${repo_names[@]}" | fzf --prompt "📦 Selecione um projeto: ")
    
    if [[ -z "$selected" ]]; then
        echo -e "\033[33m❌ Cancelado pelo usuário.\033[0m"
        return 0
    fi
    
    # Find which repo was selected
    for i in {1..5}; do
        if [[ "${repo_names[$i]}" == "$selected" ]]; then
            clone_repo $i
            return 0
        fi
    done
}

# Alias alternativo
alias mclone='gpick'

# Função para ir para o diretório mottu
function mottu() {
    cd "$HOME/mottu"
}

# Função para fazer backup das configurações do Hyprland
function hypr-backup() {
    echo "🔄 Fazendo backup das configurações..."
    
    # Copiar arquivos atualizados
    cp -r ~/.config/hypr ~/hypr-dotfiles/
    cp ~/.zshrc ~/hypr-dotfiles/
    
    # Atualizar README com data
    cd ~/hypr-dotfiles
    
    # Commit e push
    git add .
    git commit -m "Update: $(date '+%Y-%m-%d %H:%M')"
    git push origin main
    
    echo "✅ Backup concluído e enviado para o GitHub!"
}

# OpenClaw Gateway Token
export OPENCLAW_GATEWAY_TOKEN=f43b06b39a0133a803328ed1064444d9ea262f77fcb4997f

# OpenClaw Completion
source "/home/higor/.openclaw/completions/openclaw.zsh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/higor/mottu/hack-the-garage/google-cloud-sdk/path.zsh.inc' ]; then . '/home/higor/mottu/hack-the-garage/google-cloud-sdk/path.zsh.inc'; fi

source "$HOME/.config/mottu/mottu_user_profile.sh"
source "$HOME/.config/mottu/mottu_dev_tools.sh"
source "$HOME/.config/mottu/mottu_rmq.sh"
# Added by LM Studio CLI tool (lms)
export PATH="$PATH:/home/higor/.lmstudio/bin"

# opencode
export PATH=/home/higor/.opencode/bin:$PATH

# Vi mode extras
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
