#!/usr/bin/bash

set -o emacs

echo -e "\e[33mSetup the multiple Neovim in your computer\e[0m"

# Check if Neovim is installed
if ! command -v nvim &> /dev/null; then
    echo "Neovim is not installed. Please install Neovim and run this setup script again."
    exit 1
fi


echo -e "\e[33mInstalling the NVchad...\e[0m"

git clone https://github.com/NvChad/NvChad ~/.config/NVchad

echo -e "\e[33mInstalling the Lazyvim...\e[0m"

git clone https://github.com/LazyVim/starter ~/.config/Lazyvim

echo -e "\e[33mInstalling the Astrovim...\e[0m"

git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/Astrovim

echo -e "\e[33mSetup the mnvim command...\e[0m"

# Add aliases and functions to .bashrc
echo 'alias nvim-chad="NVIM_APPNAME=NVchad nvim"' >> ~/.bashrc
echo 'alias nvim-astro="NVIM_APPNAME=Astrovim nvim"' >> ~/.bashrc
echo 'alias nvim-lasy="NVIM_APPNAME=Lasyvim nvim"' >> ~/.bashrc

echo 'function mnvim() {
  items=("my neovim" "NVchad" "Astrovim" "Lasyvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config >>" --height=50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "my neovim" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}' >> ~/.bashrc
source ~/.bashrc

echo -e "\e[32mSetup is completed\e[0m"
echo -e "Type \e[32mmnvim\e[0m to use the command"
