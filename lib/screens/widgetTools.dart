import 'package:flutter/material.dart';
import 'package:virtant/screens/colors.dart';

class PopContainer extends StatelessWidget {
  final Widget child;
  final double height;
  const PopContainer({Key key, @required this.child, this.height = 450})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whitePink,
      ),
      height: height,
      child: child,
    );
  }
}

OutlineInputBorder outlineFormInputBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: purpleDark));
}
