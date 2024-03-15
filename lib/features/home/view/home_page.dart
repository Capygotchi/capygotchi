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
  @override
  void initState() {
    super.initState();
    _loadOrCreateCapybara();
  }

  Future<void> _loadOrCreateCapybara() async {
    final databaseApi = context.read<DatabaseAPI?>();
    final user = context.read<User?>();

    if(user == null || databaseApi == null) return;

    // Vérifiez si un Capybara existe déjà pour cet utilisateur
    final capybara = await databaseApi.getMonster(userId: user.userId);

    if (capybara != null && capybara.alive == true) {
      // Si un Capybara vivant est trouvé, utilisez-le
      setState(() {
        context.read<Capybara>().updateCapybara(capybara);
      });
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
