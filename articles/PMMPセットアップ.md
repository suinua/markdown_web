開発
# PMMPセットアップ

## 作業フォルダ
`pmmp4/`フォルダを作成  
## Pocketmineのダウンロード
[Github](https://github.com/pmmp/PocketMine-MP/releases/tag/4.2.1)から**Pocketmine.phar**と**start.cmd**をダウンロード
![download](https://raw.githubusercontent.com/suinua/pmmp-_sample_code/master/articles/download_from_github.png)

`pmmp4/`フォルダにコピーします
![folder_1](https://raw.githubusercontent.com/suinua/pmmp-_sample_code/master/articles/folder_1.png)

## Binのダウンロード
[Jenkins](https://jenkins.pmmp.io/job/PHP-8.0-Aggregate/)から**PHP-8.0-Windows-x64.zip**をダウンロード 
![download](https://raw.githubusercontent.com/suinua/pmmp-_sample_code/master/articles/jenkins.png)

展開して**bin**を`pmmp4/`にコピー
![download_bin](https://raw.githubusercontent.com/suinua/pmmp-_sample_code/master/articles/folder_2)

## Pocketmine起動
コマンドプロンプトを起動して`start.cmd`を実行
```bat
cd D:\pmmp4\ 作成した場所に移動
start.cmd
```
[?] Language (eng): **jpn**
[?] ライセンスに同意しますか？ (y/N): **y**
[?] セットアップウィザードをスキップしますか？ (y/N): **N**
[?] サーバーの名前を付けてください (PocketMine-MP Server): ` `
[?] Server port (IPv4) (19132): ` `
[?] Server port (IPv6) (19133): ` `
[?] デフォルトのゲームモード (0):` `
[?] 最大オンラインプレイヤー数 (20):` `
[?] Maximum view distance (chunks) (16):` `
[?] OP プレイヤー名 (例: あなたのゲームの名前): **suinua**
[?] ホワイトリストを有効にしますか？ (y/N): **N**
[?] Query を無効にしますか？ (y/N):**y**
`stop`で停止できます

ログを載せて置きます
```
C:\Users\Maati>cd D:\pmmp4
D:\pmmp4>start.cmd
[*] PocketMine-MP set-up wizard
[*] Please select a language
 中文 (简体) => chs
 Deutsch => deu
 Ελληνικά => ell
 English => eng
 Français => fra
 Hrvatski => hrv
 日本語 => jpn
 한국어 => kor
 Latviešu => lav
 Nederlands => nld
 Pyccĸий => rus
[?] Language (eng): jpn
[*] 日本語が正しく選択されました。
[*] PocketMine-MP へようこそ!
新しいサーバーのセットアップを開始する前に、ライセンスに同意する必要があります。
PocketMine-MP は LGPL ライセンスのもとで許諾されており、
このフォルダーで LICENSE ファイルを読むことができます。

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

[?] ライセンスに同意しますか？ (y/N): y
[?] セットアップウィザードをスキップしますか？ (y/N): N

[*] サーバーのセットアップを開始します。
[*] デフォルト値を変更しない場合は、Enter キーを押してください。
[*] これらの設定は後で server.properties ファイルで編集できます。
[?] サーバーの名前を付けてください (PocketMine-MP Server): server name
[*] これが初めてのサーバーの場合は、デフォルトのポート値を変更しないでください。
[?] Server port (IPv4) (19132):
[?] Server port (IPv6) (19133):
[*] クリエイティブ (1) またはサバイバル (0) のいずれかを選択してください
[?] デフォルトのゲームモード (0):
[?] 最大オンラインプレイヤー数 (20):
[?] Maximum view distance (chunks) (16):
[*] OP はサーバーのプレイヤー管理者です。OP は通常のプレイヤーよりも多くのコマンドを実行できます
[?] OP プレイヤー名 (例: あなたのゲームの名前): suinua
[*] ホワイトリストではリストに含まれているプレイヤーのみ参加できます。
[?] ホワイトリストを有効にしますか？ (y/N): n
[!] Query はサーバーとログインしているプレイヤーの情報を取得するためにさまざまなツールで使用されるプロトコルです。
[!] それを無効にした場合、サーバーの一覧を使用できなくなります。
[?] Query を無効にしますか？ (y/N):
[*] 外部 IP と内部 IP を取得しています
[!] あなたの外部 IP は ------- です。あなたの内部 IP 192.168.0.15 にポートフォワードが必要な可能性があります
[!] 必ず確認してください。フォワードが必要な場合にスキップすると、外部からプレイヤーが参加できなくなります。[Enter キーを押してください]

[*] セットアップウィザードは正しく終了しました
[*] サーバーに新機能、ミニゲーム、または高度な保護を追加するには、プラグインリポジトリを確認してみてください
[*] PocketMine-MP を開始します。使用可能なコマンドの一覧を /help で表示してください。


[16:22:48.359] [Server thread/INFO]: Loading server configuration
[16:22:48.431] [Server thread/INFO]: 日本語 (jpn) を基本言語として選択しました
[16:22:48.450] [Server thread/INFO]: Minecraft: Bedrock Edition サーバーバージョン v1.18.10 を開始しています
[16:22:48.460] [Server thread/INFO]: Online mode is enabled. The server will verify that players are authenticated to Xbox Live.
[16:22:48.854] [Server thread/INFO]: このサーバーは PocketMine-MP バージョン 4.2.1 を実行しています
[16:22:48.860] [Server thread/INFO]: PocketMine-MP は LGPL ライセンスのもとで配布されています
[16:22:50.180] [Server thread/INFO]: Loading resource packs...
[16:22:50.594] [Server thread/INFO]: ワールド "world" を準備しています
[16:22:50.738] [Server thread/NOTICE]: ワールド "world" のスポーン地形がバックグラウンドで生成されています
[16:22:51.114] [Server thread/INFO]: Minecraft ネットワークインターフェースは 0.0.0.0:19132 で動作しています
[16:22:51.116] [Server thread/INFO]: GS4 Query リスナーは 0.0.0.0:19132 で動作しています
[16:22:51.654] [Server thread/INFO]: Minecraft ネットワークインターフェースは [::]:19133 で動作していま す
[16:22:51.654] [Server thread/INFO]: GS4 Query リスナーは [::]:19133 で動作しています
[16:22:51.659] [Server thread/INFO]: デフォルトのゲームタイプ：サバイバルモード
[16:22:51.660] [Server thread/INFO]: If you find this project useful, please consider donating to support development: https://patreon.com/pocketminemp
[16:22:51.723] [Server thread/INFO]: 完了 (3.367 秒)! ヘルプを表示するには、"help" または "?" と入力してください
```
実行後は`pmmp4/`フォルダがこのようになっているはずです
![folder2](https://raw.githubusercontent.com/suinua/pmmp-_sample_code/master/articles/folder_3.png)

## サーバー機から参加できるようにする
管理者権限で以下のコマンドを実行
`CheckNetIsolation LoopbackExempt -a -n="Microsoft.MinecraftUWP_8wekyb3d8bbwe"`

## サーバーに参加
以下のようにサーバーを追加します

サーバー名 : **自由**
サーバーアドレス : **localhost**または**127.0.0.1**
ポート : **19132**

![server_list](https://raw.githubusercontent.com/suinua/pmmp-_sample_code/master/articles/server_list.png)
ポート開放をしていないので、同じLANネットワークからのみ参加できます

ポート開放をすることで、**外部IPアドレス**を使用してサーバーに参加することができますが、使っているルーターによるので今回は詳しくは書きません