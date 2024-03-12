import 'package:appwrite/appwrite.dart';
import 'package:capygotchi/apis/auth_api.dart';
import 'package:capygotchi/pages/capybara_stats.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:capygotchi/pages/capybara_frame.dart';
import 'package:capygotchi/pages/capybara.dart';
import 'package:capygotchi/pages/home_footer.dart';

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
    return ChangeNotifierProvider(
      create: (_) => Capybara(
        name: 'Roger',
        color: 'Brown'
      ),
      child: Scaffold(
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
              onPressed: () {
                context.go('/account');
              },
            ),
          ],
          backgroundColor: const Color(0xff8a6552),
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CapybaraStatsWidget(),
            CapybaraFrameWidget(),
            Spacer(),
            HomeFooterWidget(),
          ],
        ),
      ),
    );
  }
}
