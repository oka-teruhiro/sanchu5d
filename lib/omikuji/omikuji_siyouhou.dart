import 'package:flutter/material.dart';

// 蔵干の解説文
var omikujiSiyouhou = Column(
  children: [
    const ListTile(
      title: Text(
        '　この機能は、このページに入ってから、「おみくじを引く」ボタンをタップするまでの時間を'
            '（ミリ秒）で測定し、おみくじの総数で割った余りに従って、おみくじが表示されます。'
            '仕組みは、単純ですが、人為的に選ぶことができないところに、天が介在できる枠が生れます。', // 1
      ),
    ),
    const ListTile(
      title: Text(
        '　無意識に、あるいはゲーム感覚で、ボタンをタップしても、おみくじは表示されますが、'
            'ボタンをタップする前に、天に切実に回答を求めるとき、そんなあなたの精誠'
            '（せいせい：精一杯に誠をつくすの意味）を条件として、天から回答される仕組みです。'
            'これは、卜術（ぼくじゅつ）と呼ばれる占術に属します。', // 2
      ),
    ),
    const ListTile(
      title: Text(
        '　「祈りを捧げる」ボタンをタップしたら、'
            '迷子になった幼子が、母を求めて叫ぶように、懇切な心情をもって、祈りを捧げて下さい。'
            'その後、「天の声を聞く」ボタンをタップして下さい。'
            '今日のあなたにふさわしいメッセージが与えられることでしょう。'
            '', // 3
      ),
    ),
    const ListTile(
      title: Text(
        '　なお、このメッセージは、深夜１時を超えるまで変化しません。'
            'このメッセージを意識して一日を過ごし、'
            'あなたが天の運勢を得られるよう心からお祈りいたします。', // 4
      ),
    ),
  ],
);
