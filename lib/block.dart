import 'package:flutter/material.dart';

class Block extends StatelessWidget {

  final blockX;
  final blockY;
  final blockWidth;
  final blockHeight;
  final bool blockbreack;

  Block({this.blockWidth , this.blockHeight , this.blockX , this.blockY , required this.blockbreack});

  @override
  Widget build(BuildContext context) {
    return
    blockbreack ?
    Container():
      Container(
        alignment: Alignment(blockX , blockY),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: MediaQuery.of(context).size.width * blockWidth / 2,
              height: MediaQuery.of(context).size.height * blockHeight / 2,
              decoration: BoxDecoration(
                border: Border.all(color:Colors.red,width: 5),
                color: Colors.black,
              ),
        ),
      ),
    );
  }
}
