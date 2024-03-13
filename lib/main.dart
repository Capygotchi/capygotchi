import 'package:capygotchi/app_router.dart';
import 'package:capygotchi/core/domain/entities/user.dart';
import 'package:capygotchi/core/infrastructure/appwrite_client.dart';
import 'package:capygotchi/core/infrastructure/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final client = AppWriteClient().client;

  print('main: ${client.endPoint}');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthAPI(client: client)),
      ChangeNotifierProvider(create: (context) => User(account: context.watch<AuthAPI>().account)),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authStatus = context.watch<AuthAPI>().status;
    final userName = context.watch<User>().userName;
    print('Auth status: $authStatus');
    print('Auth status: $authStatus');

    final router = AppRouter.createRouter(context, context.read<AuthAPI>());

    return MaterialApp.router(
      title: 'Capygotchi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Capriola',
      ),
      routerConfig: router,
    );
  }
}
