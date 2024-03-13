import 'package:capygotchi/shared/constants/appwrite.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:capygotchi/shared/constants/project.dart';
import 'package:flutter/widgets.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
  unknown,
}

class AuthAPI extends ChangeNotifier {
  late Account _account;
  AuthStatus _status = AuthStatus.unknown;

  // Getter methods
  AuthStatus get status => _status;

  // Constructor
  AuthAPI ({required Account account}) {
    _account = account;
    _status = AuthStatus.unauthenticated;
  }

  // SignIn with provider
  Future<User> signInWithProvider({required String provider}) async {
    try {
      await _account.createOAuth2Session(provider: provider);
      final user = await _account.get();
      _status = AuthStatus.authenticated;
      return user;
    } finally {
      notifyListeners();
    }
  }

  // SignIn with magic link
  signInWithMagicLink({required String email}) async {
    try {
      await _account.createMagicURLSession(userId: ID.unique(), email: email, url: Constants.basePath == '' ? null : '${Constants.basePath}/login-magic');
    } finally {
      notifyListeners();
    }
  }

  // Confirm magic link
  Future<User> confirmMagicLink({required String userId, required String secret}) async {
    try {
      await _account.updateMagicURLSession(userId: userId, secret: secret);
      final user = await _account.get();
      _status = AuthStatus.authenticated;
      return user;
    } finally {
      notifyListeners();
    }
  }

  //TODO
  // SignOut
  signOut() async {
    try {
      await _account.deleteSession(sessionId: 'current');
      _status = AuthStatus.unauthenticated;
    } finally {
      notifyListeners();
    }
  }

}