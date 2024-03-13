import 'package:capygotchi/app_router.dart';
import 'package:capygotchi/core/domain/entities/user.dart';
import 'package:capygotchi/core/infrastructure/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AuthAPI(),
    child: ChangeNotifierProvider(
      create: (context) {
        if(context.read<AuthAPI>().status == AuthStatus.authenticated) {
          return User(account: context.read<AuthAPI>().account, user: context.read<AuthAPI>().currentUser);
        }
        return null;
      },
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authStatus = context.watch<AuthAPI>().status;
    final userName = authStatus == AuthStatus.authenticated ? context.watch<User>().userName : 'null';
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
