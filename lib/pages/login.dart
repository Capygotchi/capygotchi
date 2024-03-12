import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:capygotchi/apis/auth_api.dart';
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
      showAlert(title: 'Login failed', text: e.message.toString());
    }
  }

  signInWithMagicLink(String email) {
    try {
      context.read<AuthAPI>().signInWithMagicLink(email: email);
    } on AppwriteException catch (e) {
      showAlert(title: 'Login failed', text: e.message.toString());
    }
  }

  showAlert({required String title, required String text}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4E6E4),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Capygatcha",
              style: TextStyle(fontSize: 50, fontFamily: 'Capriola')),
          const SizedBox(height: 25.0),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 80),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              )),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () => signInWithMagicLink(emailController.text),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffca2e55),
            ),
            child: const Text('Login with email',
            style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120),
            child: ElevatedButton(
                onPressed: () => signInWithProvider('discord'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffca2e55),
                ),
                child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                        child: Image(
                            image: AssetImage('assets/discord.png'),
                            fit: BoxFit.fitHeight),
                      ),
                      SizedBox(width: 5.0),
                      Text('Login with Discord',
                          style: TextStyle(color: Colors.white)),
                    ])),
          ),
        ],
      ),
    );
  }
}
