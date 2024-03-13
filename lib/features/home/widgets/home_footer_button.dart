import 'package:flutter/material.dart';

class HomeFooterButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? label;
  final dynamic icon;
  final Color backgroundColor;

  const HomeFooterButton({
    super.key,
    required this.onPressed,
    this.label,
    this.icon,
    this.backgroundColor = const Color(0xffA8C69F),
  });

  @override
  Widget build(BuildContext context) {
    print(icon);
    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color(0xFF000000),
              width: 2.0,
              style: BorderStyle.solid), //Border.all
          /*** The BorderRadius widget  is here ***/
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child:
        IconButton(
          onPressed: onPressed,
          icon: Image(
            image: icon,
            width: 100,
            height: 100,
            color: Colors.white,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
          ),
        )
    );
  }
}