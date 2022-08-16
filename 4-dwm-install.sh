#!/bin/bash

printf "\n"
printf "#########################################\n"
printf "##### Installing suckless utilities #####\n"
printf "#########################################\n\n"

git clone https://github.com/alokshandilya/suckless.git
cd suckless
./install.sh

printf "\n"
printf "##########################################\n"
printf "###### dwm is successfully installed######\n"
printf "##########################################\n\n"
