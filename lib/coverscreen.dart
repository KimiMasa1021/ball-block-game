import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {

  bool switchGame;

  CoverScreen({required this.switchGame});//コンストラクタ//初期化をし、インスタンスを生成する。

  @override
  Widget build(BuildContext context) {
    return switchGame ? Container() : Container(
      alignment: Alignment(0 , -0.2),
      child: Text('タップしてスタート！！！',style: TextStyle(fontSize: 25),),
    );
  }
}
