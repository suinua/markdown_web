#!/bin/sh -l
cd ../../../../
dart pub get
mkdir "output"
cp -r /assets/* output
dart2js -O2 -o output/main.js web/main.dart
dart bin/markdown_web.dart
echo home/runner/work/$REPO_NAME/$REPO_NAME
cp -r output home/runner/work/$REPO_NAME/$REPO_NAME/output
cd home/runner/work/$REPO_NAME/$REPO_NAME
pwd
ls