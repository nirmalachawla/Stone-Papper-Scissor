import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spc/constant.dart';

import 'constant.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stone Paper Scissor',
      theme: ThemeData(scaffoldBackgroundColor: Colors.blue[700]),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var random = new Random();
  int playerOne;
  int playerTwo;
  int scoreOne = 0;
  int scoreTwo = 0;

  @override
  void initState() {
    playerOne = random.nextInt(3);
    playerTwo = random.nextInt(3);
    super.initState();
  }

  void winner() {
    for (List<int> list in winSeq) {
      if (list.contains(playerOne) && list.contains(playerTwo)) {
        //list of winseq has the int of play1 and ply2
        if (playerOne != playerTwo) {
          if (playerOne == list[1]) {
            //checking the firt index ie 2nd value in list
            ++scoreOne;
          } else if (playerTwo == list[1]) {
            ++scoreTwo;
          } else {
            break;
          }
        }
      }
    }

    if (scoreTwo == 3 || scoreOne == 3) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('GameOver'),
          content: Text((scoreOne == 3)
              ? 'PlayerOne won the game'
              : 'PlayerTwo won the game'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  scoreOne = 0;
                  scoreTwo = 0;
                  // winner();
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'Play Again',
              ),
            ),
            TextButton(
                onPressed: () {
                  exit(0);
                },
                child: Text('Exit')),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: RotatedBox(
                quarterTurns: 2,
                child: TextButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'PlayerOne \n Score: $scoreOne/3',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.lightGreenAccent,
                          fontFamily: "Miltonian",
                          letterSpacing: 3,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.black,
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shadowColor:
                          MaterialStateProperty.all(Colors.greenAccent[100])),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: RotatedBox(
                quarterTurns: 2,
                child: Imagess(a: playerOne),
              ),
            ),
            // ignore: deprecated_member_use
            Expanded(
              flex: 2,
              child: Center(
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.yellow,
                  splashColor: Colors.yellow,
                  onPressed: () {
                    setState(() {
                      playerOne = random.nextInt(3);
                      playerTwo = random.nextInt(3);
                    });
                    winner(); //since checking result thats y outside setstate
                    if (scoreOne == 3 || scoreTwo == 3) {
                      showDialog();
                    }
                  },
                  label: Text(
                    'Play',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  icon: Icon(
                    Icons.play_arrow,
                    color: Colors.black,
                    size: 55,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Imagess(a: playerTwo),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: TextButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'PlayerTwo \n Score: $scoreTwo/3',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.limeAccent,
                        fontFamily: "Miltonian",
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.black,
                    ),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shadowColor:
                        MaterialStateProperty.all(Colors.greenAccent[100])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Imagess extends StatelessWidget {
  final Map<int, String> img = {
    0: "assets/images/Stone.png",
    1: "assets/images/Paper.png",
    2: "assets/images/Scissor.png",
  };
  int a;
  Imagess({Key key, this.a}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        img[a],
        height: double.maxFinite,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
