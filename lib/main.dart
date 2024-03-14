import 'package:capygotchi/app_router.dart';
import 'package:capygotchi/core/domain/entities/capybara.dart';
import 'package:capygotchi/core/domain/entities/user.dart';
import 'package:capygotchi/core/infrastructure/auth_api.dart';
import 'package:capygotchi/core/infrastructure/database_api.dart';
import 'package:capygotchi/shared/utils.dart';
import 'package:capygotchi/features/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthAPI>(
          create: (context) => AuthAPI(),
        ),
        ChangeNotifierProxyProvider<AuthAPI, User?>(
          create: (_) => null,
          update: (_, auth, previousUser) {
            if (auth.status == AuthStatus.authenticated) {
              return User(
                account: auth.account,
                functions: auth.functions,
                user: auth.currentUser,
              );
            }
            return null;
          },
        ),
        ChangeNotifierProxyProvider<AuthAPI, DatabaseAPI?>(
            create: (_) => null,
            update: (_, auth, previousDatabase) {
              if (auth.status == AuthStatus.authenticated) {
                return DatabaseAPI(databases: auth.databases);
              }
              return null;
            }
        ),
        ChangeNotifierProvider<Capybara>(
            create: (_) => Capybara(name: 'Roger', color: CapyColor.brown, documentId: '')
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authStatus = context.watch<AuthAPI>().status;
    final userName = context.watch<User?>()?.userName ?? 'null';
    Utils.logDebug(message: 'Auth status: $authStatus');
    Utils.logDebug(message: 'User name: $userName');

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
