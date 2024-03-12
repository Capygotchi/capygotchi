import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();


}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
              title: const Text('Capygatcha',
                style: TextStyle(fontFamily: 'Capriola', color: Colors.white),
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.comment),
                  tooltip: 'Account button',
                  onPressed: () {},
                ),
              ],
              backgroundColor: const Color(0xff8a6552),
        ), //AppBar
        body: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("home"),
            ]
        )
    ));
  }
}