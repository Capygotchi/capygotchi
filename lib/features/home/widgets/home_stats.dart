import 'dart:async';
import 'package:capygotchi/core/domain/entities/capybara.dart';
import 'package:capygotchi/features/home/widgets/home_stat_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:capygotchi/core/domain/entities/user.dart';
import 'package:capygotchi/core/infrastructure/database_api.dart';

class HomeStats extends StatefulWidget {
  const HomeStats({super.key});

  @override
  State<HomeStats> createState() => _HomeStatsState();
}

class _HomeStatsState extends State<HomeStats> {
  late Timer _timer; // Timer pour mettre à jour le capybara

  getAge() {
    return DateTime.now().difference(context.read<Capybara>().birthDate).inDays;
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      updateMonster();
    });
  }

  updateMonster() async {
    await context.read<DatabaseAPI?>()?.updateMonster(
      capybara: context.read<Capybara>(),
      userId: context.read<User>().userId
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // Arrêter le Timer lorsque le widget est supprimé
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final capybara = context.watch<Capybara>();
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Capybara Details:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("- Type :${capybara.color.name}"),
                      Text("- He is : ${getAge()} days old."),
                      HomeStatBar(
                          value: capybara.life!, type: "life:              "),
                      HomeStatBar(
                          value: capybara.hunger!, type: "Hunger:      "),
                      HomeStatBar(
                          value: capybara.happiness!, type: "Happiness:"),
                    ],
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
