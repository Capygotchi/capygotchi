import 'package:appwrite/appwrite.dart';
import 'package:capygotchi/shared/utils.dart';
import 'package:capygotchi/apis/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  signInWithProvider(String provider, BuildContext context) {
    try {
      context.read<AuthAPI>().signInWithProvider(provider: provider);
    } on AppwriteException catch (e) {
      Utils.showAlert(title: 'Login failed', text: e.message.toString(), context: context);
    }
  }

  signInWithMagicLink(String email, BuildContext context) {
    try {
      context.read<AuthAPI>().signInWithMagicLink(email: email);
      print('Magic link sent to $email');
    } on AppwriteException catch (e) {
      Utils.showAlert(title: 'Login failed', text: e.message.toString(), context: context);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capygotchi'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => signInWithMagicLink(emailController.text, context),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white),
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: () => signInWithProvider('discord', context),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white),
                child: const Text('Login with discord'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}