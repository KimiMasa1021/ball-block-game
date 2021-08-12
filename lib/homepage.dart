import 'dart:async';
import 'package:ball_block_game/ball.dart';
import 'package:ball_block_game/blockwidgetpage.dart';
import 'package:ball_block_game/cleargame.dart';
import 'package:ball_block_game/coverscreen.dart';
import 'package:ball_block_game/gameoverscreen.dart';
import 'package:ball_block_game/player.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  //ボールのX軸Y軸
  double ballX = -0.7;
  double ballY = -0.9;
  double ballWidth = 0.05;
  double ballHeight = 0.05;
  double ballXincrement = 0.0025;
  double ballYincrement = 0.0025;
  var ballXDirection = direction.LEFT;
  var ballYDirection = direction.UP;

  //画面タップでスタート
  bool switchGame = false;
  bool isGameOver = false;
  bool CompleteGame = false;
  bool StartGame = false;
  bool resetGame1 = false;
  bool resetGame2 = false;

  //ブロックの座標と大きさ壊すやつ
  static double firstblockX = -0.9;
  static double firstblockY = -0.9;
  double blockWidth = 0.3;
  double blockHeight = 0.06;

  List myBlock = [
    [firstblockX,       firstblockY + 0.5, false],
    [firstblockX + 0.6, firstblockY,       false],
    [firstblockX + 1.2, firstblockY,       false],
    [firstblockX + 1.8, firstblockY,       false],
    [firstblockX,       firstblockY + 0.6, false],
    [firstblockX + 0.6, firstblockY + 0.6, false],
    [firstblockX + 1.2, firstblockY + 0.1, false],
    [firstblockX + 1.8, firstblockY + 0.1, false],
    [firstblockX,       firstblockY + 0.4, false],
    [firstblockX + 0.6, firstblockY + 0.4, false],
    [firstblockX + 1.2, firstblockY + 0.5, false],
    [firstblockX + 1.8, firstblockY + 0.6, false],
    [firstblockX + 1.8, firstblockY + 0.3, false],
    [firstblockX + 1.2, firstblockY + 0.4, false],
    [firstblockX + 0.6, firstblockY + 0.5, false],
    [firstblockX,       firstblockY + 0.6, false],
    [firstblockX,       firstblockY + 0.7, false],
    [firstblockX + 0.6, firstblockY + 0.7, false],
    [firstblockX + 1.2, firstblockY + 0.7, false],
    [firstblockX + 1.8, firstblockY + 0.7, false],
    [firstblockX + 1.8, firstblockY + 0.8, false],
    [firstblockX + 1.8, firstblockY + 0.9, false],
    [firstblockX + 1.8, firstblockY + 1.0, false],
    [firstblockX + 1.8, firstblockY + 1.1, false],
    [firstblockX + 1.8, firstblockY + 1.2, false],
    [firstblockX,       firstblockY + 0.8, false],
    [firstblockX,       firstblockY + 0.9, false],
    [firstblockX,       firstblockY + 1.0, false],
    [firstblockX,       firstblockY + 1.1, false],
    [firstblockX,       firstblockY + 1.2, false],
  ];

  //プレイヤーの棒
  double playerX = -0.2;
  double playerY = 0.9;
  double playerWidth = 0.4;

  void startGame() {
    switchGame = true;
    if (StartGame == false) {
      Timer.periodic(Duration(milliseconds: 1), (Gametimer) {
        //向き変更
        updateDirection();
        //壁判定
        moveBallWall();
        //ゲームオーバーの動作
        if (isPlayerStop()) {
          Gametimer.cancel();
          isGameOver = true;
          resetGame2 = true;
        }
        //ゲームクリア時の動作
        if (completeBlock()) {
          Gametimer.cancel();
          CompleteGame = true;
          resetGame1 = true;
        }
        //ブロックの当たり判定
        breakBlockhaha();
      });
    }
    StartGame = true;
  }

  bool completeBlock() {
    for (int e = 0; e < myBlock.length; e++) {
      if (myBlock[e][2] == false) return false;
    }
    return true;
  }

  void breakBlockhaha() {
    for (int i = 0; i < myBlock.length; i++) {
      if ((ballX >= myBlock[i][0] - 0.2 &&
              ballX <= myBlock[i][0] + blockWidth - 0.1 &&
              ballY >= myBlock[i][1] &&
              ballY <= myBlock[i][1] + blockHeight &&
              myBlock[i][2] == false) ||
          (ballY >= myBlock[i][1] &&
              ballY <= myBlock[i][1] + blockHeight &&
              ballX >= myBlock[i][0] &&
              ballX <= myBlock[i][0] + blockWidth - 0.09 &&
              myBlock[i][2] == false)) {
        myBlock[i][2] = true;
        double topTeach = (ballY - (myBlock[i][1])).abs();
        double bottomTeach = (ballY - (myBlock[i][1] + blockHeight)).abs();
        double rightTeach = (ballX - (myBlock[i][0] + blockWidth)).abs();
        double leftTeach = (ballX - (myBlock[i][0])).abs();
        print(topTeach);
        print(bottomTeach);
        print(rightTeach);
        print(leftTeach);
        double minTeach = topTeach;

        if(minTeach > bottomTeach)minTeach = bottomTeach;
        if(minTeach > rightTeach)minTeach = rightTeach;
        if(minTeach > leftTeach)minTeach = leftTeach;


        print(minTeach);
        while (true) {
          if (minTeach == bottomTeach) {
            setState(() {
              ballYDirection = direction.DOWN;
              print('衝突下');
            });
            break;
          }
          if (minTeach == topTeach) {
            setState(() {
              ballYDirection = direction.UP;
              print('上衝突');
            });
            break;
          }
          if (minTeach == rightTeach) {
            setState(() {
              print("右衝突");
              ballXDirection = direction.RIGHT;
            });
            break;
          }
          if (minTeach == leftTeach) {
            setState(() {
              print("左衝突");
              ballXDirection = direction.LEFT;
            });
            break;
          }
        }
      }
    }
  }

//下にはみ出たらストップ
  bool isPlayerStop() {
    if (ballY >= 0.95) return true;
    return false;
  }

//上　下　右　左　動かすやつの切り替え　壁！！！
  void moveBallWall() {
    setState(() {
      //縦方向
      if (ballYDirection == direction.DOWN) {
        ballY += ballYincrement;
      } else if (ballYDirection == direction.UP) {
        ballY -= ballYincrement;
      }
      //横方向
      if (ballXDirection == direction.RIGHT) {
        ballX += ballXincrement;
      } else if (ballXDirection == direction.LEFT) {
        ballX -= ballXincrement;
      }
    });
  }

  void updateDirection() {
    setState(() {
      //
      if ((ballY >= playerY && ballY <= playerY + 0.1) &&
          ballX >= playerX - 0.1 &&
          ballX <= playerX + playerWidth + 0.2) {
        ballYDirection = direction.UP;
      } else if (ballY <= -1) {
        ballYDirection = direction.DOWN;
      } else if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      } else if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
    });
  }

  //ボーダー右へ
  void moveRight() {
    setState(() {
      if ((playerX + 0.4 <= 1)) playerX += 0.2;
    });
  }

  //ボーダー左へ
  void moveLeft() {
    setState(() {
      if ((playerX >= -1)) playerX -= 0.2;
    });
  }

  void moveUp() {
    setState(() {
      playerY -= 0.1;
    });
  }

  void moveDown() {
    setState(() {
      playerY += 0.1;
    });
  }

  void resetGameTrue() {
    setState(() {
      resetGame1 = false;
      resetGame2 = false;
      switchGame = false;
      isGameOver = false;
      CompleteGame = false;
      StartGame = false;
      resetGame1 = false;
      playerX = -0.2;
      ballY = 0.27;
      ballX = 0;
      ballXDirection = direction.RIGHT;
      ballYDirection = direction.UP;
    });
    for (int x = 0; x < myBlock.length; x++) {
      myBlock[x][2] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: startGame,
      child: Scaffold(
        backgroundColor: Colors.redAccent,
        body: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('imges/que-11241012441.jpg'),
                  fit: BoxFit.cover,
                )),
                child: Stack(
                  children: [
                    //タップしてスタートのテキスト
                    CoverScreen(switchGame: switchGame),
                    //ボールのウジェット
                    MyBall(
                        ballX: ballX,
                        ballY: ballY,
                        ballWidth: ballWidth,
                        ballHeight: ballHeight),
                    //プレイヤーの棒
                    MyPlayer(
                      playerX: playerX,
                      playerWidth: playerWidth,
                      playerY: playerY,
                    ),
                    //ゲームオーバーのテキスト
                    GameOver(
                      isGameOver: isGameOver,
                    ),
                    //ゲームクリアのテキスト
                    ClearGame(
                      CompleteGame: CompleteGame,
                    ),
                    //ブロックのウィジェット
                    BlockWidget(
                      myBlock: myBlock,
                      blockWidth: blockWidth,
                      blockHeight: blockHeight,
                    ),
                    //クリアした時のアラート
                    resetGame1
                        ? AlertDialog(
                            title: Text('おめでと'),
                            actions: [
                              TextButton(
                                child: Text('もう一度'),
                                onPressed: () {
                                  resetGameTrue();
                                },
                              ),
                              TextButton(
                                child: Text('ホームに戻る'),
                                onPressed: () {},
                              )
                            ],
                          )
                        : SizedBox(),
                    //失敗した時のアラート
                    resetGame2
                        ? AlertDialog(
                            title: Text('ざんねん'),
                            actions: [
                              TextButton(
                                child: Text('もう一度'),
                                onPressed: () {
                                  resetGameTrue();
                                },
                              ),
                              TextButton(
                                child: Text('ホームに戻る'),
                                onPressed: () {},
                              )
                            ],
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ),
            Container(
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.black54,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        moveLeft();
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.redAccent),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              moveUp();
                            },
                            child: Container(
                              decoration:
                                  BoxDecoration(color: Colors.redAccent),
                              width: 80,
                              height: 40,
                              child: Center(
                                  child: Text(
                                'UP',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              moveDown();
                            },
                            child: Container(
                              decoration:
                                  BoxDecoration(color: Colors.redAccent),
                              width: 80,
                              height: 40,
                              child: Center(
                                  child: Text('DOWN',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        moveRight();
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.redAccent),
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
