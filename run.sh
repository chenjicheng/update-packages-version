#!/bin/bash

git config --global user.name "Github Actions"
git config --global user.email "git@chenjicheng.com"

if [[ -n $(cat repolist.txt) ]]; then
	while IFS=',' read -r line; do
		dir=$(basename $line .git)
		git clone $line
		cd $dir
		docker run --rm -e EXPORT_SRC=1 -v $PWD:/pkg ghcr.io/chenjicheng/docker-makepkg:main
		git commit -am "Update version"
		git push
		cd ..
		rm -rf $dir
	done < repolist.txt
fi
