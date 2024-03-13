import 'dart:async';
import 'package:flutter/foundation.dart';

class Capybara extends ChangeNotifier {
  late String _name;
  late DateTime _birthDate;
  late String _color;
  late int _hunger;
  late int _happiness;
  late int _life;

  late Timer _hungerTimer;
  late Timer _happinessTimer;

  // Getters
  String get name => _name;
  DateTime get birthDate => _birthDate;
  String get color => _color;
  int? get hunger => _hunger;
  int? get happiness => _happiness;
  int? get life => _life;

  // Constructor
  Capybara({
    required String name,
    required String color,
    DateTime? birthDate,
    int hunger = 100,
    int happiness = 100,
    int life = 100,
  }) {
    _name = name;
    _color = color;
    _birthDate = birthDate ?? DateTime.now();
    _hunger = hunger;
    _happiness = happiness;
    _life = life;
    _startTimers();
  }

  // Feed capybara
  void feed() {
    if (_hunger < 100) {
      _hunger += 10;
      if(_hunger > 100){
        _hunger = 100;
      }
    }
    notifyListeners();
  }

  // Pet capybara
  void pet() {
    if (_happiness < 100) {
      _happiness += 10;
      if(_happiness > 100){
        _happiness = 100;
      }
    }
    notifyListeners();
  }

  // Méthode pour afficher les détails du Capybara
  void displayInfo() {
    print('Name: $_name');
    print('Color: $_color');
    print('Date of birth: $_birthDate');
    print('Hunger: $_hunger');
    print('Happiness: $_happiness');
  }

  // Méthode pour démarrer les timers de mise à jour
  void _startTimers() {
    _hungerTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (_hunger > 0) {
        _hunger -= 3;
      }
      if( _hunger < 0){
        _hunger = 0;
      }
      _updateLife();
      notifyListeners();
    });

    _happinessTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (_happiness > 0) {
        _happiness -= 2;
      }
      if( _happiness < 0){
        _happiness = 0;
      }
      _updateLife();
      notifyListeners();
    });
  }

  // Méthode pour mettre à jour l'état de vie du Capybara
  void _updateLife() {
    if (_happiness < 10 || _hunger < 10) {
      _life -= 2;
    } else if ((_happiness > 55 || _hunger > 70) && _life < 100) {
      _life += 1;
      if(_life > 100){
        _life = 100;
      }
    }

    if( _life < 0){
      _life = 0;
    }
    notifyListeners();
  }

  // Méthode pour arrêter les timers lors de la suppression de l'objet
  @override
  void dispose() {
    _hungerTimer.cancel();
    _happinessTimer.cancel();
    super.dispose();
  }
}
