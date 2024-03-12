import 'package:capygotchi/pages/capybara.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CapybaraFrameWidget extends StatefulWidget {
  const CapybaraFrameWidget({
    super.key
  });

  @override
  State<CapybaraFrameWidget> createState() => _CapybaraFrameWidgetState();
}

class _CapybaraFrameWidgetState extends State<CapybaraFrameWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      child : SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(children: [
          Text(context.read<Capybara>().name),
          const Image(image: AssetImage('assets/bigger_capy.gif')),
        ]),
      ),
    );
  }
}
