#!/bin/zsh
#
echo "COMMON INSTALLATION SCRIPT"

# General
# ------------------------------------------

echo "Configuring system..."

# Global configurations
cp .latexmkrc ~
cp .tmux.conf ~
cp .vimrc ~
cp .zshrc ~

# Install oh-my-zsh
RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Git
# ------------------------------------------

echo "Configuring git..."

# Setup ssh for GitHub
ssh -T git@github.com

git config --global user.name "Elie KADOCHE"
git config --global user.email eliekadoche78@gmail.com
git config --global core.editor nvim
git config --global core.filemode false
git config --global credential.helper store

# Configure GitHub cli (use tokens)
gh auth login

# Neovim
# ------------------------------------------

echo "Configuring neovim..."

# Configuration
mkdir -p ~/.config/nvim
cp init.lua ~/.config/nvim/init.lua

# Python packages
# ------------------------------------------

echo "Configuring Python..."

# TODO: carefully choose the python version
uv venv .venv --python 3.13
