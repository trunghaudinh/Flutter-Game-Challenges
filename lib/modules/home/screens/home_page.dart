import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_game_challenges/models/barrier.dart';
import 'package:flutter_game_challenges/models/bird.dart';
import 'package:flutter_game_challenges/modules/home/components/barrier_widget.dart';

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
  bool lastScoreIsA = false;

  // setup barrier
  static List<double> barrierX = [2, 3.5];
  static double barrierWidth = 0.5;
  static List<List<double>> barrierHeight = [
    [0.6, 0.4],
    [0.4, 0.6]
  ];

  void jump() {
    setState(() {
      time = 0;
      initiaHeight = birdYaxis;
    });
  }

  static Random random = new Random();

  static double randomInRange(double min, double max) {
    double range = max - min;
    double scaled = random.nextDouble() * range;
    double shifted = scaled + min;
    return shifted; // == (rand.nextDouble() * (max-min)) + min;
  }

  void startGame() {
    isGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initiaHeight - height;
      });

      // setState(() {
      //   if(dp(barrierX[0], 2) == 0.05 || dp(barrierX[1], 2) == 0.05){
      //     score +=1;
      //   }
      // });

      setState(() {
        if (barrierX[0] <= -1.5) {
          // barrierX[0] += 3;
          double random =
              dp(randomInRange(barrierX[0] + 2.7, barrierX[0] + 3), 2);
          barrierX[0] = random;

          double height1 = dp(randomInRange(0.4, 0.7), 2);
          double height2 = dp(randomInRange(0.3, 0.9), 2);
          // print("random = $random height1 = $height1  ||  height2 = $height2");
          barrierHeight[0][0] = height1;
          barrierHeight[0][1] = height2;
        } else {
          barrierX[0] -= 0.05;
        }
      });

      setState(() {
        if (!lastScoreIsA && barrierX[0] <= 0 && barrierX[1] > 0) {
          score += 1;
          lastScoreIsA = true;
        }
      });

      setState(() {
        if (barrierX[1] <= -1.5) {
          double random =
              dp(randomInRange(barrierX[1] + 2.7, barrierX[1] + 3), 2);
          barrierX[1] = random;

          double height1 = dp(randomInRange(0.4, 0.7), 2);
          double height2 = dp(randomInRange(0.3, 0.9), 2);
          // print(" height1 = $height1  ||  height2 = $height2");
          barrierHeight[1][0] = height1;
          barrierHeight[1][1] = height2;
        } else {
          barrierX[1] -= 0.05;
        }
      });

      setState(() {
        if (lastScoreIsA && barrierX[1] <= 0 && barrierX[0] > 0) {
          score += 1;
          lastScoreIsA = false;
        }
      });

      if (idBirdDead()) {
        setState(() {
          if(score > best) best = score;
        });
        timer.cancel();
        isGameStarted = false;
      }
    });
  }

  void resetGame() {
    setState(() {
      birdYaxis = 0;
      isGameStarted = false;
      height = 0;
      time = 0;
      score = 0;
      lastScoreIsA = false;
      initiaHeight = 0;
      barrierX = [2, 3.5];
      barrierHeight = [
        [0.6, 0.4],
        [0.4, 0.6]
      ];
    });
  }

  bool idBirdDead() {
    if (birdYaxis >= 1 || birdYaxis <= -1) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (idBirdDead()) {
          resetGame();
        } else {
          if (isGameStarted) {
            jump();
          } else {
            startGame();
          }
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, birdYaxis),
                      duration: _timeDuration,
                      color: Colors.blue,
                      child: const MyBird(),
                    ),
                    Visibility(
                      visible: isGameStarted ? false : true,
                      child: Container(
                          alignment: const Alignment(0, -0.3),
                          child: Text(
                            "T A P  T O  P L A Y",
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                ?.copyWith(fontSize: 20, color: Colors.white),
                          )),
                    ),
                    BarrierWidget(
                      barrierX: barrierX[0],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[0][0],
                      isBarrierTop: true,
                    ),
                    BarrierWidget(
                      barrierX: barrierX[0],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[0][1],
                      isBarrierTop: false,
                    ),
                    BarrierWidget(
                      barrierX: barrierX[1],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[1][0],
                      isBarrierTop: true,
                    ),
                    BarrierWidget(
                      barrierX: barrierX[1],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[1][1],
                      isBarrierTop: false,
                    ),
                  ],
                )),
            Container(
              color: Colors.green,
              height: 15,
            ),

            // score
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
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20))
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
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20))
                    ],
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  double dp(double val, int places) {
    num mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }
}
