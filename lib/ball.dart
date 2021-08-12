import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {

  final ballX;
  final ballY;
  final ballWidth;
  final ballHeight;
  MyBall({this.ballX , this.ballY , this.ballHeight , this.ballWidth});

  @override
  Widget build(BuildContext context) {
    return               Container(
      alignment: Alignment(ballX , ballY),
      child: Container(
        width: MediaQuery.of(context).size.width * ballWidth / 2,
        height: MediaQuery.of(context).size.height * ballHeight / 2,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.blueAccent,
                  spreadRadius: 15,
                  blurRadius: 5,
                  offset: Offset(0,0)
              )
            ],
            color: Colors.black,
            shape: BoxShape.circle
        ),
      ),
    );
  }
}
