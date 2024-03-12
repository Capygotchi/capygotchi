import 'package:appwrite/appwrite.dart';
import 'package:capygotchi/apis/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int hunger = 100;
  int happiness = 100;

  feed() {
    setState(() {
      if (hunger < 200) {
        hunger += 10;
      }
    });
  }
  pet() {
    setState(() {
      if (happiness < 200) {
        happiness += 10;
      }
    });
  }
  signOut() {
    try {
      context.read<AuthAPI>().signOut();
    } on AppwriteException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4E6E4),
      appBar: AppBar(
        title: const Text(
          'Capygatcha',
          style: TextStyle(fontFamily: 'Capriola', color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            iconSize: 40,
            icon: const Icon(
              Icons.account_circle_rounded,
              color: Colors.white,
            ),
            tooltip: 'Account button',
            onPressed: () {},
          ),
        ],
        backgroundColor: const Color(0xff8a6552),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Welcome!'),
          Container(
            height: 200,
            width: 200,
            child: Column(
              children: <Widget>[
                Text('Hunger: $hunger'),
                Text('Happiness: $happiness'),
              ],
            )
          ),
          const Spacer(),
          const SizedBox(
            height: 200,
            width: 200,
            child: Column(children: [
              Text('Capygatcha'),
              Image(image: AssetImage('assets/bigger_capy.gif')),
            ]),

          ),
          SizedBox(
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
              ]))
        ],
      ),
    );
  }
}
