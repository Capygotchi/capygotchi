import 'package:capygotchi/features/auth/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Client client = Client()
      .setEndpoint("https://cloud.appwrite.io/v1")
      .setProject("65eb3c30edc0ee1934e6")
      .setSelfSigned(status: true); // For self signed certificates, only use for development
  Account account = Account(client);

  runApp(MyApp(account: account));
}

class MyApp extends StatelessWidget {
  final Account account;
  const MyApp({super.key, required this.account});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(account: account)
    );
  }
}
