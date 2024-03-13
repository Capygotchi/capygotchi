import 'package:capygotchi/core/domain/entities/capybara.dart';
import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  late String _username;
  late String _userId;
  late bool _isPremium;
  late DateTime? _premiumPurchaseDate;

  String get username => _username;
  String get userId => _userId;
  bool get isPremium => _isPremium;
  DateTime? get premiumPurchaseDate => _premiumPurchaseDate;

  User({
    required String username,
    required String userId,
    required bool isPremium,
    DateTime? premiumPurchaseDate,
  }) {
    _username = username;
    _userId = userId;
    _isPremium = isPremium;
    _premiumPurchaseDate = premiumPurchaseDate;
  }

  void displayInfo() {
    print('Username: $username');
    print('User id: $userId');
    print('Premium: $isPremium');
    print('Premium purchase date: $premiumPurchaseDate');
  }
}