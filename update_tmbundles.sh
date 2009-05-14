#!/bin/bash

path=/Users/lucashungaro/Library/Application\ Support/TextMate/Bundles
cd "${path}"
for i in $(ls); do
  echo "atualizando $i"
  cd $i;
  git pull;
  cd .. ;
done