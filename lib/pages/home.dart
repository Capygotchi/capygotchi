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
    } on AppwriteException catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Welcome!'),
          ElevatedButton(
            onPressed: () => signOut(),
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white),
            child: const Text('logout'),
          ),
        ],
      ),
    );
  }
}
