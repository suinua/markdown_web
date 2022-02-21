#!/bin/sh -l
cd ../../../../
dart pub get
mkdir "output"
cp -r /assets/* output
dart2js -O2 -o output/main.js web/main.dart
dart bin/markdown_web.dart
echo home/runner/work/$GITHUB_REPOSITORY/$GITHUB_REPOSITORY
cp -r output home/runner/work/$GITHUB_REPOSITORY/$GITHUB_REPOSITORY/output
cd home/runner/work/$GITHUB_REPOSITORY/$GITHUB_REPOSITORY
pwd
ls