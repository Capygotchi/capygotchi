import 'package:appwrite/appwrite.dart';
import 'package:capygotchi/apis/auth_api.dart';
import 'package:capygotchi/pages/capybara_stats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'capybara.dart';
import 'capybara_frame.dart';
import 'home_footer.dart';

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
          CapybaraFrameWidget(
            myCapybara: myCapybara,
          ),
          const Spacer(),
          HomeFooterWidget(
            myCapybara: myCapybara,
          ),
        ],
      ),
    );
  }
}
