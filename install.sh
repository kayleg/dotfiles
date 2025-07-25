#!/bin/zsh

echo "Enter you git email"
read GIT_EMAIL
echo "Enter you git name"
read GIT_NAME

# Link ZSHRC
ln -s `pwd`/zshrc $HOME/.zshrc

# Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zshprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install Brew items
brew install aws-cdk awscli brotli eza glab go heroku httpie htop jq mysql-client neovim \
  node prettierd protobuf protoc-gen-go-grpc pscale ripgrep starship thefuck tree-sitter \
  wget yarn efm-langserver gh git lima zellij zoxide mise

brew install --cask google-cloud-sdk hammerspoon ghostty

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Add font to font book
open nerd_font.otf
open nerd_font_italic.otf
open nerd_font_bold.otf
open nerd_font_bold_italic.otf

# Generate new SSH Key
ssh-keygen -t ed25519 -C $GIT_EMAIL

# Symlink dot files over
mkdir -p ~/.config

ln -s `pwd`/config/nvim $HOME/.config/nvim
ln -s `pwd`/config/starship.toml $HOME/.config/starship.toml
ln -s `pwd`/gitconfig $HOME/.gitconfig
ln -s `pwd`/gitignore $HOME/.gitignore
ln -s `pwd`/warp $HOME/.warp
ln -s `pwd`/hammerspoon $HOME/.hammerspoon
ln -s `pwd`/config/alacritty $HOME/.config/alacritty
ln -s `pwd`/config/zellij $HOME/.config/zellij
ln -s `pwd`/config/ghostty $HOME/.config/ghostty
ln -s `pwd`/tokyonight.nvim/extras/ghostty `pwd`/config/ghostty/themes

sed -i '' "s/REPLACE_EMAIL/$GIT_EMAIL/g" gitconfig
sed -i '' "s/REPLACE_NAME/$GIT_NAME/g" gitconfig
sed -i '' "s/REPLACE_HOME_DIR/$HOME/g" gitconfig

source ~/.zshrc

echo "Auto installation is complete"
echo "Make sure to download and install Alacritty from https://alacritty.org/"
