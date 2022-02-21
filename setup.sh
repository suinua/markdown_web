#!/bin/sh -l
cd ../../../../
dart pub get
mkdir "output"
cp -r /assets/* output
dart2js -O2 -o output/main.js web/main.dart
dart bin/markdown_web.dart
cp -r output /home/runner/work/$GITHUB_REPOSITORY/$GITHUB_REPOSITORY
cd /home/runner/work/$GITHUB_REPOSITORY/$GITHUB_REPOSITORY
pwd
ls