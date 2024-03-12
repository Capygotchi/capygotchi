import 'package:flutter/material.dart';
import 'package:capygotchi/apis/auth_api.dart';
import 'package:provider/provider.dart';

class LoginMagicPage extends StatefulWidget {
  final String userId;
  final String secret;
  const LoginMagicPage({super.key, required this.userId, required this.secret});

  @override
  State<LoginMagicPage> createState() => _LoginMagicPageState();
}

class _LoginMagicPageState extends State<LoginMagicPage> {
  @override
  void initState() {
    super.initState();
    confirmLogin();
  }

  confirmLogin() {
    print('confirmLogin: Confirming login for user: ${widget.userId} with secret: ${widget.secret}');
    context.read<AuthAPI>().confirmMagicLink(userId: widget.userId, secret: widget.secret);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Magic Link callback'),
            ElevatedButton(
              onPressed: confirmLogin,
              child: const Text('Confirm Login'),
            ),
          ],
        ),
      ),
    );
  }
}
