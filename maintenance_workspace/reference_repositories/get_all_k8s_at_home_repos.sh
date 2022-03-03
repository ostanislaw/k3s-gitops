#!/bin/bash

curl -s https://github.com/k8s-at-home/awesome-home-kubernetes | grep href=\"https://github.com | sed -n "s/<td><a href=\"//p"  | sed 's/\">.*//g' | grep --invert-match 'p3lim/rudder' > repo_list.txt

while read p; do
  md5=$(echo $p | md5sum | cut -d ' ' -f 1)
  #echo "$md5"
  echo "cloning $p into $md5"
  git clone $p $md5
done <repo_list.txt
