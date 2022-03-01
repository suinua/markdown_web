開発

# devtool
本来、プラグインは`.phar`形式で使いますが開発の都合上それだと不便が生じるので、フォルダ形式で読み込めるように**devtool**を導入します

[Github](https://github.com/pmmp/DevTools/releases)からDevtool.pharをダウンロードします

`plugins/`フォルダーにコピーします
![devtool_folder](https://raw.githubusercontent.com/suinua/pmmp-_sample_code/master/articles/devtool_folder.png)

# プラグイン作成
`plugins/JoinMessage/`フォルダを作成し****ます
`plugin.yml`を作成して以下のように記述します
```yml
name: JoinMessage
main: src\JoinMessage
version: 1.0.0
api: 4.0.0
author: your name
```
`plugins/JoinMessage/src`フォルダを作成します
`plugins/JoinMessage/src/JoinMessage.php`ファイルを作成します

現在のフォルダ構成は以下の通りです
```
plugins
  └── JoinMessage
            ├── plugin.yml
            └── src
                └── JoinMessage.php
```

`JoinMessage.php`を編集します
```php
```

サーバーを起動して参加した際にメッセージが送られるはずです

# 補完
PocketMineのソースコードを読み込むことで補完を実現させます
方法は３通りほどあります。簡単な物から順番に紹介していきます。

## PocketMineのソースコードをダウンロードして読み込む
一番簡単ですが、手動でPocketMineの更新に対応しなきゃいけないのが少し面倒です

## Composerを使用する
ほとんどの人がこの方法で補完させてると思います


## PocketMineをソースコードから実行し、そのソースコードを読み込ませる
[記事](https://qiita.com/suinua/items/afd984eebeb96a75ca49)のようにソースコードからPocketMineを実行するようにして、`PocketMine/src`を読み込ませます  
最初は少し手間がかかりますが、pullすればすぐ更新できますし"補完に使っているバージョンと実行しているPocketMineのバージョンがずれる"なんてことを防げます
