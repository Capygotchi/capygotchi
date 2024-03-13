import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  late Account _account;
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
  }) {
    _account = account;
    loadUser();
  }

  void loadUser () async {
    try {
      _user = await _account.get();
      _userId = _user.$id;
      _userName = _user.name;
      _isPremium = _user.labels.contains('premium');
      //TODO _premiumPurchaseDate
    } finally {
      notifyListeners();
    }
  }

  // Update user name
  updateUserName({required String name}) async {
    try {
      await _account.updateName(name: name);
      _user = await _account.get();
    } finally {
      notifyListeners();
    }
  }

  void displayInfo() {
    print('Username: $_userName');
    print('User id: $_userId');
    print('Premium: $_isPremium');
    print('Premium purchase date: $_premiumPurchaseDate');
  }
}