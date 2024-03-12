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
      height: double.infinity,
      child : SizedBox(
        height: 200,
        width: 200,
        child: Column(children: [
          Text(myCapybara.name),
          const Image(image: AssetImage('assets/bigger_capy.gif')),
        ]),

      ),
    );


  }
}
