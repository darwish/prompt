#!/bin/bash

set -euo pipefail

mkdir -p ~/.prompt
curl -fsSL "https://raw.githubusercontent.com/darwish/prompt/master/prompt.sh" -o ~/.prompt/prompt.sh
curl -fsSL "https://raw.githubusercontent.com/darwish/prompt/master/git-prompt.sh" -o ~/.prompt/git-prompt.sh

line=". ~/.prompt/prompt.sh"
if ! grep -qF "$line" ~/.bashrc; then
    echo -e "\n$line" >> ~/.bashrc
    echo "Prompt has been installed. Run '. ~/.bashrc' to reload."
else
    echo "prompt.sh already appears to be sourced in your .bashrc file."
fi

