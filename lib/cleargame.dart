import 'package:flutter/material.dart';

class ClearGame extends StatelessWidget {

  final bool CompleteGame;

  ClearGame({required this.CompleteGame});

  @override
  Widget build(BuildContext context) {
    return CompleteGame ? Container(
      alignment: Alignment(0 , -0.35),
      child:Container(
        child: Text('ゲームクリア！！',style: TextStyle(fontSize: 25),),
      ),
    ) : Container();
  }
}
