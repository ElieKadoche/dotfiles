#!/bin/zsh

# tmux configuration
cp .tmux.conf ~

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ZSH configuration
cp .zshrc ~

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
python3 -m venv ~/.venv

# Virtual environment
source ~/.venv/bin/activate

# Install required packages
uv pip install autopep8
uv pip install neovim
uv pip install pycodestyle
uv pip install pydocstyle
uv pip install python-lsp-isort
uv pip install python-lsp-ruff
uv pip install "python-lsp-server[all]"
