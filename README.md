# 導入

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

# 独自のMarkdown
## ツイートの埋め込み
```markdown
tweet:https://twitter.com/suinua/status/1497224778788139008?s=20&t=bkcX37X_4DJZ_DFXiZI6OQ
```
