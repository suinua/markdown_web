#!/bin/bash
cd ../../../../
dart pub get
mkdir "output"
cp -r /assets/* output
dart2js -O2 -o output/main.js web/main.dart
dart bin/markdown_web.dart
REPO_NAME=`echo ${GITHUB_REPOSITORY//*\//}`
echo ${REPO_NAME}