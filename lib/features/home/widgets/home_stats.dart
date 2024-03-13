import 'package:capygotchi/core/domain/entities/capybara.dart';
import 'package:capygotchi/features/home/widgets/home_stat_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeStats extends StatefulWidget {
  const HomeStats({super.key});

  @override
  State<HomeStats> createState() => _HomeStatsState();
}

class _HomeStatsState extends State<HomeStats> {
  getAge() {
    return DateTime.now().difference(context.read<Capybara>().birthDate).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final capybara = context.watch<Capybara>();
    return Container(
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
                      Text("- Type :${capybara.color}"),
                      Text("- He is : ${getAge()} days old."),
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
