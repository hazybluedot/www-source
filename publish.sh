#!/bin/bash

target=${1:-public}

git pull
cd user-data
git pull
cd -
nanoc refresh_feeds <( cut -f 2 -d ' ' user-data/feeds )
nanoc co
nanoc deploy --target $target
