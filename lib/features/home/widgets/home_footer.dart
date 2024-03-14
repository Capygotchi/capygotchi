import 'package:capygotchi/shared/widgets/capy_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capygotchi/core/domain/entities/capybara.dart';

class HomeFooter extends StatefulWidget {
  const HomeFooter({
    super.key
  });

  @override
  State<HomeFooter> createState() => _HomeFooterState();
}

class _HomeFooterState extends State<HomeFooter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 70,
        child: Stack(children: [
          Container(color: const Color(0xff8A6552), height: 80),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CapyButton(
                  onPressed: () => context.read<Capybara>().pet(),
                  icon: Icons.pets,
                  backgroundColor: const Color(0xffca2e55),
                ),
                CapyButton(
                  onPressed: () => context.read<Capybara>().feed(),
                  icon: Icons.food_bank,
                  backgroundColor: const Color(0xffca2e55),
                ),
              ],
            ),
          ),
        ])
    );
  }
}
