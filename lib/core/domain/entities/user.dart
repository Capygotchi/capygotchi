import 'package:capygotchi/shared/constants/appwrite.dart';
import 'package:capygotchi/shared/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

class User extends ChangeNotifier {
  late Account _account;
  late Functions _functions;
  late models.User _user;
  late String _userName;
  late String _userId;
  late bool _isPremium;
  late DateTime? _premiumPurchaseDate;

  // Getters
  String get userName => _userName;
  String get userId => _userId;
  bool get isPremium => _isPremium;
  DateTime? get premiumPurchaseDate => _premiumPurchaseDate;

  // Constructor
  User({
    required Account account,
    required Functions functions,
    required models.User user,
  }) {
    _account = account;
    _functions = functions;
    _user = user;
    loadUser(user: user);
    checkPremium();
  }

  void loadUser ({required models.User user}) {
    try {
      _userId = _user.$id;
      _userName = _user.name;
      _isPremium = _user.labels.contains('premium');
    } finally {
      notifyListeners();
    }
  }

  void refreshUser() async {
    _user = await _account.get();
    loadUser(user: _user);
  }

  // Update user name
  updateUserName({required String name}) async {
    try {
      await _account.updateName(name: name);
      refreshUser();
    } finally {
      notifyListeners();
    }
  }

  //Check premium
  checkPremium() async {
    try {
      await _functions.createExecution(
        functionId: AppWriteConstants.functionId,
        path: '/?userId=$_userId',
        method: 'GET',
      );
    } catch (e) {
      return null;
    } finally {
      refreshUser();
      notifyListeners();
    }
  }

  Future<bool> addPremium() async {
    try {
      await _functions.createExecution(
        functionId: AppWriteConstants.functionId,
        path: '/?userId=$_userId',
        method: 'PATCH',
      );
    } catch (e) {
      return false;
    }
    return true;
  }

  void displayInfo() {
    Utils.logDebug(message: 'Username: $_userName');
    Utils.logDebug(message: 'User id: $_userId');
    Utils.logDebug(message: 'Premium: $_isPremium');
    Utils.logDebug(message: 'Premium purchase date: $_premiumPurchaseDate');
  }
}

// utilisation de user après avoir disposé