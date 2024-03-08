import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;

class LoginPage extends StatefulWidget {
  final Account account;
  const LoginPage({super.key, required this.account});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  models.User? loggedInUser;
  final TextEditingController emailController = TextEditingController();

  Future<void> login(String email) async {
    //TODO: Implement magic link login
  }

  Future<void> googleLogin() async {
    await widget.account.createOAuth2Session(provider: OAuthProvider.google);

    final user = await widget.account.get();
    setState(() {
      loggedInUser = user;
    });
  }

  Future<void> logout() async {
    await widget.account.deleteSession(sessionId: 'current');
    setState(() {
      loggedInUser = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(loggedInUser != null
                ? 'Logged in as ${loggedInUser!.name}'
                : 'Not logged in'),
            const SizedBox(height: 16.0),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    login(emailController.text);
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    googleLogin();
                  },
                  child: const Text('Login with google'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    logout();
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
