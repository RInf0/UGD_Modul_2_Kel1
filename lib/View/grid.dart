import 'package:flutter/material.dart';

class MyGrid extends StatefulWidget {
  const MyGrid({super.key});

  @override
  State<MyGrid> createState() => _MyGridState();
}

class _MyGridState extends State<MyGrid> {
  //number of childs used in the example
  static const itemCount = 8;

//list of each bloc expandable state, that is changed to trigger the animation of the AnimatedContainer
  List<bool> expandableState = List.generate(itemCount, (index) => false);

  Widget bloc(double width, int index) {
    bool isExpanded = expandableState[index];

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          setState(() {
            //changing the current expandableState
            expandableState[index] = !isExpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(23),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOut,
              width: !isExpanded ? width * 0.4 : width * 0.85,
              height: !isExpanded ? width * 0.4 : width * 0.85,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Align(
        child: SingleChildScrollView(
          child: Wrap(
            children: List.generate(itemCount, (index) {
              return bloc(width, index);
            }),
          ),
        ),
      ),
    );
  }
}
