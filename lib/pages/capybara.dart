import 'package:flutter/widgets.dart';

class Capybara extends ChangeNotifier {
  late String _name;
  late DateTime _birthDate;
  late String _color;
  late int _hunger;
  late int _happiness;

  // Getters
  String get name => _name;
  DateTime get birthDate => _birthDate;
  String get color => _color;
  int? get hunger => _hunger;
  int? get happiness => _happiness;

  // Constructor
  Capybara({
    required String name,
    required String color,
    DateTime? birthDate,
    int hunger = 100,
    int happiness = 100,
  }) {
    _name = name;
    _color = color;
    _birthDate = birthDate ?? DateTime.now();
    _hunger = hunger;
    _happiness = happiness;
  }

  // Feed capybara
  void feed() {
    if (_hunger < 200) {
      _hunger += 10;
    }
    notifyListeners();
  }

  // Pet capybara
  void pet() {
    if (_happiness < 200) {
      _happiness += 10;
    }
    notifyListeners();
  }

  // Méthode pour afficher les détails du Capybara
  void displayInfo(){
    print('Name: $_name');
    print('Color: $_color');
    print('Date of birth: $_birthDate');
    print('Hunger: $_hunger');
    print('Happiness: $_happiness');
  }

}
