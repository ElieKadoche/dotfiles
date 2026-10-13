# Get system
_uname_s=$(uname -s)
_uname_o=$(uname -o 2>/dev/null || echo "$_uname_s")

# Update system name
if [[ $_uname_s == "Darwin" ]]; then
    _SYSTEM="darwin"
elif [[ $_uname_o == "Android" ]]; then
    _SYSTEM="android"
else
    _SYSTEM="unknown"
fi

# Unset unused variables
unset _uname_s _uname_o

# Prompt
PROMPT="%B%F{white}%n@%m %b%F{white}%1~%B%F{white} \$%f%b "

# Vim bindkeys
bindkey -v

# System specific
# ------------------------------------------
# ------------------------------------------

# Android (termux)
if [[ $_SYSTEM = "android" ]]; then
    ORIGIN="$HOME/storage/shared/data"
    alias pbcopy="termux-clipboard-set"
    alias open="termux-open"
    ek() {
        local cfg
        # Do not display extra keys
        if [[ "$1" = 0 ]]; then
            cfg="extra-keys = [[]]\nfullscreen = true"
        # Display extra keys
        elif [[ "$1" = 1 ]]; then
            cfg="extra-keys = [['F1','F2','F3','F4','F5','F6','F9','F12'], ['ESC','ALT','FN','/','PGUP','KEYBOARD','UP','DRAWER'], ['TAB','CTRL','HOME','|','PGDN','LEFT','DOWN','RIGHT']]\nfullscreen = true"
        # Otherwise
        else
            echo "Usage: ek {0|1}" >&2
            return 1
        fi
        echo "$cfg" >~/.termux/termux.properties
        termux-reload-settings
    }

# Darwin (terminal)
elif [[ $_SYSTEM = "darwin" ]]; then
    ORIGIN="$HOME/data"
    alias sed="gsed"
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
    export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

# Other systems
else
    ORIGIN="$HOME/data"
fi

# From template
# https://github.com/ohmyzsh/ohmyzsh/blob/master/templates/zshrc.zsh-template
# ------------------------------------------
# ------------------------------------------

# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Use hyphen-insensitive completion
HYPHEN_INSENSITIVE="true"

# Disable rm prompt
setopt RM_STAR_SILENT

# Plugins
plugins=(
    colored-man-pages
    extract
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Source default
source $ZSH/oh-my-zsh.sh

# Backup
# ------------------------------------------
# ------------------------------------------

# Private SSH variables are in a .zsh file located in $ZSH_CUSTOM
alias ssh0="ssh \$_SSH_USER_NAME@\$_SSH_PUBLIC_IP -p \$_SSH_PORT"
alias sshF="sshfs \$_SSH_USER_NAME@\$_SSH_PUBLIC_IP: -p \$_SSH_PORT ssh_folder"
sshL() { ssh -L "16006:127.0.0.1:$1" "$_SSH_USER_NAME@$_SSH_PUBLIC_IP" -p "$_SSH_PORT"; }

# !!!!! WARNING !!!!!
# The rsync command is powerful but dangerous if misused
# Always add -n (--dry-run) if you are unsure of your actions
# The best sync method is -c (--checksum), but it is costly
bbb() {
    if [[ "$1" = "android" ]]; then
        rsync -ivhc --cc=xxh128 --recursive --delete --iconv=utf-8,utf-8-mac --rsync-path=/opt/homebrew/bin/rsync --exclude={"/backup/*","/git_apps/*","/miscellaneous/*"} -e "ssh -p $_SSH_PORT" "$_SSH_USER_NAME@$_SSH_PUBLIC_IP:~/data/" "$ORIGIN/"
    elif [[ "$1" = "backup" ]]; then
        rsync -ivhc --cc=xxh128 --recursive --delete --iconv=utf-8,utf-8-mac --exclude={"/backup/completed/*","/documents/*","/git_apps/*"} "$ORIGIN/" /Volumes/backup/data/
    elif [[ "$1" = "safety" ]]; then
        rsync -ivhc --cc=xxh128 --recursive --delete --exclude={"/backup/completed/*","/git_apps/*"} "$ORIGIN/" /Volumes/safety/data/
    else
        echo "Usage: bbb {android|backup|safety}" >&2
        return 1
    fi
}

# Aliases
# ------------------------------------------
# ------------------------------------------

# Git
alias gitc="git cherry -v"
alias gitp="git pull"
alias gits="git status"
alias gitu="git config --get remote.origin.url"

# Display CSV files
alias csvv="vi -c 'set nowrap' -c 'set scrolloff=5' -c 'set number' -c '1split | wincmd w'"

# Complete and small ls with specific colors
export LS_COLORS="$LS_COLORS:di=1;97:fi=0;97:ex=0;97:no=0;90:"
alias l="ls --all --author --color=auto --group-directories-first --human-readable -l --size -v -1"
alias ll="ls --all --color=auto --group-directories-first -v -1"

# Others
alias ...="cd ../../"
alias ..="cd ../"
alias :q="exit"
alias duu="du -ah --max-depth=1 . | sort -hr"
alias e="exit"
alias m="cd $ORIGIN"
alias rm__="find . -name '._*' -ls -delete"
alias rmr="rm -rfI"
alias vim=nvim

# Functions
# ------------------------------------------
# ------------------------------------------

# Clear string
_clear_string() {
    local s
    s="$(printf '%s' "$1" | tr '\n' '_' | sed -E -e "s/[-':;,.]+/_/g" -e "s/[[:space:]]+/_/g" -e 's/_+/_/g' -e 's/_$//' -e 's/^_//')"
    printf '%s' "${s:l}"
}

# Clear string and copy the result to the clipboard
clearString() { _clear_string "$1" | pbcopy; }

# Clear string of all files present in current path
clearStringAll() {
    local file_path new_name ext
    for file_path in *; do
        ext="${file_path:e}"
        if [[ -f "$file_path" && -n "$ext" ]]; then
            new_name="$(_clear_string "${file_path:r}").${ext:l}"
        else
            new_name="$(_clear_string "$file_path")"
        fi
        [[ "$new_name" = "$file_path" ]] || mv -n -- "$file_path" "$new_name"
    done
}

# Main command to compile latex projects (or use latexmk)
compiletex() {
    lualatex "$1.tex"
    biber "$1"
    makeglossaries "$1"
    makeindex "$1.nlo" -s nomencl.ist -o "$1.nls"
    lualatex "$1.tex"
    lualatex "$1.tex"
}

# Miscellaneous
cpr() { rsync --archive --human-readable --info=progress2 "$1" "$2"; }
duuu() { find . -type f -exec du -h {} + | sort -rh | head -n "${1:-20}"; }
findd() { find . -iname "*$1*" 2>/dev/null; }
grepp() { grep -R "$1" . --ignore-case --exclude-dir={.git,.venv,data,docs,materials,resources}; }

# Music
mpva() { find "$ORIGIN/musics" -type f -exec mpv --shuffle --no-video {} +; }
mpvc() { find "$ORIGIN/musics/classical" -type f -exec mpv --shuffle --no-video {} +; }
mpvo() { find "$ORIGIN/musics/others" -type f -exec mpv --shuffle --no-video {} +; }
mpvs() { find "$ORIGIN/musics" -type f -ipath "*$1*" -exec mpv --shuffle --no-video {} +; }

# Clean Python files
pyclean() {
    find . -name "*.pyc" -ls -delete
    find . -name ".pytest_cache" -ls -exec rm -rf "{}" \;
    find . -name ".ruff_cache" -ls -exec rm -rf "{}" \;
    find . -name "__pycache__" -ls -delete
}

# Rename all files in a folder (oldest has index 0)
renameAll() {
    local idx=0 max nb_padding suffix file extension target
    local -a files tmp_names
    files=(*(.Om))
    max=$((${#files} - 1))
    ((max < 0)) && return 0
    nb_padding=${#max}
    suffix="${1:+_$1}"
    for file in $files; do
        tmp_names+=(".renameAll_tmp_${idx}")
        mv -- "$file" "${tmp_names[-1]}"
        ((idx++))
    done
    idx=0
    for file in $files; do
        extension="${file:e}"
        [[ -n "$extension" ]] && extension=".$extension"
        target="$(printf "%0${nb_padding}d" "$idx")${suffix}${extension}"
        if [[ -e "$target" ]]; then
            echo "renameAll: '$target' already exists, restoring '$file'" >&2
            mv -n -- "${tmp_names[idx + 1]}" "$file"
        else
            mv -- "${tmp_names[idx + 1]}" "$target"
        fi
        ((idx++))
    done
}

# Clean Tex files, argument for maxdepth
rmtex() {
    local depth="${1:-1}"
    local regex=".*\.(aux|dvi|log|out|toc|bbl|blg|synctex\.gz|acn|acr|alg|bcf|glg|glo|gls|ist|run\.xml|nav|snm|vrb|fls|fdb_latexmk|brf|loc|soc|ilg|ind|nlo|nls|lof|lot|maf|mtc[0-9]*)"
    find . -maxdepth "$depth" -type f -name "main-blx.bib" -delete
    if [[ $_SYSTEM = "darwin" ]]; then
        find -E . -maxdepth "$depth" -type f -regex "$regex" -delete
    else
        find . -maxdepth "$depth" -type f -regextype posix-extended -regex "$regex" -delete
    fi
}

# FZF functions
# ------------------------------------------
# ------------------------------------------

# Find directory
cdd() {
    local IFS=$'\n'
    local directories
    directories=($(find "$ORIGIN/" -type d | fzf-tmux --query="$1" --select-1 --exit-0))
    [[ -n "$directories" ]] && cd "${directories[1]}"
}

# Open URLs (default)
ff() {
    local IFS=$'\n'
    local files
    files=($(find "$ORIGIN/documents/internet" -name "*.html" | fzf-tmux --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && firefox "${files[@]}"
}

# Open URLs (private)
ffp() {
    local IFS=$'\n'
    local files
    files=($(find "$ORIGIN/documents/internet" -name "*.html" | fzf-tmux --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && firefox --private-window "${files[@]}"
}

# Kill process
fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [[ -n "$pid" ]]; then
        echo "$pid" | xargs kill -${1:-9}
    fi
}

# Show git commits
fshow() {
    git log --graph --color=always \
        --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
        fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
            --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# Open files with neovim
vv() {
    local IFS=$'\n'
    local files
    files=($(find "$ORIGIN/" -type f | fzf-tmux --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && vim "${files[@]}"
}

# Main commands
# ------------------------------------------
# ------------------------------------------

# Git pull
gitpp() { for i in */.git(N); do (
    echo "-----> $i"
    cd "$i/.." || continue
    git pull
); done; }

# Git status
gitss() { for i in */.git(N); do (
    echo "-----> $i"
    cd "$i/.." || continue
    git status --ignored
); done; }

# Execute git command on folders
_private_git_command() {
    (
        cd "$1" || return
        for i in */.git(N); do
            (
                printf "%s\n" "$i"
                cd "$i/.." || exit
                git "$2"
                echo ""
            )
        done
    )
}

# Argument is the command to execute (status, pull, etc.)
main_git() {
    printf "\nMAIN GIT\n"
    printf "------------------------------------------\n\n"
    _private_git_command "$ORIGIN/git_apps" "$1"
    _private_git_command "$ORIGIN/git_apps/_custom" "$1"
}

# Main update
main_update() {
    printf "\nMAIN UPDATE\n"
    printf "------------------------------------------\n\n"

    printf "---> npm\n"
    npm install -g npm@latest
    npx skills update

    if [[ $_SYSTEM = "android" ]]; then
        printf "---> PKG\n"
        pkg update -y
        pkg upgrade -y

    elif [[ $_SYSTEM = "darwin" ]]; then
        printf "---> darwin\n"
        softwareupdate --install --all

        printf "---> homebrew\n"
        brew update
        brew outdated
        brew upgrade
        brew upgrade --cask --greedy
    fi
}

# Main clean
main_clean() {
    printf "\nMAIN CLEAN\n"
    printf "------------------------------------------\n\n"

    if [[ $_SYSTEM = "android" ]]; then
        printf "---> PKG\n"
        pkg autoclean
        pkg clean

    elif [[ $_SYSTEM = "darwin" ]]; then
        printf "---> Homebrew\n"
        brew doctor
        brew autoremove
        brew cleanup
    fi
}

# Main all
main_all() {
    main_git pull
    main_git status
    main_update
    main_clean
    omz update

    printf "---> neovim\n"
    nvim --headless "+Lazy! sync" +qa
    nvim --headless "+lua require('nvim-treesitter').update():wait(300000)" +qa
}

# Python
# ------------------------------------------

# TODO: which python version?
alias python="python3"

# Automatically activate virtual environment
VENV_PATH="$HOME/.venv"
if [[ -f "$VENV_PATH/bin/activate" ]]; then
    source "$VENV_PATH/bin/activate"
fi

# Reset history to default when session is closed
trap "zsh_history_clear" 0
