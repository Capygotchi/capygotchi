import 'package:flutter/material.dart';
import 'capybara.dart';

class HomeFooterWidget extends StatelessWidget {
  final Capybara myCapybara;

  const HomeFooterWidget({
    super.key,
    required this.myCapybara,
  });

  feed() {
    setState(() {
      if (myCapybara.hunger < 200) {
        myCapybara.hunger += 10;
      }
    });
  }
  pet() {
    setState(() {
      if (myCapybara.happiness < 200) {
        myCapybara.happiness += 10;
      }
    });
  }

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
                  onPressed: () {pet();},
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
                    onPressed: () {feed();},
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
        ]));
  }

  void setState(Null Function() param0) {}
}
