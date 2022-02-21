#!/bin/sh -l
cd ../../../../
dart pub get
mkdir "output"
cp -r /assets/* output
dart2js -O2 -o output/main.js web/main.dart
dart bin/markdown_web.dart
path=$GITHUB_REPOSITORY
path=${path//*\//}
echo $path
pwd
ls