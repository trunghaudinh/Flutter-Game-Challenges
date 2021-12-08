import 'package:flutter/material.dart';
import 'package:flutter_game_challenges/models/barrier.dart';

class BarrierWidget extends StatelessWidget {
  final double barrierX;
  final double barrierY;

  const BarrierWidget(
      {Key? key, required this.barrierX, required this.barrierY})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        alignment: Alignment(barrierX, barrierY),
        duration: const Duration(milliseconds: 0),
        child: const MyBarrier(size: 150));
  }
}
