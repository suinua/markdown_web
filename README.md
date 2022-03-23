![サンプル](https://suinua.github.io/markdown_web/)


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
## 埋め込み
```markdown
embed:https://github.com/suinua/markdown_web
embed:https://twitter.com/suinua/status/1497224778788139008?s=20&t=bkcX37X_4DJZ_DFXiZI6OQ
```
## ノート
```markdown
:::info
インフォ
:::

:::warn
警告
:::

:::alert
より強い警告
:::

:::value
無地
:::

:::
infoは省略可能
:::
```


#
xcopy assets export /E/H/C/I  
dart --enable-asserts bin/markdown_web.dart  
dart2js -O2 -o export/main.js web/main.dart  
