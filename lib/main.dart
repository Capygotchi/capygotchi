import 'package:capygotchi/pages/home.dart';
import 'package:capygotchi/pages/login.dart';
import 'package:capygotchi/apis/auth_api.dart';
import 'package:capygotchi/pages/login_magic.dart';
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

    final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomePage(),
            redirect: (_, GoRouterState state) {
              final insideLoginPath = state.fullPath.toString().startsWith('/login');
              if(authStatus == AuthStatus.unauthenticated && !insideLoginPath) {
                print('home: unauthenticated or not in loginPath redirecting to /login');
                return '/';
              } else {
                return null;
              }
            },
            routes: [
              GoRoute(
                path: 'login',
                builder: (context, state) => const LoginPage(),
                redirect: (_, __) {
                  if (authStatus == AuthStatus.authenticated) {
                    print('login: already authenticated, redirecting to /');
                    return '/';
                  } else {
                    return null;
                  }
                },
              ),
              GoRoute(
                path: 'login-magic',
                builder: (context, state) {
                  // use state.queryParams to get search query from query parameter
                  final userId = state.uri.queryParameters['userId']; // may be null
                  final secret = state.uri.queryParameters['secret']; // may be null
                  return LoginMagicPage(userId: userId ?? '', secret: secret ?? '');
                },
                redirect: (_, GoRouterState state) {
                  if (authStatus == AuthStatus.authenticated) {
                    print('login-magic: already authenticated, redirecting to /');
                    return '/';
                  } else if (state.uri.queryParameters['userId'] == null || state.uri.queryParameters['secret'] == null) {
                    print('login-magic: userId or secret is null, redirecting to /login');
                    return '/';
                  } else {
                    return null;
                  }
                },
              ),
            ]
          ),
        ]
    );

    return MaterialApp.router(
      title: 'Capygotchi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
