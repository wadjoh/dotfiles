#! /bin/bash

if ! command -v chezmoi &> /dev/null || ! command -v fx &> /dev/null; then
  echo "Failed installing apps for silverblue environment"
  echo "The \`chezmoi\` or \`fx\` command was not found"
  exit 1
fi

OS_VARIANT=$(chezmoi data | fx .chezmoi.osRelease.idLike)

if [[ "${OS_VARIANT}" != "arch" ]]; then
  echo "Arch distro not detected; skipping Arch app installations"
  exit 0
fi

echo "Arch OS detected. Installing apps for Arch"

# Ghostty terminal
if ! command -v ghostty &> /dev/null; then
  pacman -S ghostty
else
  echo "Skipping Ghostty installation (already installed)"
fi

# keyd - key remapper daemon to allow for MacOS style shortcuts
if ! command -v keyd &> /dev/null; then
  sudo pacman -Sy keyd
  sudo curl -o /etc/keyd/test.conf https://raw.githubusercontent.com/rvaiya/keyd/refs/heads/master/examples/macos.conf
  sudo systemctl enable keyd --now
else
  echo "Skipping keyd installation (already installed)"
fi
