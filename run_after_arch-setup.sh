#! /bin/bash

if ! command -v chezmoi &> /dev/null || ! command -v fx &> /dev/null; then
  echo "Failed installing apps for arch environment"
  echo "The \`chezmoi\` or \`fx\` command was not found"
  exit 1
fi

if ! command -v pacman &> /dev/null; then
  echo "Arch distro not detected; skipping Arch app installations"
  exit 0
fi

# Set default shell for user
echo $(which zsh) | sudo tee -a /etc/shells
sudo chsh -s $(which zsh) wade

echo "Arch OS detected. Installing apps for Arch"

# allow ssh connections
if ! systemctl is-active --quiet sshd &> /dev/null; then
  sudo ufw allow ssh
  sudo ufw enable
  sudo systemctl start sshd
  sudo systemctl enable sshd
fi

# Docker
if ! command -v docker &> /dev/null; then
  echo "Installing Docker"
  sudo pacman -S docker
fi

# Docker Compose
if ! command -v docker-compose &> /dev/null; then
  echo "Installing Docker Compose"
  sudo pacman -S docker-compose
fi

# Make sure Docker is running and active
if ! systemctl is-active --quiet docker &> /dev/null; then
  echo "Starting and enabling the Docker daemon"
  sudo systemctl start docker
  sudo systemctl enable docker
else
  echo "Docker is already active"
fi

# Run Docker without sudo
if ! id -nG "$USER" | grep -qw "docker"; then
  if ! getent group docker &> /dev/null; then
    echo "Creating `docker` group"
    sudo groupadd docker
  fi
  echo "Adding user to `docker` group. NOTE: This won't take effect until after a reboot!"
  sudo usermod -aG docker $USER
else
  echo "User already in `docker` group"
fi

sudo usermod -aG docker $USER

# Ghostty terminal
if ! command -v ghostty &> /dev/null; then
  pacman -S ghostty
else
  echo "Skipping Ghostty installation (already installed)"
fi

# keyd - key remapper daemon to allow for MacOS style shortcuts
init_keyd_conf_content() {
  # copied from https://github.com/rvaiya/keyd/blob/0cbe717b63c73de7872013b0834d90d802047546/examples/macos.conf
  # with some of my own modifications
  KEYD_CONF=$(cat <<'EOF'
# NOTE: to use this, rename this file to default.conf and put in /etc/keyd/

# Mac-Like Configuration Example
#
# Uses "Alt" button to the left of spacebar as "Cmd" key
#
# Note:
#   This 'trick' generally requires that the press+release of the Meta
#   key will do nothing. On my system, I had to disable the "overlay-key"
#   in mutter to make it inert:
#     - `gsettings set org.gnome.mutter overlay-key ''`

[ids]
*

[main]

# Create a new "Cmd" button, with various Mac OS-like features below
leftalt = layer(meta_mac)

# Swap meta/alt
leftmeta = alt


# meta_mac modifier layer; inherits from 'Ctrl' modifier layer
#
# The main part! Using this layer, we can remap our new "Cmd" key to
# do almost everything our muscle memory might need...
[meta_mac:C]

# Meta-Space: Open the Launcher (a feature of gnome-shell)
# keybinding: ? how did we arrive at M-/ ?
space = M-/

# Switch directly to an open tab (e.g. Firefox, VS code)
1 = A-1
2 = A-2
3 = A-3
4 = A-4
5 = A-5
6 = A-6
7 = A-7
8 = A-8
9 = A-9

# Copy
c = C-insert
# Paste
v = S-insert
# Cut
x = S-delete
# Clear screen in Ghostty
k = M-k


# Move cursor to beginning of line
left = home
# Move cursor to end of Line
right = end

# As soon as tab is pressed (but not yet released), we switch to the
# "app_switch_state" overlay where we can handle Meta-Backtick differently.
# Also, send a 'M-tab' key tap before entering app_switch_sate.
tab = swapm(app_switch_state, M-tab)

# Meta-Backtick: Switch to next window in the application group
# - A-f6 is the default binding for 'cycle-group' in gnome
# - keybinding: `gsettings get org.gnome.desktop.wm.keybindings cycle-group`
` = A-f6


# app_switch_state modifier layer; inherits from 'Meta' modifier layer
[app_switch_state:M]

# Meta-Tab: Switch to next application
# - keybinding: `gsettings get org.gnome.desktop.wm.keybindings switch-applications`
tab = M-tab
right = M-tab

# Meta-Backtick: Switch to previous application
# - keybinding: `gsettings get org.gnome.desktop.wm.keybindings switch-applications-backward`
` = M-S-tab
left = M-S-tab
EOF
  )
}

if ! command -v keyd &> /dev/null; then
  sudo pacman -Sy keyd
  init_keyd_conf_content
  sudo echo "${KEYD_CONF}" > /etc/keyd/default.conf
  sudo systemctl enable keyd --now
else
  echo "Skipping keyd installation (already installed)"
fi
