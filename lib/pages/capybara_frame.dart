import 'package:capygotchi/pages/capybara.dart';
import 'package:flutter/material.dart';

class CapybaraFrameWidget extends StatelessWidget {
  const CapybaraFrameWidget({
    super.key,
    required this.myCapybara,
  });

  final Capybara myCapybara;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      child : SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(children: [
          Text(myCapybara.name),
          const Image(image: AssetImage('assets/bigger_capy.gif')),
        ]),

      ),
    );


  }
}
