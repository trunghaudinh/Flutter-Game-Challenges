import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_game_challenges/models/bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _timeDuration = const Duration(milliseconds: 0);
  double birdYaxis = 0;
  double height = 0;
  double time = 0;
  double initiaHeight = 0;
  bool isGameStarted = false;
  int score = 0;
  int best = 0;

  void jump() {
    setState(() {
      time = 0;
      initiaHeight = birdYaxis;
    });
  }

  void startGame() {
    isGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initiaHeight - height;
      });

      if (birdYaxis > 1) {
        timer.cancel();
        isGameStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  if (isGameStarted) {
                    jump();
                  } else {
                    startGame();
                  }
                },
                child: AnimatedContainer(
                  alignment: Alignment(0, birdYaxis),
                  duration: _timeDuration,
                  color: Colors.blue,
                  child: const MyBird(),
                ),
              )),
          Container(
            color: Colors.green,
            height: 15,
          ),
          Expanded(
              child: Container(
            color: Colors.brown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "SCORE",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("$score",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "BEST",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("$best",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20))
                  ],
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
