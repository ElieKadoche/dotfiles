#!/bin/zsh

# Command line tools
xcode-select --install

# Rosetta 2
sudo softwareupdate --install-rosetta

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install ZSH
brew install zsh
chsh -s /usr/local/bin/zsh

# Check Python with system version
brew install python@3.10

# Install Brew packages
brew install bibtex-tidy
brew install box2d
brew install clang-format
brew install cmake
brew install cmatrix
brew install coreutils
brew install curl
brew install dos2unix
brew install ffmpeg
brew install fzf
brew install gcc
brew install ghostscript
brew install git
brew install gnu-sed
brew install graphviz
brew install htop
brew install imagemagick
brew install jpeg-turbo
brew install katago
brew install languagetool
brew install latexindent
brew install ltex-ls-plus
brew install lua
brew install lua-language-server
brew install meson
brew install ncdu
brew install neovim
brew install nmap
brew install node
brew install ollama
brew install openjdk
brew install openssh
brew install pandoc
brew install pastel
brew install poppler
brew install pwgen
brew install rsync
brew install ruby
brew install screen
brew install stylua
brew install tesseract
brew install texlab
brew install tlrc
brew install tmux
brew install tor
brew install transmission-cli
brew install tree
brew install tree-sitter
brew install tree-sitter-cli
brew install typos-cli
brew install watch
brew install wget
brew install xclip

# Install Brew cask packages
brew install --cask adobe-acrobat-reader
brew install --cask audacity
brew install --cask calibre
brew install --cask discord
brew install --cask firefox
brew install --cask google-chrome
brew install --cask gopanda
brew install --cask inkscape
brew install --cask keepassxc
brew install --cask libreoffice
brew install --cask mpv
brew install --cask openmtp
brew install --cask rawtherapee
brew install --cask sabaki
brew install --cask skim
brew install --cask tor-browser
brew install --cask transmission
brew install --cask vlc
brew install --cask whatsapp
brew install --cask zoom

# Install fonts
brew tap homebrew/cask-fonts
brew install --cask font-fira-code
brew install --cask font-source-sans-pro

# LaTeX
# brew install texlive
brew install --cask mactex

# Apple toolbox for machine learning
pip install coremltools

# Change default parameters
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g QLPanelAnimationDuration -float 0
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.finder QuitMenuItem -bool YES
defaults write com.apple.screencapture location ~/Downloads

# Others
# Install https://github.com/textext/textext/releases
# python setup.py --pdflatex-executable=$(which pdflatex) --skip-requirements-check
