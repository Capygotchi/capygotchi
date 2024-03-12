import 'package:flutter/material.dart';

class AccountTextField extends StatelessWidget {
  final TextEditingController controller;

  const AccountTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        fontFamily: 'Capriola',
        color: Colors.white,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      controller: controller,
    );
  }
}