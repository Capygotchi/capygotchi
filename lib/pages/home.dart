import 'package:appwrite/appwrite.dart';
import 'package:capygotchi/apis/auth_api.dart';
import 'package:capygotchi/pages/capybara_stats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'capybara.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Capybara myCapybara = Capybara(
    name: 'Roger',
    color: 'Brown',
    birthDate: DateTime.now(),
    hunger: 100,
    happiness: 100,
  );

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
          CapybaraStatsWidget(
            myCapybara: myCapybara, // Assurez-vous d'avoir accès au capybara dans cette classe
          ),
          SizedBox(
            height: 200,
            width: 200,
            child: Column(children: [
              Text(myCapybara.name),
              const Image(image: AssetImage('assets/bigger_capy.gif')),
            ]),

          ),
          const Spacer(),
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
