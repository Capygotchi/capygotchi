import 'package:capygotchi/pages/capybara.dart';
import 'package:flutter/material.dart';

class CapybaraStatsWidget extends StatelessWidget {
  const CapybaraStatsWidget({
    Key? key,
    required this.myCapybara,
  }) : super(key: key);

  final Capybara myCapybara; // Assurez-vous d'importer correctement la classe MyCapybara

  getAge() {
    return DateTime.now().difference(myCapybara.birthDate).inDays;
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("- Type :${myCapybara.color}"),
                      Text("- He is : ${getAge()} days old."),
                      Text('- Hunger: ${myCapybara.hunger}'),
                      Text('- Happiness: ${myCapybara.happiness}'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
