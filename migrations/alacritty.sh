#!/bin/zsh

brew install zoxide zellij mise

ln -s `pwd`/../config/alacritty $HOME/.config/alacritty
ln -s `pwd`/../config/zellij $HOME/.config/zellij


cd ..
open nerd_font.otf \
&& open nerd_font_italic.otf \
&& open nerd_font_bold.otf \
&& open nerd_font_bold_italic.otf

echo "Make sure to download and install Alacritty from https://alacritty.org/"
