import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  const MyBird({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: Image.asset(
          "assets/images/image_bird.png",
          width: 40,
          height: 40,
        ));
  }
}
