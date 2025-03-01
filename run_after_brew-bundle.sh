#!/bin/bash

if command -v brew &> /dev/null; then
  brew bundle --global
fi

if command -v code &> /dev/null; then
  brew bundle ~/.vscode.Brewfile
fi
