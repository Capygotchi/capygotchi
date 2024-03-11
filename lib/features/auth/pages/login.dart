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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Capygatcha",
                style: TextStyle(fontSize: 50, fontFamily: 'Raleway')),
            Text(loggedInUser != null
                ? 'Logged in as ${loggedInUser!.name}'
                : 'Not logged in'),
            const SizedBox(height: 20.0),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                )),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    login(emailController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffca2e55),
                  ),
                  child: const Text('Login',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    logout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffca2e55),
                  ),
                  child: const Text('Logout',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child:
              ElevatedButton(
                  onPressed: () {
                    googleLogin();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffca2e55),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(height:30,
                          child: Image(image: AssetImage('assets/discord.png'),
                              fit: BoxFit.fitHeight
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        const Text('Login with Discord',
                            style: TextStyle(color: Colors.white)),
                      ])
              ),
            ),

          ],
        ),
      ),
    );
  }
}
