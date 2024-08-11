import 'package:flutter/material.dart';

// 蔵干の解説文
var kaisetuZoukan = Column(
  children: [
    ListTile(
      title: Image.asset('assets/images/tuuhenbosi/通変星蔵干1.jpg'), // 38
    ),
    const ListTile(
      title: Text(
        '　四柱推命学の初伝では一番重要と言ってもいい箇所になります。', // 38
      ),
    ),
    const ListTile(
      title: Text(
        '　「蔵干」は、「蔵（くら）」と「干（かん）」と書きますが、'
        '「十干（じゅっかん）」が入った「蔵（くら）」ということです。', // 39
      ),
    ),
    const ListTile(
      title: Text(
        '　運勢学では、どういうことになっているかというと、まず「根っこ」があって、'
        'そこから、「幹（みき）」が出て、それが別れていって「枝」「葉」になっています。', // 40
      ),
    ),
    const ListTile(
      title: Text(
        '　「幹（みき）」は新幹線（しんかんせん）の幹（かん）という字ですが、'
        'そこに「干（かん）」という文字が含まれています。'
        '「枝（えだ）」の字は、「支（し）」という文字が含まれています。', // 41
      ),
    ),
    const ListTile(
      title: Text(
        '　したがって、「十干」は「幹」、「十二支」は「枝」を意味しています・', // 42
      ),
    ),
    ListTile(
      title: Image.asset('assets/images/tuuhenbosi/通変星蔵干2.jpg'), // 43
    ),
    const ListTile(
      title: Text(
        '　幹と枝とを比べると、根に近いほうが重要とみます。根から吸い上げた水分は幹を通って枝に届くように、'
        '本質的な事柄が、十干という幹を経由して十二支という枝として現れたとみます。'
        'したがって、十二支は、掘り下げていくと十干の要素を持っていることになります。'
        'この掘り下げていく作業は、大変な作業で、まるで真っ暗な蔵の中を、'
        '手探りで探し出すようなことなので、見つける作業や見つかった十干を、蔵干と呼びます。', // 43
      ),
    ),
    const ListTile(
      title: Text(
        '　1975年9月6日生まれの人を例にして、蔵干を算出してみます。', // 44
      ),
    ),
    ListTile(
      title: Image.asset('assets/images/tuuhenbosi/通変星蔵干3.jpg'), // 45
    ),
    const ListTile(
      title: Text(
        '　命式は、年の柱から、乙卯・甲申・乙卯になります。ここで、乙・甲・乙は、'
        '天干（てんかん）と呼びます、天の方にある十干。天の方にあって非常にわかりやすい十干ということがいえます。', // 45
      ),
    ),
    const ListTile(
      title: Text(
        '　一方、卯・申・卯は、地にあるので、地にある十二支ということで、地支（ちし）と呼びます。'
        '地支は、さらに地下に掘り進んでみないと、どんな十干が現れてくるかわからないところがあります。'
        'なので掘り進んでそこに潜んでいる十干を見つける作業、蔵干という作業をします。'
        'このとき使う表が、蔵干表です。正式名称は、'
        '月律分野蔵干深浅表（げつりつぶんやぞうかんしんせんひょう）ですが、'
        'この名称は覚える必要ありません。', // 46
      ),
    ),
    ListTile(
      title: Image.asset('assets/images/tuuhenbosi/通変星蔵干5.jpg'), // 47
    ),
    const ListTile(
      title: Text(
        '　具体的に、1975年9月6日生まれの人を例にして、蔵干を算出してみましょう。'
        '地支は、下の図のように、日の柱が卯、月の柱が申、年の柱が卯です。', // 47
      ),
    ),
    ListTile(
      title: Image.asset('assets/images/tuuhenbosi/通変星蔵干8.jpg'), // 48
    ),
    const ListTile(
      title: Text(
        '　一方、節入り日からの日数は、下図のように、30日になっています。', // 48
      ),
    ),
    ListTile(
      title: Image.asset('assets/images/tuuhenbosi/通変星蔵干4.jpg'), // 49
    ),
    const ListTile(
      title: Text(
        '　そこで、蔵干表で、日の柱の「卯」の行を右へ30日堀り進みます。'
        'すると「乙」を得ます。これが日の柱の蔵干になります。', // 49
      ),
    ),
    ListTile(
      title: Image.asset('assets/images/tuuhenbosi/通変星蔵干6.jpg'), // 50
    ),
    const ListTile(
      title: Text(
        '　同様に、月の柱の「申」の行を右へ30日掘り進むと、蔵干「庚」を得ます。'
        '年の柱の「卯」は日の柱と同じなので蔵干「乙」を得ます。', // 50
      ),
    ),
    const ListTile(
      title: Text(
        '　得られた蔵干を、カルテの蔵干の欄に記入します。', // 51
      ),
    ),
    ListTile(
      title: Image.asset('assets/images/tuuhenbosi/通変星蔵干7.jpg'), // 52
    ),
    const ListTile(
      title: Text(
        '　本アプリは、アプリ内にこの蔵干表を持っているので、上記の計算をして、表示しています。', // 52
      ),
    ),
    const ListTile(
      title: Text(
        '', // 148
      ),
    ),
    const ListTile(
      title: Text(
        '　　　　　　　　　以上', // 149
      ),
    ),
  ],
);
