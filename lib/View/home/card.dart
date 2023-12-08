import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Color color;
  final String imagePath;

  const MyCard({
    Key? key,
    required this.color,
    required this.imagePath,
    }) : super(key: key);

  @override
 Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(color: color),
      child:
        Image.asset(
          imagePath, // Gunakan imagePath sebagai sumber gambar
          width: 100,
          height: 100,
          fit: BoxFit.fill,
        ),
    );
  }
}
