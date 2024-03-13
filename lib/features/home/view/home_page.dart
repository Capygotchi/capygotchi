import 'package:appwrite/appwrite.dart';
import 'package:capygotchi/core/infrastructure/auth_api.dart';
import 'package:capygotchi/features/home/widgets/home_footer.dart';
import 'package:capygotchi/features/home/widgets/home_frame.dart';
import 'package:capygotchi/features/home/widgets/home_stats.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:capygotchi/core/domain/entities/capybara.dart';

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
    //initializing the capybara
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
            style: TextStyle(color: Colors.white),
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
            HomeStats(),
            HomeFrame(),
            Spacer(),
            HomeFooter(),
          ],
        ),
      ),
    );
  }
}
