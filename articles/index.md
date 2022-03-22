index
# Markdown Web
マークダウンファイル群をHTMLに変換してgithub pagesにデプロイします  
このサイト自体もMarkdown Webで動いてます  

# 導入方法
/.github/workflows/markdown_web.yml
```yaml
name: execute_markdown_web

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
          articles_directory_path: 'articles'//マークダウン群のフォルダ
          github_token: ${{ secrets.GITHUB_TOKEN }}
```

# 独自の構文、要素
## URLの埋め込み
```markdown
embed:url
embed:https://qiita.com/Qiita
embed:https://f1-motorsports-gp.com/
```
embed:https://qiita.com/Qiita  
embed:https://f1-motorsports-gp.com/
## 素のURL
素のURLは`[URL](URL)`と同じです
```markdown
https://f1-motorsports-gp.com/
```
https://f1-motorsports-gp.com/
## 目次
`#`と`##`を目次に変換してます

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

:::
内側に一部マークダウンを記入可能  
ヘッダー系や、embedは無理
**強調**  
~~打ち消し~~
https://f1-motorsports-gp.com/bar/2022-f1-1-brn-race/
:::