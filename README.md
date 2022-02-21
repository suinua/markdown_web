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
      - uses: suinua/markdown_web@master
        with:
          articles_directory_path: 'articles'
          github_token: ${{ secrets.GITHUB_TOKEN }}
```