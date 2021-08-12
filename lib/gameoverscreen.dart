import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  final bool isGameOver;

  GameOver({required this.isGameOver});

  @override
  Widget build(BuildContext context) {
    return isGameOver ? Container(
      alignment: Alignment(0 , -0.35),
      child:Container(
        child: Text('ゲームオーバー！！！',style: TextStyle(fontSize: 25),),
      ),
    ): Container();
  }
}
