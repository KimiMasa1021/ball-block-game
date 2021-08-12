import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {
  final playerX;
  final playerY;
  final playerWidth;

  MyPlayer({this.playerX , this.playerWidth , this.playerY});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(playerX + 0.2, playerY),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: MediaQuery.of(context).size.width * playerWidth / 2,
          height: 5,
          color: Colors.black,
        ),
      ),
    );
  }
}
