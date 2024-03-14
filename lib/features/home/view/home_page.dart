import 'package:appwrite/appwrite.dart';
import 'package:capygotchi/core/infrastructure/auth_api.dart';
import 'package:capygotchi/features/home/widgets/home_footer.dart';
import 'package:capygotchi/features/home/widgets/home_frame.dart';
import 'package:capygotchi/features/home/widgets/home_stats.dart';
import 'package:flutter/material.dart';
import 'package:capygotchi/core/infrastructure/database_api.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:capygotchi/core/domain/entities/capybara.dart';

import 'package:capygotchi/core/domain/entities/user.dart';

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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initMonster(context);
    });
    super.initState();
  }

  initMonster(BuildContext context) async {
    final database = context.read<DatabaseAPI?>();
    final user = context.read<User?>();

    if(database != null && user?.userName != null) {
      final loadedCapybara = await database.getMonster(userId: context.read<User>().userId);
      final newCapybara = Capybara(
        name: 'Capybara',
        color: CapyColor.brown,
        documentId: '',
      );

      // No capybara found in database
      if(loadedCapybara == null && context.mounted) {
        await database.createMonster(capybara: newCapybara, userId: context.read<User>().userId);
        if(!context.mounted) return;
        context.read<Capybara>().updateCapybara(newCapybara);
      }

      // Capybara found is dead
      if(loadedCapybara?.alive == false && loadedCapybara != null && context.mounted) {
        database.deleteMonster(capybara: loadedCapybara);
        await database.createMonster(capybara: newCapybara, userId: context.read<User>().userId);
        if(!context.mounted) return;
        context.read<Capybara>().updateCapybara(newCapybara);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF4E6E4),
        appBar: AppBar(
          title: const Text(
            'Capygotchi',
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
      );
  }
}
