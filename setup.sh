#!/bin/sh -l
cd ../../../../
dart pub get
mkdir "output"
cp -r /assets/* output
dart2js -O2 -o output/main.js web/main.dart
dart bin/markdown_web.dart
path="suinua/sample_code"
path=`echo ${GITHUB_REPOSITORY//*\//}`
echo path
cp -r output $path/output
cd home/runner/work/$GITHUB_REPOSITORY/$GITHUB_REPOSITORY
pwd
ls