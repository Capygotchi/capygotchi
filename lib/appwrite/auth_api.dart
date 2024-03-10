import 'package:capygotchi/constants/app_write.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/widgets.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
  unknown,
}

class AuthAPI extends ChangeNotifier {
  Client client = Client();
  late final Account account;

  late User _currentUser;
  AuthStatus _status = AuthStatus.unknown;

  // Getter methods
  User get currentUser => _currentUser;
  AuthStatus get status => _status;
  String? get userId => _currentUser?.$id;
  String? get userEmail => _currentUser?.email;
  String? get userName => _currentUser?.name;

  // Constructor
  AuthAPI() {
    initClient();
    loadUser();
  }

  // Initialize the client
  initClient() {
    client
        .setEndpoint(appWriteEndpoint) // Your API Endpoint
        .setProject(appWriteProjectId) // Your project ID
        .setSelfSigned(status: true); // For self signed certificates, only use for development
    account = Account(client);
  }

  // Load user
  loadUser() async {
    try {
      _currentUser = await account.get();
      _status = AuthStatus.authenticated;
    } catch (e) {
      _status = AuthStatus.unauthenticated;
    } finally {
      notifyListeners();
    }
  }
  
  // SignIn with magic link
  signInWithMagicLink({required String email}) async {
    try {
      final session = await account.createMagicURLToken(userId: ID.unique(), email: email);
      _currentUser = await account.get();
      _status = AuthStatus.authenticated;
      return session;
    } finally {
      notifyListeners();
    }
  }

  // SignIn with provider
  signInWithProvider({required OAuthProvider provider}) async {
    try {
      final session = await account.createOAuth2Session(provider: provider);
      _currentUser = await account.get();
      _status = AuthStatus.authenticated;
      return session;
    } finally {
      notifyListeners();
    }
  }

  // SignOut
  signOut() async {
    try {
      await account.deleteSession(sessionId: 'current');
      _status = AuthStatus.unauthenticated;
    } finally {
      notifyListeners();
    }
  }

  // Update user name
  updateUserName({required String name}) async {
    try {
      await account.updateName(name: name);
      _currentUser = await account.get();
    } finally {
      notifyListeners();
    }
  }

}