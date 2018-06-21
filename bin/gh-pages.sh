#!/usr/bin/env bash

set -ex

if [[ "false" != "$TRAVIS_PULL_REQUEST" ]]; then
  echo "Not deploying pull requests."
  exit
fi

if [[ "master" != "$TRAVIS_BRANCH" ]]; then
  echo "Not on the 'master' branch."
  exit
fi

git clone -b gh-pages --quiet https://github.com/sass-basis/integrity.git gh-pages
cd gh-pages
ls | xargs rm -rf
rm -f .gitignore .travis.yml .editorconfig
cp ../public/**.html .
cp -R ../public/assets .
ls -la

git add -A
git commit -m "[ci skip] gh-pages branch update from travis $TRAVIS_COMMIT"
git push --quiet "https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git" gh-pages >/dev/null 2>&1
