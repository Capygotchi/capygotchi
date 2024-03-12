import 'package:flutter/material.dart';

class CapyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? label;
  final dynamic icon;
  final Color backgroundColor;

  const CapyButton({
    super.key,
    required this.onPressed,
    this.label,
    this.icon,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon is IconData)
            Icon(
              icon,
              color: Colors.white,
            ),
          if (icon is ImageProvider)
            Image(
              image: icon,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
          if (icon != null && label != null)
            const SizedBox(width: 8),
          if (label != null)
            Text(
              label!,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
