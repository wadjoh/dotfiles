#!/bin/sh

# Commands from: https://macos-defaults.com/

echo "Setting macos defaults..."

# Scroll to Exposé app
defaults write com.apple.dock "scroll-to-open" -bool "true"

# Do not show thumbnail after taking screenshot
defaults write com.apple.screencapture "show-thumbnail" -bool "false"

# Show extensions in Finder
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

# Default Finder to column view
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"

# Show folders first in Finder
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"

# Disable extension change warning in Finder
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"

# Default to home directory in Finder when saving new document
defaults write NSGlobalDomain "NSDocumentSaveNewDocumentsToCloud" -bool "false"

# Enable three finger drag
defaults write com.apple.AppleMultitouchTrackpad "TrackpadThreeFingerDrag" -bool "true"

# Group windows by app in Mission Control
defaults write com.apple.dock "expose-group-apps" -bool "true"

killall Dock
killall Finder


