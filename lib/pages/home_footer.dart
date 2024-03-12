import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capygotchi/pages/capybara.dart';

class HomeFooterWidget extends StatefulWidget {
  const HomeFooterWidget({
    super.key
  });

  @override
  State<HomeFooterWidget> createState() => _HomeFooterWidgetState();
}

class _HomeFooterWidgetState extends State<HomeFooterWidget> {
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
                ElevatedButton(
                  onPressed: () => context.read<Capybara>().pet(),
                  child: const Icon(
                    Icons.pets,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ElevatedButton(
                    onPressed: () => context.read<Capybara>().feed(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff8A6552),
                      minimumSize: const Size(100, 100),
                      fixedSize: const Size(100, 100),
                    ),
                    child: const Icon(Icons.food_bank,
                        color: Colors.white, size: 40),
                  ),
                ),
              ],
            ),
          ),
        ])
    );
  }
}
