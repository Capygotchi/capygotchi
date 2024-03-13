import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:http/http.dart' as http;

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
    required models.User user,
  }) {
    _account = account;
    _user = user;
    loadUser(user: user);
  }

  void loadUser ({required models.User user}) {
    try {
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

  //Check premium
  void checkPremium() async{
    var user = await _account.get();
    var url = Uri.https('65f0610c25175c6f2b79.appwrite.global', '/',{"userId":user.$id});
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    if(data["premium"]) {
      _isPremium=true;
    }else{
      _isPremium=false;
    }
    notifyListeners();
  }

  void displayInfo() {
    print('Username: $_userName');
    print('User id: $_userId');
    print('Premium: $_isPremium');
    print('Premium purchase date: $_premiumPurchaseDate');
  }
}