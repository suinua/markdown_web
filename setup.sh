#!/bin/sh -l
cd ../../../../
dart pub get
mkdir "output"
cp -r /assets/* output
dart2js -O2 -o output/main.js web/main.dart
dart bin/markdown_web.dart
REPO_NAME=${GITHUB_REPOSITORY}
REPO_NAME=`echo ${REPO_NAME//a/e}`
echo ${REPO_NAME}
