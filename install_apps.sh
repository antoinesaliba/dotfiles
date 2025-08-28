#!/usr/bin/env zsh

set -e

grep -qxF 'export XDG_CONFIG_HOME="$HOME/.config"' ~/.zshrc || echo 'export XDG_CONFIG_HOME="$HOME/.config"' >> ~/.zshrc
grep -qxF 'export ZDOTDIR="$XDG_CONFIG_HOME/zsh"' ~/.zshrc || echo 'export ZDOTDIR="$XDG_CONFIG_HOME/zsh"' >> ~/.zshrc
grep -qxF 'source $ZDOTDIR/aliases' ~/.zshrc || echo 'source $ZDOTDIR/aliases' >> ~/.zshrc
grep -qxF 'source $ZDOTDIR/exports' ~/.zshrc || echo 'source $ZDOTDIR/exports' >> ~/.zshrc
grep -qxF 'source ~/.config/zsh/.zshrc' ~/.zshrc || echo 'source ~/.config/zsh/.zshrc' >> ~/.zshrc
source ~/.zshrc && echo "Sourced .zshrc"

# Check to see if Homebrew is installed, and install it if it is not
command -v brew >/dev/null 2>&1 || { echo >&2 "Installing Homebrew"; \
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/testuser/.zprofile; eval "$(/opt/homebrew/bin/brew shellenv)" }

echo "Updating Homebrew" && brew update

brew bundle --file=- <<-EOS
brew "neovim"
brew "fzf"
brew "ripgrep"
brew "trash"
brew "standard"
brew "lazygit"
brew "awscli"
brew "node"
brew "tree"
brew "hashicorp/tap/terraform-ls"
cask "homebrew/cask-fonts/font-hack-nerd-font"
cask "session-manager-plugin"
EOS

curl -fsSL https://bun.sh/install | bash
bun add -g @kkidd/aicommit

if [ ! -d "${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}/.zprezto" ] ; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}/.zprezto"
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
fi

$(brew --prefix)/opt/fzf/install --all --xdg

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
# Use the highest possible version of node per-project
nvm alias default node

aws configure set region us-east-1

echo "All Done!"
