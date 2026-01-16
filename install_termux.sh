#!/bin/zsh

# Update
pkg upgrade
pkg update

# zsh installation
pkg install -y zsh

# Others
pkg install -y git
pkg install -y wget
pkg install -y neovim

# Activate storage
termux-setup-storage
mkdir $HOME/storage/shared/data

# Launch common script
./install_apps_common.sh

# You can launch the script from here

# pkg
# ------------------------------------------

echo "Running pkg packages..."

pkg install -y binutils-is-llvm
pkg install -y build-essential
pkg install -y clang
pkg install -y cmake
pkg install -y e2fsprogs
pkg install -y ffmpeg
pkg install -y fzf
pkg install -y ghostscript
pkg install -y htop
pkg install -y imagemagick
pkg install -y iproute2
pkg install -y keepassxc
pkg install -y libandroid-execinfo
pkg install -y libicu
pkg install -y libopenblas
pkg install -y libxml2
pkg install -y libxslt
pkg install -y libzmq
pkg install -y lua-language-server
pkg install -y matplotlib
pkg install -y mpv
pkg install -y neofetch
pkg install -y netcat-openbsd
pkg install -y ninja
pkg install -y nmap
pkg install -y nodejs
pkg install -y ollama
pkg install -y openssh
pkg install -y openssl-tool
pkg install -y pandoc
pkg install -y pastel
pkg install -y patchelf
pkg install -y pwgen
pkg install -y python
pkg install -y python-numpy
pkg install -y python-torch
pkg install -y rsync
pkg install -y ruby
pkg install -y ruff
pkg install -y rust
pkg install -y screen
pkg install -y stylua
pkg install -y tealdeer
pkg install -y termux-api
pkg install -y tesseract
pkg install -y texlab
pkg install -y tmux
pkg install -y tor
pkg install -y tree
pkg install -y tree-sitter
pkg install -y unrar
pkg install -y unzip
pkg install -y uv
pkg install -y x11-repo
pkg install -y zip

# LaTeX
pkg install -y texlive-installer
termux-install-tl

# Python
# Check https://github.com/termux/termux-packages/discussions/19126
# ------------------------------------------

# Install specific packages
pip3 install setuptools wheel packaging pyproject_metadata cython meson-python versioner

# Termux configuration
# ------------------------------------------

echo "Configuring Termux..."

# Keyboard
# Enable / disable extra keys (see ek custom function)

# Download fira code font ttf file
cp FiraCode-Retina.ttf ~/.termux/font.ttf

termux-reload-settings
