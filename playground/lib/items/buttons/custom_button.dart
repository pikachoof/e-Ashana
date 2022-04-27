import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.widget,
    required this.someContext,
    required this.onTap,
  }) : super(key: key);

  final Widget widget;
  final BuildContext someContext;
  final Function(BuildContext) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap(context),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(10),
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.12),
              spreadRadius: 5,
              blurRadius: 5, // changes position of shadow
            ),
          ],
        ),
        child: ClipOval(child: widget),
      ),
    );
  }
}
