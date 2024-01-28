import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer(
      {Key? key,
      required this.child,
      required this.height,
      required this.color})
      : super(key: key);
  final Widget child;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
      ),
      child: child,
    );
  }
}
