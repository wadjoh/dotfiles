#! /bin/bash

if ! command -v brew &> /dev/null
then
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
    exit 1
fi
