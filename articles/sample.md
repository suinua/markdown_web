# Header1
## Header2
### Header3
#### Header4
##### Header5
##### Header6

# コードブロック
```dart
class Article {
  final String uuid;
  final String title;
  final String body;
  final List<String> tags;

  const Article({
    required this.uuid,
    required this.title,
    required this.body,
    required this.tags,
  });

  @override
  bool operator ==(Object other) {
    if (other is Article) {
      return other.uuid == uuid;
    }

    return false;
  }
}
```

# コードスパン
`Code spans`

# テキストの装飾
## 強調
`**強調**`  
**強調**

# イタリック体
`*イタリック体*`  
*イタリック体*

# 打ち消し線
`~~打ち消し~~`  
~~打ち消し~~

# チェックボックス
- [ ] タスク1
- [x] タスク2

# 引用
```markdown
https://ja.wikipedia.org/wiki/%E5%8F%99%E3%80%85%E8%8B%91
> 「食後の無料デザート」「帰る際に渡すにおい消しのガム」は叙々苑が発祥とされる
```
https://ja.wikipedia.org/wiki/%E5%8F%99%E3%80%85%E8%8B%91
> 「食後の無料デザート」「帰る際に渡すにおい消しのガム」は叙々苑が発祥とされる

# 水平線
```markdown
* * *
***
*****
- - -
---------------------------------------
```
* * *
***
*****
- - -
---------------------------------------

# 画像
```markdown
![Qiita](https://qiita-image-store.s3.amazonaws.com/0/45617/015bd058-7ea0-e6a5-b9cb-36a4fb38e59c.png "Qiita")
```
![Qiita](https://qiita-image-store.s3.amazonaws.com/0/45617/015bd058-7ea0-e6a5-b9cb-36a4fb38e59c.png "Qiita")

# テーブル
```markdown
| Left align | Right align | Center align |
|:-----------|------------:|:------------:|
| This       | This        | This         |
| column     | column      | column       |
| will       | will        | will         |
| be         | be          | be           |
| left       | right       | center       |
| aligned    | aligned     | aligned      |
```

| Left align | Right align | Center align |
|:-----------|------------:|:------------:|
| This       | This        | This         |
| column     | column      | column       |
| will       | will        | will         |
| be         | be          | be           |
| left       | right       | center       |
| aligned    | aligned     | aligned      |