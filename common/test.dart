import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:markdown/markdown.dart';

import 'view/custom_markdown_to_html.dart';

Future<void> main() async {
  var text = '''
# 新たな発見。弱光層に住む虹色の魚。
Newly discovered rainbow-colored fish lives in the ocean's 'twilight zone'
![fish](https://cdn.cnn.com/cnnnext/dam/assets/220309153016-02-rose-veiled-fairy-wrasse-discovery-exla
rge-169.jpg)

**大人のオスのバラベールフェアリーベラの展示、見事なカラフルな色を持っている**
The male rose-veiled fairy wrasse showcases a stunning variety of colors as an adult.

**モルデブを取り巻く波の深く、弱光層に虹色の魚はいる。カラフルな新種の魚、バラベールフェアリーベラに挨
拶をしましょう。**
Far beneath the waves surrounding the Maldives, there's a living rainbow in the ocean's "twilight zone
." Say hello to the rose-veiled fairy wrasse, a colorful species of fish that's new to science.
![モルディブ](https://user-images.githubusercontent.com/34801662/157783870-6d20cbd8-dcfb-42ba-8af7-1ca
17c64c2f8.png)


**この魚は”Cirrhilabrus finifenmaa”という学名を持ち、海面から40メートルから70メートルのところで生息
が確認された。**
The fish, which bears the scientific name Cirrhilabrus finifenmaa, was found living at depths ranging
from 131 to 229 feet (40 to 70 meters) beneath the ocean's surface.

**その魚はピンクのバラのような見事な色合いにちなんで名付けられた。ピンクのバラはモルディブの国花でであ
る。モデルディブで話されているディベヒ語で"Finifenmaa"というのはバラを意味する**
The name honors the fish's stunning pink hues, as well as the pink rose, the national flower of the Ma
ldives. "Finifenmaa" means "rose" in the local Dhivehi language.

![ocean](https://cdn.cnn.com/cnnnext/dam/assets/220309153117-03-rose-veiled-fairy-wrasse-discovery-exl
arge-169.jpg)
**数百の種類の魚の住処であるモルディブの海**
The waters of the Maldives are home to a hundreds of species of fish.


**数百の種類の生物がその諸島国家を囲う海にすんでいるが、この魚はモルディブ出身の科学者によって説明され
る最初の魚である。その科学者は"Ahmed Najeeb"。この魚に関しての研究は火曜日に"the journal ZooKeys"に登
載された。**
While hundreds of species thrive in the waters near and surrounding the archipelago nation, this is th
e first fish to be described by a Maldivian scientist -- Ahmed Najeeb. A study describing the fish pub
lished Tuesday in the journal ZooKeys.

**"いつだってモルディブで見つかった生物を発表するのは外国人だったんだ。それも現地の研究者と関与せずに
ね。たとえそれがモルディブ固有のものでも。"と共著者であり、モルディブ海洋調査機関の生物学者であるNajee
bは声明の中でそう述べた。**
"It has always been foreign scientists who have described species found in the Maldives without much i
nvolvement from local scientists, even those that are endemic to the Maldives," said study coauthor Na
jeeb, a biologist at the Maldives Marine Research Institute, in a statement.

**今回はいつもと違い、初めて何かの一部になれることは本当にエキサイティングでした。特にエキサイティング
だったのはトップクラスの魚類学者と共にこの高貴で美しい魚に関した作業をする機会を持てたことです。**
"This time it is different and getting to be part of something for the first time has been really exci
ting, especially having the opportunity to work alongside top ichthyologists on such an elegant and be
autiful species."

# そのほかの呼び名
A fish by any other name

**この魚は間違えて認識された歴史を持つ。研究者が最初に見つけたのは1990年代だが、彼らは成魚のCirrhilabr
us rubrisquamisかレッドベールフェアリーベラに属すると考えた。"その誤認された魚"は、モルディブから1000k
m南のチャゴス諸島で発見された１匹の稚魚からのみ説明されていた**
The fish has a history of mistaken identity. Researchers first found it in the 1990s, but they thought
 it was an adult belonging to Cirrhilabrus rubrisquamis, or the red velvet fairy wrasse. This differen
t species had only been described from a single juvenile fish found 621 miles (1,000 kilometers) south
 of the Maldives in the Chagos Archipelago.
![チャゴス諸島](https://user-images.githubusercontent.com/34801662/157789570-798db59a-e914-4338-8ab3-2
0ce10cd016e.png)

**"主に明るくカラフルな魚の種であるベラは成長する過程で色が変わるとして知られている。"と筆頭著者であり
、カリフォルニア科学アカデミーの魚類学学芸員のLuiz Rochaはメールの中で述べた。**
Wrasses, a family of largely bright colored fishes, have been known to change in color as they transit
ion from juveniles to adults, said senior study author Luiz Rocha, the California Academy of Sciences
curator of ichthyology, in an email.

**"稚魚のうちはほとんどの種類のベラは同じような見た目だが、際立った特徴をもつのは大人のベラである"と彼
は述べた**
While the juveniles of many species look alike, it's the adults who carry distinguishing characteristi
cs, he said.
![ベラ](https://cdn.cnn.com/cnnnext/dam/assets/220309152934-01-rose-veiled-fairy-wrasse-discovery-exla
rge-169.jpg)
**学名Cirrhilabrus finifenmaaはモルディブの国花であるピンクのバラにちなんで名付けられた。**
The scientific name Cirrhilabrus finifenmaa is a nod to the pink rose, the Maldivian national flower.

**"数か月前、筆頭著者であるYi-Kai Teaはチャゴスの遠隔操作探査機から成魚の映像を受け取ったが、その魚は
モルディブの成魚とはとても異なっていた"とRochaは述べた。この時、我々はこのモルディブに生息する魚がチャ
ゴスのと異なる種類であると確信した。**
"A few months ago, Yi-Kai Tea (our first author) received (remotely operated vehicle) footage from Cha
gos showing adults, which were very different from the adults from the Maldives," Rocha said. "That's
when we decided that the species from the Maldives was new and different from C. rubrisquamis."

**研究の中で、研究者たちは成魚と稚魚の詳細に焦点を当てた。オスの成魚の背びれを支える棘の長さを測り、サ
イズを計測し、色を分類した。**
In their study, the researchers focused on the details of adults and juveniles, analyzing the height o
f the spines supporting their dorsal fins, counting scales and cataloging the colors of the adult male
s.

**ローズベールフェアリーベラのオスの成魚は、明るい赤紫色や桃色、桃橙色、黒紫などの色を含むユニークなカ
ラーパターンをもっている。**
The rose-veiled fairy wrasse adult males have a unique color pattern including bright magenta, peach,
orange-pink and dark purplish-red.

**finifenmaaとrubrisquamisは別種であるという発見は科学者がこれらの魚の範囲を理解するのを助ける。また、
この発見はこれらの魚を保護するときにとても重要になる。**
Discovering that finifenmaa and rubrisquamis were two separate species can help scientists understand
the range of these fish, which becomes especially important when trying to protect them.
![](https://cdn.cnn.com/cnnnext/dam/assets/220309153316-05-rose-veiled-fairy-wrasse-discovery-exlarge-
169.jpg)
**左からAhmed NajeebとLuiz Rocha。モルディブでの調査中、彼らが集めた複数の魚を調べている**
(From left) Ahmed Najeeb and Luiz Rocha inspect some fish they collected during a recent expedition in
 the Maldives.

**"以前私たちは１種類の魚が広く生息していると考えていましたが、実際は異なる２種類の魚で、それらは潜在
的にはるかに限られた分布に生息していました"と筆頭著者であり、シドニー大学博士課程の学生のYi-Kai Teaは
述べた。"これはなぜ新種の生物を説明したり、一般的な分類学が保護や生物多様性管理にとって重要なのかの例
である"**
"What we previously thought was one widespread species of fish, is actually two different species, eac
h with a potentially much more restricted distribution," said lead author Yi-Kai Tea, a University of
Sydney doctoral student, in a statement. "This exemplifies why describing new species, and taxonomy in
 general, is important for conservation and biodiversity management."

**ローズベールフェアリーベラの名前は新しいかもしれないが、既に娯楽のターゲットになっている**
The name may be new, but the rose-veiled fairy wrasse is already a target of the aquarium hobby trade.

**”その種類はとても豊富で現在は乱獲の恐れはないが、その魚が学名を持つ前に商業利用されている場合、不安
が残ります”とRochaは述べた。また、カリフォルニア科学アカデミーの"Hope for Reefs"の共同ディレクターは
こう述べた。"どのくらい生物多様性が残っているかを物語るのは、サンゴ礁の生態系である"**
"Though the species is quite abundant and therefore not currently at a high risk of overexploitation,
it's still unsettling when a fish is already being commercialized before it even has a scientific name
," said Rocha, also a codirector of the California Academy of Sciences Hope for Reefs initiative. "It
speaks to how much biodiversity there is still left to be described from coral reef ecosystems."

# 弱光層のサンゴ礁探索
Exploring 'twilight zone' reefs

**"The Hope for Reefs"の初期の目標はサンゴ礁を調査し、保護することである。先月"The Hope for Reefs"とモ
ルディブ海洋調査機関の調査者がモルディブの弱光層のサンゴ礁調査におけるいくつかのを実施した**
The Hope for Reefs initiative aims to research and restore coral reef systems. Last month, researchers
 from Hope for Reefs and the Maldives Marine Research Institute surveyed some of the Maldives' twiligh
t zone reefs.

**海面から50mから150mのところにサンゴ礁は存在し、ユニークな環境をフェアリーベラのような魚に提供してい
る**
These reefs can be 160 to 500 feet (50 to 150 meters) beneath the ocean's surface and provide a unique
 environment for fish like fairy wrasses.

![Wakanda](https://cdn.cnn.com/cnnnext/dam/assets/190710170737-03-wakanda-new-fish-species-medium-plus
-169.jpg)
`Wakanda`と呼ばれる魚:新しい紫色の魚でBlack Pantherにちなんで名付けられた
A fish called Wakanda: New purple fish honors 'Black Panther'

**"水が光を吸収するので深くに行けば行くほど暗く、水温が低くなる。という環境は本当に普通じゃない。"とRo
chaは述べた。"光がほとんど入らないんで、そこにはほとんどサンゴ礁や藻類はなく結果として、魚の生態系もと
ても異なっていた。そこに住むほとんどの魚はプランクトン(その水深に住む小さな海洋無脊椎動物)を主食にして
いた。"**
"It's a really different environment: It's darker (because the water functions as a filter absorbing l
ight, so the deeper you go, the darker it gets) and colder," Rocha said. "There are much fewer corals,
 and almost no algae (because of the lack of light), so the fish community is very different and most
fish at this depth feed on plankton (tiny marine invertebrates that live in the water column)."

**Rolexによって資金提供された、近年のダイブはいかに広範囲の未調査弱光層のおける調査が難しいか示した。
弱光層は娯楽でダイブできる制限深度より下に位置している。この深度では呼吸によって出る酸素のネガティブな
影響を割けるために、ダイバーは必ず閉鎖式でヘリウムの混ざったガスボンベを使用しなければならない(吐いた
空気が水中に出ない)。大量の装置を必要とするのに加えて、多くのトレーニングを要求するんだとRochaは述べた
。**
The recent dives, funded by an award from Rolex, show just how difficult it is to survey the largely u
nexplored twilight zone reefs -- located below recreational diving limits. The divers must use rebreat
hers and helium mixed into the gas they breathe to avoid the negative effects of breathing oxygen unde
r so much pressure, in addition to using an abundance of gear that requires a lot of training, Rocha s
aid.

**けど、研究によって、その苦労は見合うものだ。"そこにダイビングすることはまるで他の惑星に行くようなこ
とである"とRochaは述べた。"私たちは常にそのサンゴ礁を見る最初の人であり、常に新種の生物を見つける。と
ても大変だがエキサイティングだ！"**
But it's well worth it, according to the researchers.
"Diving there is like visiting another planet," Rocha said. "We are always the first ones to see those
 reefs, and always find new species. It is very challenging, but also very exciting!"

![divers](https://cdn.cnn.com/cnnnext/dam/assets/220309153219-04-rose-veiled-fairy-wrasse-discovery-ex
large-169.jpg)
**最近の遠征にて、モルディブの弱光層のサンゴ礁への探索を準備するダイバーたち**
Divers prepare to explore the twilight zone reefs of the Maldives during a recent expedition.

**最近の調査において、調査チームは多くのローズベールフェアリーベラと少なくとも新種の可能性のある８種類
の魚を見つけた**
During the recent surveys, the research team found more of the rose-veiled fairy wrasse as well as at
least eight potential new species of fish.
**カリフォルニア科学アカデミーとモルディブ海洋調査機関はモルディブのサンゴ礁をこれからも調査していくた
めに、協力を続けている**
The California Academy of Sciences and the Maldives Marine Research Institute are continuing their par
tnership to explore more Maldivian reefs in the future.

**"私たちの協力関係は、未調査の深度の海洋生態系や、そこに住む生物を理解するのをより助けるだろう"とNaje
ebは述べた。"より理解し、より説得力のある化学的証拠を集めれば、生物をよりよく保護できるだろう"**
"Our partnership will help us better understand the unexplored depths of our marine ecosystems and the
ir inhabitants," Najeeb said. "The more we understand and the more compelling scientific evidence we c
an gather, the better we can protect them."

**"最近見つけた８つの新種の標本をもう少し集められることを望んでいる"とRochaは述べた。"加えて、生物の名
前にモルディブの言葉を使うことを続けるために、私たちは親密にモルディブのパートナーと協力している"**
"We hope to collect a few more specimens of the other eight new species we recently found," Rocha said
. "Additionally, we are closely working with our Maldivian partners to keep using Maldivian names in o
ur species."


****

## 単語や熟語
wrasse:ベラ
stunning:驚くべき、見事な、素晴らしい
bear:堅い意味で、[名称や名前]を持つ
honors:動詞として、～をほめ称える、～栄光を授ける。今回は`ちなんで`と訳したがニュアンスはすこし違うき
がする
twilight zone:弱光層、薄暮地帯、光の届かない場所。つまり深海？
archipelago:諸島
endemic:風土病、固有の
ichthyologists:魚類学者
curator:学芸員
Senior Author、First Author、Primary Author、Lead Author:筆頭著者
nod to:～を考慮して
footage:長さ、映像の一部？
unsettling:不安
It speaks to:～を物語る
left to do:～に任せる
the water column:表面から底質への水の概念的な柱のこと
the 比較級, the 比較級:～するほどに～する


## 翻訳元


<div class="url-embed-wrap">
  <a href="https://edition.cnn.com/2022/03/10/world/rose-fairy-wrasse-rainbow-fish-scn/index.html" cla
ss="url-embed">
    <div class="url-embed-context">
      <div class="url-embed-site-title">New rainbow-colored fish lives in the ocean's 'twilight zone'
- CNN</div>
        <div class="url-embed-site-host">edition.cnn.com</div>
    </div>
    <div class="url-embed-thumnail">
      <img src="https://s.wordpress.com/mshots/v1/https://edition.cnn.com/2022/03/10/world/rose-fairy-
wrasse-rainbow-fish-scn/index.html?w=250" alt="">
    </div>
  </a>
</div>


## 参考

国花のバラ

<div class="url-embed-wrap">
  <a href="https://www.facebook.com/MDVinJP/photos/%E3%83%A2%E3%83%AB%E3%83%87%E3%82%A3%E3%83%96%E3%81
%AE%E5%9B%BD%E8%8A%B1%E3%83%A2%E3%83%AB%E3%83%87%E3%82%A3%E3%83%B4%E5%85%B1%E5%92%8C%E5%9B%BD%E3%81%AE
%E5%9B%BD%E3%81%AE%E8%8A%B1%E3%81%AFfinifenmaa%E3%83%95%E3%82%A3%E3%83%8B%E3%83%95%E3%82%A7%E3%83%B3%E
3%83%9E%E3%83%BC%E4%B8%80%E8%88%AC%E3%81%AB%E5%90%8D%E3%81%AE%E7%9F%A5%E3%82%89%E3%82%8C%E3%81%9F%E3%8
3%94%E3%83%B3%E3%82%AF%E8%89%B2%E3%81%AE%E8%96%94%E8%96%87%E3%81%A7%E6%A4%8D%E7%89%A9%E5%AD%A6%E7%9A%8
4%E3%81%AB%E3%81%AF%E3%83%90%E3%83%A9%E3%81%AE%E4%BA%A4%E9%85%8D%E7%A8%AE%E3%81%A8%E7%89%B9%E5%AE%9A%E
3%81%95%E3%82%8C%E3%81%A6%E3%81%84%E3%81%BE%E3%81%99fin/440694689287787/" class="url-embed">
    <div class="url-embed-context">
      <div class="url-embed-site-title">Facebook</div>
        <div class="url-embed-site-host">www.facebook.com</div>
    </div>
    <div class="url-embed-thumnail">
      <img src="https://s.wordpress.com/mshots/v1/https://www.facebook.com/MDVinJP/photos/%E3%83%A2%E3
%83%AB%E3%83%87%E3%82%A3%E3%83%96%E3%81%AE%E5%9B%BD%E8%8A%B1%E3%83%A2%E3%83%AB%E3%83%87%E3%82%A3%E3%83
%B4%E5%85%B1%E5%92%8C%E5%9B%BD%E3%81%AE%E5%9B%BD%E3%81%AE%E8%8A%B1%E3%81%AFfinifenmaa%E3%83%95%E3%82%A
3%E3%83%8B%E3%83%95%E3%82%A7%E3%83%B3%E3%83%9E%E3%83%BC%E4%B8%80%E8%88%AC%E3%81%AB%E5%90%8D%E3%81%AE%E
7%9F%A5%E3%82%89%E3%82%8C%E3%81%9F%E3%83%94%E3%83%B3%E3%82%AF%E8%89%B2%E3%81%AE%E8%96%94%E8%96%87%E3%8
1%A7%E6%A4%8D%E7%89%A9%E5%AD%A6%E7%9A%84%E3%81%AB%E3%81%AF%E3%83%90%E3%83%A9%E3%81%AE%E4%BA%A4%E9%85%8
D%E7%A8%AE%E3%81%A8%E7%89%B9%E5%AE%9A%E3%81%95%E3%82%8C%E3%81%A6%E3%81%84%E3%81%BE%E3%81%99fin/4406946
89287787/?w=250" alt="">
    </div>
  </a>
</div>


リブリーザー

<div class="url-embed-wrap">
  <a href="https://www.padi.co.jp/scuba-diving/columns/rebreather/" class="url-embed">
    <div class="url-embed-context">
      <div class="url-embed-site-title">リブリーザーとは？リブリーザーで広がる新しい世界</div>
        <div class="url-embed-site-host">www.padi.co.jp</div>
    </div>
    <div class="url-embed-thumnail">
      <img src="https://s.wordpress.com/mshots/v1/https://www.padi.co.jp/scuba-diving/columns/rebreath
er/?w=250" alt="">
    </div>
  </a>
</div>


# 新たな発見。弱光層に住む虹色の魚。
Newly discovered rainbow-colored fish lives in the ocean's 'twilight zone'
![fish](https://cdn.cnn.com/cnnnext/dam/assets/220309153016-02-rose-veiled-fairy-wrasse-discovery-exla
rge-169.jpg)

**大人のオスのバラベールフェアリーベラの展示、見事なカラフルな色を持っている**
The male rose-veiled fairy wrasse showcases a stunning variety of colors as an adult.

**モルデブを取り巻く波の深く、弱光層に虹色の魚はいる。カラフルな新種の魚、バラベールフェアリーベラに挨
拶をしましょう。**
Far beneath the waves surrounding the Maldives, there's a living rainbow in the ocean's "twilight zone
." Say hello to the rose-veiled fairy wrasse, a colorful species of fish that's new to science.
![モルディブ](https://user-images.githubusercontent.com/34801662/157783870-6d20cbd8-dcfb-42ba-8af7-1ca
17c64c2f8.png)


**この魚は”Cirrhilabrus finifenmaa”という学名を持ち、海面から40メートルから70メートルのところで生息
が確認された。**
The fish, which bears the scientific name Cirrhilabrus finifenmaa, was found living at depths ranging
from 131 to 229 feet (40 to 70 meters) beneath the ocean's surface.

**その魚はピンクのバラのような見事な色合いにちなんで名付けられた。ピンクのバラはモルディブの国花でであ
る。モデルディブで話されているディベヒ語で"Finifenmaa"というのはバラを意味する**
The name honors the fish's stunning pink hues, as well as the pink rose, the national flower of the Ma
ldives. "Finifenmaa" means "rose" in the local Dhivehi language.

![ocean](https://cdn.cnn.com/cnnnext/dam/assets/220309153117-03-rose-veiled-fairy-wrasse-discovery-exl
arge-169.jpg)
**数百の種類の魚の住処であるモルディブの海**
The waters of the Maldives are home to a hundreds of species of fish.


**数百の種類の生物がその諸島国家を囲う海にすんでいるが、この魚はモルディブ出身の科学者によって説明され
る最初の魚である。その科学者は"Ahmed Najeeb"。この魚に関しての研究は火曜日に"the journal ZooKeys"に登
載された。**
While hundreds of species thrive in the waters near and surrounding the archipelago nation, this is th
e first fish to be described by a Maldivian scientist -- Ahmed Najeeb. A study describing the fish pub
lished Tuesday in the journal ZooKeys.

**"いつだってモルディブで見つかった生物を発表するのは外国人だったんだ。それも現地の研究者と関与せずに
ね。たとえそれがモルディブ固有のものでも。"と共著者であり、モルディブ海洋調査機関の生物学者であるNajee
bは声明の中でそう述べた。**
"It has always been foreign scientists who have described species found in the Maldives without much i
nvolvement from local scientists, even those that are endemic to the Maldives," said study coauthor Na
jeeb, a biologist at the Maldives Marine Research Institute, in a statement.

**今回はいつもと違い、初めて何かの一部になれることは本当にエキサイティングでした。特にエキサイティング
だったのはトップクラスの魚類学者と共にこの高貴で美しい魚に関した作業をする機会を持てたことです。**
"This time it is different and getting to be part of something for the first time has been really exci
ting, especially having the opportunity to work alongside top ichthyologists on such an elegant and be
autiful species."

# そのほかの呼び名
A fish by any other name

**この魚は間違えて認識された歴史を持つ。研究者が最初に見つけたのは1990年代だが、彼らは成魚のCirrhilabr
us rubrisquamisかレッドベールフェアリーベラに属すると考えた。"その誤認された魚"は、モルディブから1000k
m南のチャゴス諸島で発見された１匹の稚魚からのみ説明されていた**
The fish has a history of mistaken identity. Researchers first found it in the 1990s, but they thought
 it was an adult belonging to Cirrhilabrus rubrisquamis, or the red velvet fairy wrasse. This differen
t species had only been described from a single juvenile fish found 621 miles (1,000 kilometers) south
 of the Maldives in the Chagos Archipelago.
![チャゴス諸島](https://user-images.githubusercontent.com/34801662/157789570-798db59a-e914-4338-8ab3-2
0ce10cd016e.png)

**"主に明るくカラフルな魚の種であるベラは成長する過程で色が変わるとして知られている。"と筆頭著者であり
、カリフォルニア科学アカデミーの魚類学学芸員のLuiz Rochaはメールの中で述べた。**
Wrasses, a family of largely bright colored fishes, have been known to change in color as they transit
ion from juveniles to adults, said senior study author Luiz Rocha, the California Academy of Sciences
curator of ichthyology, in an email.

**"稚魚のうちはほとんどの種類のベラは同じような見た目だが、際立った特徴をもつのは大人のベラである"と彼
は述べた**
While the juveniles of many species look alike, it's the adults who carry distinguishing characteristi
cs, he said.
![ベラ](https://cdn.cnn.com/cnnnext/dam/assets/220309152934-01-rose-veiled-fairy-wrasse-discovery-exla
rge-169.jpg)
**学名Cirrhilabrus finifenmaaはモルディブの国花であるピンクのバラにちなんで名付けられた。**
The scientific name Cirrhilabrus finifenmaa is a nod to the pink rose, the Maldivian national flower.

**"数か月前、筆頭著者であるYi-Kai Teaはチャゴスの遠隔操作探査機から成魚の映像を受け取ったが、その魚は
モルディブの成魚とはとても異なっていた"とRochaは述べた。この時、我々はこのモルディブに生息する魚がチャ
ゴスのと異なる種類であると確信した。**
"A few months ago, Yi-Kai Tea (our first author) received (remotely operated vehicle) footage from Cha
gos showing adults, which were very different from the adults from the Maldives," Rocha said. "That's
when we decided that the species from the Maldives was new and different from C. rubrisquamis."

**研究の中で、研究者たちは成魚と稚魚の詳細に焦点を当てた。オスの成魚の背びれを支える棘の長さを測り、サ
イズを計測し、色を分類した。**
In their study, the researchers focused on the details of adults and juveniles, analyzing the height o
f the spines supporting their dorsal fins, counting scales and cataloging the colors of the adult male
s.

**ローズベールフェアリーベラのオスの成魚は、明るい赤紫色や桃色、桃橙色、黒紫などの色を含むユニークなカ
ラーパターンをもっている。**
The rose-veiled fairy wrasse adult males have a unique color pattern including bright magenta, peach,
orange-pink and dark purplish-red.

**finifenmaaとrubrisquamisは別種であるという発見は科学者がこれらの魚の範囲を理解するのを助ける。また、
この発見はこれらの魚を保護するときにとても重要になる。**
Discovering that finifenmaa and rubrisquamis were two separate species can help scientists understand
the range of these fish, which becomes especially important when trying to protect them.
![](https://cdn.cnn.com/cnnnext/dam/assets/220309153316-05-rose-veiled-fairy-wrasse-discovery-exlarge-
169.jpg)
**左からAhmed NajeebとLuiz Rocha。モルディブでの調査中、彼らが集めた複数の魚を調べている**
(From left) Ahmed Najeeb and Luiz Rocha inspect some fish they collected during a recent expedition in
 the Maldives.

**"以前私たちは１種類の魚が広く生息していると考えていましたが、実際は異なる２種類の魚で、それらは潜在
的にはるかに限られた分布に生息していました"と筆頭著者であり、シドニー大学博士課程の学生のYi-Kai Teaは
述べた。"これはなぜ新種の生物を説明したり、一般的な分類学が保護や生物多様性管理にとって重要なのかの例
である"**
"What we previously thought was one widespread species of fish, is actually two different species, eac
h with a potentially much more restricted distribution," said lead author Yi-Kai Tea, a University of
Sydney doctoral student, in a statement. "This exemplifies why describing new species, and taxonomy in
 general, is important for conservation and biodiversity management."

**ローズベールフェアリーベラの名前は新しいかもしれないが、既に娯楽のターゲットになっている**
The name may be new, but the rose-veiled fairy wrasse is already a target of the aquarium hobby trade.

**”その種類はとても豊富で現在は乱獲の恐れはないが、その魚が学名を持つ前に商業利用されている場合、不安
が残ります”とRochaは述べた。また、カリフォルニア科学アカデミーの"Hope for Reefs"の共同ディレクターは
こう述べた。"どのくらい生物多様性が残っているかを物語るのは、サンゴ礁の生態系である"**
"Though the species is quite abundant and therefore not currently at a high risk of overexploitation,
it's still unsettling when a fish is already being commercialized before it even has a scientific name
," said Rocha, also a codirector of the California Academy of Sciences Hope for Reefs initiative. "It
speaks to how much biodiversity there is still left to be described from coral reef ecosystems."

# 弱光層のサンゴ礁探索
Exploring 'twilight zone' reefs

**"The Hope for Reefs"の初期の目標はサンゴ礁を調査し、保護することである。先月"The Hope for Reefs"とモ
ルディブ海洋調査機関の調査者がモルディブの弱光層のサンゴ礁調査におけるいくつかのを実施した**
The Hope for Reefs initiative aims to research and restore coral reef systems. Last month, researchers
 from Hope for Reefs and the Maldives Marine Research Institute surveyed some of the Maldives' twiligh
t zone reefs.

**海面から50mから150mのところにサンゴ礁は存在し、ユニークな環境をフェアリーベラのような魚に提供してい
る**
These reefs can be 160 to 500 feet (50 to 150 meters) beneath the ocean's surface and provide a unique
 environment for fish like fairy wrasses.

![Wakanda](https://cdn.cnn.com/cnnnext/dam/assets/190710170737-03-wakanda-new-fish-species-medium-plus
-169.jpg)
`Wakanda`と呼ばれる魚:新しい紫色の魚でBlack Pantherにちなんで名付けられた
A fish called Wakanda: New purple fish honors 'Black Panther'

**"水が光を吸収するので深くに行けば行くほど暗く、水温が低くなる。という環境は本当に普通じゃない。"とRo
chaは述べた。"光がほとんど入らないんで、そこにはほとんどサンゴ礁や藻類はなく結果として、魚の生態系もと
ても異なっていた。そこに住むほとんどの魚はプランクトン(その水深に住む小さな海洋無脊椎動物)を主食にして
いた。"**
"It's a really different environment: It's darker (because the water functions as a filter absorbing l
ight, so the deeper you go, the darker it gets) and colder," Rocha said. "There are much fewer corals,
 and almost no algae (because of the lack of light), so the fish community is very different and most
fish at this depth feed on plankton (tiny marine invertebrates that live in the water column)."

**Rolexによって資金提供された、近年のダイブはいかに広範囲の未調査弱光層のおける調査が難しいか示した。
弱光層は娯楽でダイブできる制限深度より下に位置している。この深度では呼吸によって出る酸素のネガティブな
影響を割けるために、ダイバーは必ず閉鎖式でヘリウムの混ざったガスボンベを使用しなければならない(吐いた
空気が水中に出ない)。大量の装置を必要とするのに加えて、多くのトレーニングを要求するんだとRochaは述べた
。**
The recent dives, funded by an award from Rolex, show just how difficult it is to survey the largely u
nexplored twilight zone reefs -- located below recreational diving limits. The divers must use rebreat
hers and helium mixed into the gas they breathe to avoid the negative effects of breathing oxygen unde
r so much pressure, in addition to using an abundance of gear that requires a lot of training, Rocha s
aid.

**けど、研究によって、その苦労は見合うものだ。"そこにダイビングすることはまるで他の惑星に行くようなこ
とである"とRochaは述べた。"私たちは常にそのサンゴ礁を見る最初の人であり、常に新種の生物を見つける。と
ても大変だがエキサイティングだ！"**
But it's well worth it, according to the researchers.
"Diving there is like visiting another planet," Rocha said. "We are always the first ones to see those
 reefs, and always find new species. It is very challenging, but also very exciting!"

![divers](https://cdn.cnn.com/cnnnext/dam/assets/220309153219-04-rose-veiled-fairy-wrasse-discovery-ex
large-169.jpg)
**最近の遠征にて、モルディブの弱光層のサンゴ礁への探索を準備するダイバーたち**
Divers prepare to explore the twilight zone reefs of the Maldives during a recent expedition.

**最近の調査において、調査チームは多くのローズベールフェアリーベラと少なくとも新種の可能性のある８種類
の魚を見つけた**
During the recent surveys, the research team found more of the rose-veiled fairy wrasse as well as at
least eight potential new species of fish.
**カリフォルニア科学アカデミーとモルディブ海洋調査機関はモルディブのサンゴ礁をこれからも調査していくた
めに、協力を続けている**
The California Academy of Sciences and the Maldives Marine Research Institute are continuing their par
tnership to explore more Maldivian reefs in the future.

**"私たちの協力関係は、未調査の深度の海洋生態系や、そこに住む生物を理解するのをより助けるだろう"とNaje
ebは述べた。"より理解し、より説得力のある化学的証拠を集めれば、生物をよりよく保護できるだろう"**
"Our partnership will help us better understand the unexplored depths of our marine ecosystems and the
ir inhabitants," Najeeb said. "The more we understand and the more compelling scientific evidence we c
an gather, the better we can protect them."

**"最近見つけた８つの新種の標本をもう少し集められることを望んでいる"とRochaは述べた。"加えて、生物の名
前にモルディブの言葉を使うことを続けるために、私たちは親密にモルディブのパートナーと協力している"**
"We hope to collect a few more specimens of the other eight new species we recently found," Rocha said
. "Additionally, we are closely working with our Maldivian partners to keep using Maldivian names in o
ur species."


****

## 単語や熟語
wrasse:ベラ
stunning:驚くべき、見事な、素晴らしい
bear:堅い意味で、[名称や名前]を持つ
honors:動詞として、～をほめ称える、～栄光を授ける。今回は`ちなんで`と訳したがニュアンスはすこし違うき
がする
twilight zone:弱光層、薄暮地帯、光の届かない場所。つまり深海？
archipelago:諸島
endemic:風土病、固有の
ichthyologists:魚類学者
curator:学芸員
Senior Author、First Author、Primary Author、Lead Author:筆頭著者
nod to:～を考慮して
footage:長さ、映像の一部？
unsettling:不安
It speaks to:～を物語る
left to do:～に任せる
the water column:表面から底質への水の概念的な柱のこと
the 比較級, the 比較級:～するほどに～する


## 翻訳元


<div class="url-embed-wrap">
  <a href="https://edition.cnn.com/2022/03/10/world/rose-fairy-wrasse-rainbow-fish-scn/index.html" cla
ss="url-embed">
    <div class="url-embed-context">
      <div class="url-embed-site-title">New rainbow-colored fish lives in the ocean's 'twilight zone'
- CNN</div>
        <div class="url-embed-site-host">edition.cnn.com</div>
    </div>
    <div class="url-embed-thumnail">
      <img src="https://s.wordpress.com/mshots/v1/https://edition.cnn.com/2022/03/10/world/rose-fairy-
wrasse-rainbow-fish-scn/index.html?w=250" alt="">
    </div>
  </a>
</div>


## 参考

国花のバラ

<div class="url-embed-wrap">
  <a href="https://www.facebook.com/MDVinJP/photos/%E3%83%A2%E3%83%AB%E3%83%87%E3%82%A3%E3%83%96%E3%81
%AE%E5%9B%BD%E8%8A%B1%E3%83%A2%E3%83%AB%E3%83%87%E3%82%A3%E3%83%B4%E5%85%B1%E5%92%8C%E5%9B%BD%E3%81%AE
%E5%9B%BD%E3%81%AE%E8%8A%B1%E3%81%AFfinifenmaa%E3%83%95%E3%82%A3%E3%83%8B%E3%83%95%E3%82%A7%E3%83%B3%E
3%83%9E%E3%83%BC%E4%B8%80%E8%88%AC%E3%81%AB%E5%90%8D%E3%81%AE%E7%9F%A5%E3%82%89%E3%82%8C%E3%81%9F%E3%8
3%94%E3%83%B3%E3%82%AF%E8%89%B2%E3%81%AE%E8%96%94%E8%96%87%E3%81%A7%E6%A4%8D%E7%89%A9%E5%AD%A6%E7%9A%8
4%E3%81%AB%E3%81%AF%E3%83%90%E3%83%A9%E3%81%AE%E4%BA%A4%E9%85%8D%E7%A8%AE%E3%81%A8%E7%89%B9%E5%AE%9A%E
3%81%95%E3%82%8C%E3%81%A6%E3%81%84%E3%81%BE%E3%81%99fin/440694689287787/" class="url-embed">
    <div class="url-embed-context">
      <div class="url-embed-site-title">Facebook</div>
        <div class="url-embed-site-host">www.facebook.com</div>
    </div>
    <div class="url-embed-thumnail">
      <img src="https://s.wordpress.com/mshots/v1/https://www.facebook.com/MDVinJP/photos/%E3%83%A2%E3
%83%AB%E3%83%87%E3%82%A3%E3%83%96%E3%81%AE%E5%9B%BD%E8%8A%B1%E3%83%A2%E3%83%AB%E3%83%87%E3%82%A3%E3%83
%B4%E5%85%B1%E5%92%8C%E5%9B%BD%E3%81%AE%E5%9B%BD%E3%81%AE%E8%8A%B1%E3%81%AFfinifenmaa%E3%83%95%E3%82%A
3%E3%83%8B%E3%83%95%E3%82%A7%E3%83%B3%E3%83%9E%E3%83%BC%E4%B8%80%E8%88%AC%E3%81%AB%E5%90%8D%E3%81%AE%E
7%9F%A5%E3%82%89%E3%82%8C%E3%81%9F%E3%83%94%E3%83%B3%E3%82%AF%E8%89%B2%E3%81%AE%E8%96%94%E8%96%87%E3%8
1%A7%E6%A4%8D%E7%89%A9%E5%AD%A6%E7%9A%84%E3%81%AB%E3%81%AF%E3%83%90%E3%83%A9%E3%81%AE%E4%BA%A4%E9%85%8
D%E7%A8%AE%E3%81%A8%E7%89%B9%E5%AE%9A%E3%81%95%E3%82%8C%E3%81%A6%E3%81%84%E3%81%BE%E3%81%99fin/4406946
89287787/?w=250" alt="">
    </div>
  </a>
</div>


リブリーザー

<div class="url-embed-wrap">
  <a href="https://www.padi.co.jp/scuba-diving/columns/rebreather/" class="url-embed">
    <div class="url-embed-context">
      <div class="url-embed-site-title">リブリーザーとは？リブリーザーで広がる新しい世界</div>
        <div class="url-embed-site-host">www.padi.co.jp</div>
    </div>
    <div class="url-embed-thumnail">
      <img src="https://s.wordpress.com/mshots/v1/https://www.padi.co.jp/scuba-diving/columns/rebreath
er/?w=250" alt="">
    </div>
  </a>
</div>


''';

  var basedArticleHtml = markdownToHtml(text, blockSyntaxes: [const TableSyntax()],inlineSyntaxes: [InlineHtmlSyntax()]);
  print(basedArticleHtml);
}