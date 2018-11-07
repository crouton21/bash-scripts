#!/bin/bash

# must run in parent folder of repo

repo=wyndham-test-utils # put repo name here

echo "Moving to Bitbucket..."
echo $repo

git clone ssh://git@new-stash.olson.com:7999/twa/$repo.git
cd $repo
echo "in repo..."
echo $repo

git branch -r | while read line ; do
    br=$(echo $line | cut -c8-)
    echo "Checking out branch..."
    echo $br
    git checkout $br
done

echo "Setting remote url"
ssh=ssh://git@bitbucket.icfolson.com:7999/twa/$repo.git
echo $ssh
git remote set-url origin $ssh
git remote -v
git push --all
git push --tags

git branch | while read line ; do
    if [[ $line = *"*"* ]]; then
        for file in $line
            do
            br=$file
            done
    else
        br=$line
    fi
    echo "Checking out branch..."
    echo $br
    git checkout $br
    sed -i "" "s/new-stash.olson.com:7999/bitbucket.icfolson.com:7999/" package.json
    git add .
    git commit -m "change SSH key"
    git push
done

echo "complete"
