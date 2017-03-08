#!/bin/bash

echo "parse_git_branch() { " >> ~/.bashrc
echo "git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'" >> ~/.bashrc
echo " } " >> ~/.bashrc
echo 'export PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$(parse_git_branch)$ "' >> ~/.bashrc
source ~/.bashrc
