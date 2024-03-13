import 'package:appwrite/appwrite.dart';
import 'package:capygotchi/core/domain/entities/user.dart';
import 'package:capygotchi/shared/utils.dart';
import 'package:capygotchi/core/infrastructure/auth_api.dart';
import 'package:capygotchi/shared/widgets/capy_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  signInWithProvider(String provider) {
    try {
      context.read<AuthAPI>().signInWithProvider(provider: provider);
    } on AppwriteException catch (e) {
      Utils.showAlertOK(title: 'Login failed', text: e.message.toString(), context: context, okBtnText: "Ok");
    }
  }

  signInWithMagicLink(String email) {
    try {
      if(email.isEmpty) return;
      context.read<AuthAPI>().signInWithMagicLink(email: email);
      print('Magic link sent to $email');
    } on AppwriteException catch (e) {
      Utils.showAlertOK(title: 'Login failed', text: e.message.toString(), context: context, okBtnText: "Ok");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4E6E4),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Capygotchi",
              style: TextStyle(fontSize: 50)),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 80),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              )),
          const SizedBox(height: 20),
          CapyButton(
            onPressed: () => signInWithMagicLink(emailController.text),
            label: 'Login with email',
            backgroundColor: const Color(0xffca2e55),
          ),
         const SizedBox(height: 20),
          CapyButton(
            onPressed: () => signInWithProvider('discord'),
            icon: const AssetImage('assets/discord.png'),
            label: 'Login with Discord',
            backgroundColor: const Color(0xffca2e55),
          ),
        ],
      ),
    );
  }
}
