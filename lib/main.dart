import 'package:capygotchi/pages/home.dart';
import 'package:capygotchi/pages/login.dart';
import 'package:capygotchi/apis/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AuthAPI(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authStatus = context.watch<AuthAPI>().status;
    final userName = authStatus == AuthStatus.authenticated
        ? context.watch<AuthAPI>().userName
        : null;

    print('Auth status: $authStatus');
    print('User name: $userName');

    return MaterialApp(
        title: 'Capygotchi',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: authStatus == AuthStatus.unknown
            ? const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              )
            : authStatus == AuthStatus.authenticated
                ? const HomePage()
                //: const LoginPage(),
                : const HomePage());
  }
}
