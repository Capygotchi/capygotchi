import 'package:capygotchi/appwrite/auth_api.dart';
import 'package:capygotchi/pages/login.dart';
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
          ? const Scaffold(
            body: Center(child: Text('Welcome!')),
          )
          : const LoginPage(),
    );
  }
}
