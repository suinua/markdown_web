```yaml
name: generate_github_pages

on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2
      - uses: suinua/vis@master
        with:
          articlesDirectoryPath: 'articles'
```