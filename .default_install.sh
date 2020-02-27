#!/bin/bash

softwares=(exa bat hexyl fd procs ripgrep)

for software in ${softwares[@]}
do
  brew install $software
done

