import 'package:flutter/material.dart';
import 'package:flutter_game_challenges/models/barrier.dart';

class BarrierWidget extends StatelessWidget {
  final double barrierX;
  final double barrierWidth;
  final double barrierHeight;
  final bool isBarrierTop;

  const BarrierWidget(
      {Key? key,
      required this.barrierX,
      required this.barrierWidth,
      required this.barrierHeight,
      required this.isBarrierTop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 0),
        alignment: Alignment(barrierX, isBarrierTop ? -1 : 1),
        child: Container(
          width: MediaQuery.of(context).size.width * barrierWidth / 3,
          height:
              MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,
          color: Colors.green,
        ));
  }
}
