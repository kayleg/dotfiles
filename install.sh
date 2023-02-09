#!/bin/bash

echo "Have you set your shell to ZSH?"
read SHELL_SET

if !SHELL_SET
then
  echo "Set your shell to ZSH and rerun this script"
  exit -1
fi

echo "Enter you git email"
read GIT_EMAIL
echo "Enter you git name"
read GIT_NAME

# Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
source ~/.zshrc

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
source ~/.zshrc

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Brew items
brew install aws-cdk awscli brotli exa glab go heroku httpie htop jq mysql-client neovim \
  node prettierd protobuf protoc-gen-go-grpc pscale ripgrep starship thefuck tree-sitter \
  wget yarn efm-langserver gh git lima

brew cask install google-cloud-sdk

# Add font to font book
open nerd_font.otf
open nerd_font_italic.otf


# Generate new SSH Key
ssh-keygen -t ed25519 -C $GIT_EMAIL

# Symlink dot files over
mkdir -p ~/.config

ln -s config/nvim ~/.config/nvim
ln -s config/starship.toml ~/.config/starship.toml
ln -s zshrc ~/.zshrc
ln -s gitconfig ~/.gitconfig
ln -s gitignore ~/.gitignore
ln -s warp ~/.warp

sed -i '' "s/REPLACE_EMAIL/$GIT_EMAIL/g" gitconfig
sed -i '' "s/REPLACE_NAME/$GIT_NAME/g" gitconfig
sed -i '' "s/REPLACE_HOME_DIR/$HOME/g" gitconfig

source ~/.zshrc

echo "Everything is installed"
