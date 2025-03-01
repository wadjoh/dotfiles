#!/bin/bash

if ! command -v chezmoi &> /dev/null || ! command -v fx &> /dev/null; then
  echo "Failed installing apps for silverblue environment"
  echo "The \`chezmoi\` or \`fx\` command was not found"
  exit 1
fi

OS_VARIANT=$(chezmoi data | fx .chezmoi.osRelease.variant)

if [[ "${OS_VARIANT}" != "Silverblue" ]]; then
  echo "Silverblue OS not detected; skipping Silverblue app installations"
  exit 0
fi

echo "Silverblue OS detected. Installing apps for Silverblue"

if ! command -v ghostty &> /dev/null; then
  install_ghostty
else
  echo "Skipping Ghostty installation (already installed)"
fi

install_ghostty() {
  sudo tee -a /etc/yum.repos.d/_copr:copr.fedorainfracloud.org:pgdev:ghostty.repo > /dev/null <<EOT
[copr:copr.fedorainfracloud.org:pgdev:ghostty]
name=Copr repo for Ghostty owned by pgdev
baseurl=https://download.copr.fedorainfracloud.org/results/pgdev/ghostty/fedora-\$releasever-\$basearch/
type=rpm-md
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://download.copr.fedorainfracloud.org/results/pgdev/ghostty/pubkey.gpg
repo_gpgcheck=0
enabled=1
enabled_metadata=1
EOT

  rpm-ostree update --install ghostty
}
