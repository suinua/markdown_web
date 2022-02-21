#!/bin/sh -l
cd ../../../../
dart pub get
mkdir "output"
cp -r /assets/* output
dart2js -O2 -o output/main.js web/main.dart
dart bin/markdown_web.dart
#cp -r output home/runner/work/$INPUT_REPOSITORYNAME/$INPUT_REPOSITORYNAME/output
ls home