#!/bin/sh -l
cd ../../../../
dart pub get
mkdir "output"
cp -r /assets/* output
dart2js -O2 -o output/main.js web/main.dart
dart bin/markdown_web.dart
echo $GITHUB_ACTION_PATH
echo $GITHUB_ACTION_REPOSITORY
echo $GITHUB_ENV
echo $GITHUB_PATH
#cp -r output home/runner/work/$REPO_NAME/$REPO_NAME/output
#cd home/runner/work/$REPO_NAME/$REPO_NAME
#pwd
#ls