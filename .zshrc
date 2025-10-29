# Get system
if [[ $(uname -o) = "GNU/Linux" ]]; then
    _SYSTEM="linux"
elif [[ $(uname -o) = "Android" ]]; then
    _SYSTEM="android"
elif [[ $(uname -o) = "Darwin" ]]; then
    _SYSTEM="darwin"
fi

# Custom prompt
PROMPT="%F{green}%m@%n[%D{%d/%m/%y}-%D{%I:%M:%S%p}]%F{white}(%~)%f%F{green}$%f"

# Vim bindkeys
bindkey -v

# System specific
# ------------------------------------------
# ------------------------------------------

# Linux (terminal)
if [[ $_SYSTEM = "linux" ]]; then
    ORIGIN="/$HOME/data"
    alias xx="xtrlock"
    alias open="xdg-open"
    alias pbcopy="xclip -selection clipboard"
    alias pbpaste="xclip -selection clipboard -o"
    export PATH="$HOME/.local/bin:$PATH"

# Android (termux
elif [[ $_SYSTEM = "android" ]]; then
    ORIGIN="$HOME/storage/shared/data"
    alias mm="cd $HOME/storage/shared/Download"
    alias pbcopy="termux-clipboard-set"
    alias open="termux-open"
    ek() {
        # Do not display extra keys
        if [[ "$1" = 0 ]]; then
            cfg="extra-keys = [[]]\nfullscreen = true"
        # Display extra keys
        elif [[ "$1" = 1 ]]; then
            cfg="extra-keys = [['F1','F2','F3','F4','F5','F6','F9','F12'], ['ESC','ALT','FN','/','PGUP','KEYBOARD','UP','DRAWER'], ['TAB','CTRL','HOME','|','PGDN','LEFT','DOWN','RIGHT']]\nfullscreen = true"
        fi
        echo "$cfg" >~/.termux/termux.properties
        termux-reload-settings
    }

# Darwin (terminal)
elif [[ $_SYSTEM = "darwin" ]]; then
    ORIGIN="$HOME/data"
    alias sed="gsed"
    alias rmdsstore="find . -type f -name '*.DS_Store' -ls -delete"
    export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
    export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
fi

# From template
# https://github.com/ohmyzsh/ohmyzsh/blob/master/templates/zshrc.zsh-template
# ------------------------------------------
# ------------------------------------------

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    colored-man-pages
    colorize
    cp
    extract
    genpass
    git
    vi-mode
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Disable rm prompt
setopt RM_STAR_SILENT

# Aliases
# ------------------------------------------
# ------------------------------------------

# Display CSV files
alias csvv="vi -c 'set nowrap' -c 'set scrolloff=5' -c 'set number' -c '1split | wincmd w'"

# Open Firefox with default websites
alias fff="nohup firefox $ORIGIN/documents/internet/{google/mail.html,google/calendar.html} > /dev/null 2>&1 &; disown"

# Complete and small ls with specific colors
export LS_COLORS=$LS_COLORS:"di=1;97:fi=0;97:ex=0;97:no=0;90:"
alias l="ls --all --author --color=auto --group-directories-first --human-readable -l --size -v -1"
alias ll="ls --all --color=auto --group-directories-first -v -1"

# Music
mpva() {find $ORIGIN/musics -type f -exec mpv --shuffle --no-video {} +}
mpvc() {find $ORIGIN/musics/classical -type f -exec mpv --shuffle --no-video {} +}
mpvo() {find $ORIGIN/musics/others -type f -exec mpv --shuffle --no-video {} +}
mpvs() {find $ORIGIN/musics -type f -ipath "*$1*" -exec mpv --shuffle --no-video {} +}

# Others
alias ...="cd ../../"
alias ..="cd ../"
alias :q="exit"
alias duu="du -ah --max-depth=1 . | sort -hr"
alias e="exit"
alias m="cd $ORIGIN"
alias rm__="find . -name '._*' -ls -delete"
alias rmr="rm -rfI"
alias src="source ~/.zshrc"
alias vim=nvim

# Backup
# ------------------------------------------
# ------------------------------------------

# Private SSH variables are in a .zsh file located in $ZSH_CUSTOM
alias ssh0="ssh $_SSH_USER_NAME@$_SSH_PUBLIC_IP -p $_SSH_PORT"
alias sshF="sshfs $_SSH_USER_NAME@$_SSH_PUBLIC_IP: -p $_SSH_PORT ssh_folder"
alias sshX="ssh -X $_SSH_USER_NAME@$_SSH_PUBLIC_IP -p $_SSH_PORT"
sshL() { ssh -L 16006:127.0.0.1:$1 $_SSH_USER_NAME@$_SSH_PUBLIC_IP -p $_SSH_PORT; }
scpp() { scp -r -p -P $_SSH_PORT $1 $_SSH_USER_NAME@$_SSH_PUBLIC_IP:~/Downloads; }

# !!!!! WARNING !!!!!
# The rsync command is powerful but dangerous if misused
# Always add -n (--dry-run) if you are unsure of your actions
# The best sync method is -c (--checksum), but it is costly
bbb() {
    if [[ "$1" = "android" ]]; then
        rsync -ivhc --cc=xxh128 --recursive --delete --iconv=utf-8,utf-8-mac --rsync-path=/opt/homebrew/bin/rsync --exclude={"/backup/*","/git_apps/*","/miscellaneous/*"} -e "ssh -p $_SSH_PORT" $_SSH_USER_NAME@$_SSH_PUBLIC_IP:~/data/ $ORIGIN/
    elif [[ "$1" = "backup" ]]; then
        rsync -ivhc --cc=xxh128 --recursive --delete --iconv=utf-8,utf-8-mac --exclude={"/backup/completed/*","/documents/*","/git_apps/*"} $ORIGIN/ /Volumes/backup/data/
    elif [[ "$1" = "safety" ]]; then
        rsync -ivhc --cc=xxh128 --recursive --delete --exclude={"/backup/completed/*","/git_apps/*"} $ORIGIN/ /Volumes/safety/data/
    fi
}

# Functions
# ------------------------------------------
# ------------------------------------------

# Clear string: replace [spaces / tabs / new lines], special characters, etc., by _, and remove capital letters
clearString() {
    echo $1 | sed -z "s/\n/_/g" | sed -E -e "s/-/ /g" | sed -E -e "s/'/ /g" | sed -E -e "s/\: |\-|\, |\; |\. /_/g" | sed -E -e "s/[[:blank:]]+/_/g" | sed -e "s/\(.*\)/\L\1/" | sed "s/.$//" | pbcopy
}

# Clear string of all files present in current path
clearStringAll() {
    for file_path in *; do (
        clearString $file_path
        mv $file_path $(pbpaste)
    ); done
}

# Clear thumbnails folders
clearThumbnails() {
    find . -name ".thumbnails" -ls -exec rm -rf "{}" \;
    find . -name ".Thumbnails" -ls -exec rm -rf "{}" \;
}

# Main command to compile latex projects (or use latexmk)
# bibtex / biber: both can be used, depending on how the bibliography is made
# A different compilator can be used, as pdflatex for example
compiletex() {
    lualatex "$1.tex"
    biber "$1"
    makeglossaries "$1"
    makeindex $1.nlo -s nomencl.ist -o $1.nls
    lualatex "$1.tex"
    lualatex "$1.tex"
}

# Countdown function, argument is in seconds
countdown() {
    countdown=$1
    while [ $countdown -gt 0 ]; do
        echo -ne "\r--> $countdown <-- "
        countdown=$((countdown - 1))
        sleep 1
    done
    echo -ne "\r--> 0 <-- \n"
}

# Copy folder with progress bar
cpr() { rsync --archive --human-readable --info=progress2 $1 $2; }

# Find $1 largest files
duuu() { find . -type f -exec du -h {} + | sort -rh | head -n $1; }

# Fatal kill
fatalKill() { ps aux | grep $1 | grep -v grep | awk "{print $2}" | xargs kill -9; }

# Find files and folders, case insensitive
findd() { find . -iname "*$1*" 2>/dev/null; }

# Find out the pid of a specified process (regex are working)
# WARNING: without sudo it will only find processes of the current user
findPID() { lsof -t -c "$@"; }

# Find files of a given extension
findSameExtension() { find . -iname \*.$1; }

# Get command history
getHistory() { history | awk "{print $2}" | sort | uniq -c | sort -nr | head -n $1; }

# Special grep for projects
grepp() { grep -R "$1" . --ignore-case --exclude-dir={.git,.venv,data,docs,materials,resources}; }

# Create a password of size $1
pwgenn() { pwgen -cny --secure $1 1 | pbcopy; }

# Clean Python files
pyclean() {
    find . -name "*.pyc" -ls -delete
    find . -name "__pycache__" -ls -delete
    find . -name ".pytest_cache" -ls -exec rm -rf "{}" \;
}

# Rename all files in a folder
# ls -tr: oldest modified file will have index 0
renameAll() {
    idx=0
    nb_files=$(($(ls -1 | wc -l) - 1))
    nb_padding=$(echo "${#nb_files}")
    find . -maxdepth 1 -type f | xargs -r ls -tr | while read file; do
        extension=$(python -c "import os, sys; _, ext = os.path.splitext(sys.argv[1]); print(ext)" $file)
        idx_name=$(printf "%0${nb_padding}d\n" $idx)
        if [ -n "$1" ]; then
            mv $file ${idx_name}_$1${extension}
        else
            mv $file ${idx_name}$1${extension}
        fi
        idx=$((idx + 1))
    done
}

# Clean Tex files, argument for maxdepth
rmtex() {
    find . -maxdepth $1 -name "main-blx.bib" -delete
    if [[ $_SYSTEM = "darwin" ]]; then
        find -E . -maxdepth $1 -regex ".*\.(aux|dvi|log|out|toc|bbl|blg|synctex.gz|acn|acr|alg|bcf|glg|glo|gls|ist|run.xml|nav|snm|vrb|fls|fdb_latexmk|brf|loc|soc|ilg|ind|nlo|nls|lof|lot|maf|mtc.*)" -delete
    else
        find . -maxdepth $1 -regex ".*\.\(aux\|dvi\|log\|out\|toc\|bbl\|blg\|synctex.gz\|acn\|acr\|alg\|bcf\|glg\|glo\|gls\|ist\|run.xml\|nav\|snm\|vrb\|fls\|fdb_latexmk\|brf\|loc\|soc\|ilg\|ind\|nlo\|nls\|lof\|lot\|maf\|mtc.*\)" -delete
    fi
}

# Functions to download videos (format index, link)
yyy() { yt-dlp --verbose --output "%(title)s.mp3" $2 -f $1 -x --audio-format "mp3" --rm-cache-dir; }

# fzf
# ------------------------------------------
# ------------------------------------------

# Find directory
cdd() {
    IFS=$"\n" directories=($(find $ORIGIN/ -type d | fzf-tmux --query="$1" --multi --select-1 --exit-0))
    [[ -n "$directories" ]] && cd "${directories[@]}"
}

# Open firefox favorites with fzf
ff() {
    IFS=$"\n" files=($(find $ORIGIN/documents/internet -name "*.html" | fzf-tmux --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && firefox "${files[@]}"
}

# Open firefox favorites with fzf (private window)
ffp() {
    IFS=$"\n" files=($(find $ORIGIN/documents/internet -name "*.html" | fzf-tmux --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && firefox --private-window "${files[@]}"
}

# fkill - kill process (from fzf)
fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk "{print $2}")

    if [[ "x$pid" != "x" ]]; then
        echo $pid | xargs kill -${1:-9}
    fi
}

# fshow - git commit browser (from fzf)
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

# Open files with nvim
vv() {
    IFS=$"\n" files=($(find $ORIGIN/ -type f | fzf-tmux --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && vim "${files[@]}"
}

# Open files (general)
oo() {
    IFS=$"\n" files=($(find . -type f | fzf-tmux --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && open "${files[@]}"
}

# Main git + python
# ------------------------------------------
# ------------------------------------------

# Aliases
alias gitc="git cherry -v"
alias gitp="git pull"
alias gits="git status"
alias gitu="git config --get remote.origin.url"

# Simple functions
gitd_() {
    git add -A
    git commit -m "Done"
    git push
}
gitpp() { for i in */.git; do (
    echo $i
    cd $i/..
    git pull
); done; }
gitss() { for i in */.git; do (
    echo "-----> " $i
    cd $i/../
    git status --ignored
); done; }

# Execute git pull on folders
_private_git_command() {
    cd $1
    for i in */.git; do
        (
            printf "$i\n"
            cd $i/..
            git $2
            echo ""
        )
    done
}

# Argument is the command to execute (status, pull, etc.)
main_git() {
    printf "MAIN GIT\n"
    printf "------------------------------------------\n\n"
    _private_git_command $ORIGIN/git_apps $1
    _private_git_command $ORIGIN/git_apps/_custom $1
    cd $ORIGIN
}

# Install / update python packages from $1 files
# WARNING: this function is NOT integrated to the main_all function
main_python() {
    python -m pip install --upgrade pip
    local failed=()
    while IFS= read -r pkg || [[ -n $pkg ]]; do
        [[ -z $pkg || $pkg == \#* ]] && continue
        pip install --upgrade "$pkg" || failed+=("$pkg")
    done <$1
    ((${#failed[@]})) && echo "failed to install: ${failed[*]}" || echo "all packages installed"
}

# Main update
# ------------------------------------------
# ------------------------------------------

main_update() {
    printf "MAIN UPDATE\n"
    printf "------------------------------------------\n\n"

    if [[ $_SYSTEM = "android" ]]; then
        printf "---> PKG\n"
        pkg upgrade -y
        pkg update -y

    elif [[ $_SYSTEM = "linux" ]]; then
        printf "---> APT\n"
        sudo apt -y update
        sudo apt -y upgrade
        sudo apt dist-upgrade
        # sudo update-grub;  # Only if necessary

    elif [[ $_SYSTEM = "darwin" ]]; then
        printf "---> darwin\n"
        softwareupdate --install --all

        printf "---> Homebrew\n"
        brew update
        brew outdated
        brew upgrade
        brew upgrade --cask --greedy
    fi
}

# Main compile
# ------------------------------------------
# ------------------------------------------

main_compile() {
    printf "MAIN COMPILE\n"
    printf "------------------------------------------\n\n"

    printf "---> lesspass\n"
    python -m pip install $ORIGIN/git_apps/lesspass/cli

    if [[ $_SYSTEM = "linux" ]]; then
        printf "---> Katago\n"
        cd $ORIGIN/git_apps/KataGo/cpp
        if [[ ! -d "./build" ]]; then mkdir build; fi
        cd build
        cmake .. -DUSE_BACKEND=CUDA -DCUDNN_INCLUDE_DIR=/usr/local/cuda/include -DCUDNN_LIBRARY=/usr/local/cuda/lib64/libcudnn.so
        make
    fi

    cd $ORIGIN
}

# Main clean
# ------------------------------------------
# ------------------------------------------

main_clean() {
    printf "MAIN CLEAN\n"
    printf "------------------------------------------\n\n"

    printf "---> PIP\n"
    pip cache purge

    if [[ $_SYSTEM = "android" ]]; then
        printf "---> PKG\n"
        pkg autoclean
        pkg clean

    elif [[ $_SYSTEM = "linux" ]]; then
        printf "---> LOGS\n"
        journalctl --disk-usage
        sudo journalctl --vacuum-time=1d

        printf "---> APT\n"
        sudo apt -y autoclean
        sudo apt -y clean
        sudo apt -y autoremove

    elif [[ $_SYSTEM = "darwin" ]]; then
        printf "---> Homebrew\n"
        brew doctor
        brew cleanup
        brew autoremove
    fi
}

# Main all
# ------------------------------------------
# ------------------------------------------

main_all() {
    main_git pull
    main_git status
    main_update
    main_compile
    main_clean
    omz update

    printf "---> neovim\n"
    nvim --headless +"TSUpdate" +q
    nvim --headless +"Lazy sync" +q

    if [[ $_SYSTEM = "linux" ]]; then
        sudo killall -3 gnome-shell
    fi
}

# Additional plugins
source $ORIGIN/git_apps/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ORIGIN/git_apps/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Python
# ------------------------------------------

# TODO: which python version?
alias python="python3"

# Python functions
alias mdd="python -m rich.markdown"
alias lpl="python $ORIGIN/git_apps/lesspass/cli/lesspass/core.py"

# Automatically activate virtual environment
VENV_PATH="$HOME/.venv"
if [ -d "$VENV_PATH" ]; then
    source "$VENV_PATH/bin/activate"
fi

# Most used commands are kept in a custom history
# When a session is closed, history is reset to default
# zsh_history_clear is declared in a .zsh file located in $ZSH_CUSTOM
trap "zsh_history_clear" 0
