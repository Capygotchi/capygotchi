import 'package:flutter/material.dart';

class CapyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? label;
  final dynamic icon;
  final Color backgroundColor;
  final bool disabled; // Nouvelle propriété pour activer/désactiver le bouton

  const CapyButton({
    Key? key,
    required this.onPressed,
    this.label,
    this.icon,
    this.backgroundColor = Colors.white,
    this.disabled = false, // Par défaut, le bouton n'est pas désactivé
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : onPressed, // Désactiver le bouton si 'disabled' est vrai
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
