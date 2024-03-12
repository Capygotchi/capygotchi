import 'package:capygotchi/app_router.dart';
import 'package:capygotchi/features/account/view/account_page.dart';
import 'package:capygotchi/features/home/view/home_page.dart';
import 'package:capygotchi/features/login/view/login.dart';
import 'package:capygotchi/core/infrastructure/auth_api.dart';
import 'package:capygotchi/features/login/view/login_magic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

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
