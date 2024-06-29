#! /bin/bash

if ! command -v brew &> /dev/null
then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Next steps according to brew install script installation script
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/wjohnson/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
