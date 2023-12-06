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
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 5,
                spreadRadius: 0,
                offset: const Offset(0.0, 3.5),
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
