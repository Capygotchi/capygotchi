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
          ElevatedButton(
            onPressed: () => signOut(),
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.white),
            child: const Text('logout'),
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
                        onPressed: () {},
                        child: const Icon(
                          Icons.pets,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Icon(Icons.food_bank,
                            color: Colors.white, size: 40),
                      ),
                    ],
                  ),
                ),
              ]))
        ],
      ),
      /*bottomNavigationBar: BottomNavigationBar(
      backgroundColor: const Color(0xff8A6552),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.call),
          label: 'pet',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera),
          label: 'feed',
        ),
      ],
    )*/
    );
  }
}
