import 'package:capygotchi/features/home/widgets/home_footer_button.dart';
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
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                HomeFooterButton(
                  onPressed: () => context.read<Capybara>().pet(),
                  icon: const AssetImage('assets/pet.png'),
                  backgroundColor: const Color(0xffA8C69F),
                ),
                HomeFooterButton(
                  onPressed: () => context.read<Capybara>().feed(),
                  icon: const AssetImage('assets/food.png'),
                  backgroundColor: const Color(0xffA8C69F),
                ),

              ],
            ),
          ),
        ])
    );
  }
}
