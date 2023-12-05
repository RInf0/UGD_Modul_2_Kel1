import 'package:flutter/material.dart';

class GridButton extends StatelessWidget {
  final String icon;
  final String textButton;

  const GridButton({
    Key? key,
    required this.icon,
    required this.textButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //icon
        Container(
          height: 100,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Center(child: Image.asset(icon)),
        ),
        SizedBox(height: 10),
        //text
        Text(textButton),
      ],
    );
  }
}
