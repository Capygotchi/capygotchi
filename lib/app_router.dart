import 'package:capygotchi/features/account/view/account_page.dart';
import 'package:capygotchi/features/home/view/home_page.dart';
import 'package:capygotchi/features/login/view/login.dart';
import 'package:capygotchi/core/infrastructure/auth_api.dart';
import 'package:capygotchi/features/login/view/login_magic.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter createRouter(BuildContext context, AuthAPI authAPI) {
    final authStatus = authAPI.status;
    return GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
              path: '/',
              builder: (context, state) => const HomePage(),
              redirect: (BuildContext context, GoRouterState state) {
                final insideLoginPath = state.fullPath.toString().startsWith('/login');
                if(authStatus == AuthStatus.unauthenticated && !insideLoginPath) {
                  print('home: unauthenticated or not in loginPath redirecting to /login');
                  return '/login';
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
                GoRoute(
                  path: 'account',
                  builder: (context, state) => const AccountPage(),
                ),
              ]
          ),
        ]
    );
  }
}