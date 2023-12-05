import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final color;

  const MyCard({
    Key? key,
    required this.color,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(color: color),
      child: const Column(children: [
        Text(""),
      ]),
    );
  }
}
