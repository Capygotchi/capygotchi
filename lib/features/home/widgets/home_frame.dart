import 'package:capygotchi/core/domain/entities/capybara.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeFrame extends StatefulWidget {
  const HomeFrame({
    super.key
  });

  @override
  State<HomeFrame> createState() => _HomeFrameState();
}

class _HomeFrameState extends State<HomeFrame> {
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
