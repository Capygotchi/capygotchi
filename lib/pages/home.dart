import 'package:appwrite/appwrite.dart';
import 'package:capygotchi/apis/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void signOut(BuildContext context) {
    try {
      context.read<AuthAPI>().signOut();
      context.go('/login');
    } on AppwriteException catch (e) {
      return;
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
            onPressed: () => signOut(context),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
