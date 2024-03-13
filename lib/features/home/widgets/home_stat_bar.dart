import 'package:flutter/material.dart';

class HomeStatBar extends StatelessWidget {
  final int value;
  final String type;

  const HomeStatBar({
    super.key,
    required this.value,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Text('- $type'),
      const SizedBox(width: 10),
      Expanded(
        child: LinearProgressIndicator(
          value: value.toDouble() / 100,
          minHeight: 10.0,
          backgroundColor: const Color(0xff8a6552),
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xffA8C69F)),
        ),
      ),
      Text(' $value%')
    ]);
  }
}
