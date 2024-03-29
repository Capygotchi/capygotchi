import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum CapyColor {
  brown,
  brownWithHat,
  rainbow,
  blue,
  black,
  white,
  outline,
  vomi,
}

class Capybara extends ChangeNotifier {
  late String _name;
  late DateTime _birthDate;
  late CapyColor _color;
  late int _hunger;
  late int _happiness;
  late int _life;
  late String _documentId;
  late bool _alive;

  late Timer _hungerTimer;
  late Timer _happinessTimer;

  // Getters
  String get name => _name;
  DateTime get birthDate => _birthDate;
  CapyColor get color => _color;
  int? get hunger => _hunger;
  int? get happiness => _happiness;
  int? get life => _life;
  String get documentId => _documentId;
  bool? get alive => _alive;

  // Constructor
  Capybara({
    required String name,
    required CapyColor color,
    DateTime? birthDate,
    int hunger = 100,
    int happiness = 100,
    int life = 100,
    required String documentId,
    bool alive = true
  }) {
    _name = name;
    _color = color;
    _birthDate = birthDate ?? DateTime.now();
    _hunger = hunger;
    _happiness = happiness;
    _life = life;
    _documentId = documentId;
    _alive = alive;
    _startTimers();
  }

  // Feed capybara
  void feed() {
    if (_hunger < 100 && _alive) {
      _hunger += 10;
      if (_hunger >= 100) {
        _hunger = 100;
        _happiness -= 20;
      }
    }
    else {
      if(_alive){
        _happiness -= 20;
        if(_happiness < 0){
          _happiness = 0;
        }
      }
    }
    notifyListeners();
  }

  // Pet capybara
  void pet() {
    if (_happiness < 100 && _alive) {
      _happiness += 10;
      if (_happiness >= 100) {
        _happiness = 100;
      }
    }
    else {
      if(_alive){
        _happiness = 80;
      }
    }
    notifyListeners();
  }

  void changeColor(CapyColor newColor) {
    _color = newColor;
    notifyListeners();
  }

  // Méthode pour démarrer les timers de mise à jour
  void _startTimers() {
    _hungerTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (_hunger > 0) {
        _hunger -= 3;
      }
      if (_hunger < 0) {
        _hunger = 0;
      }
      _updateLife();
      notifyListeners();
    });

    _happinessTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (_happiness > 0) {
        _happiness -= 2;
      }
      if (_happiness < 0) {
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
      if (_life > 100) {
        _life = 100;
      }
    }

    if (_life < 0) {
      _life = 0;
    }
    _updateAlive();
    notifyListeners();
  }

  void _updateAlive() {
    if (life == 0 && _alive && !false) {
      /*todo: add premium*/
      _alive = false;
      _hungerTimer.cancel();
      _happinessTimer.cancel();
      _happiness = 0;


      //TODO: remove context from class alert should be in the page controller
      // Utils.showAlertOK(
      //     context: _context,
      //     title: "$_name is dead",
      //     text: "your $_name is dead!",
      //     okBtnText: 'OK');
    }
    notifyListeners();
  }

  updateName({required String name}) async {
    _name = name;
    notifyListeners();
  }

  // Méthode pour arrêter les timers lors de la suppression de l'objet
  @override
  void dispose() {
    _hungerTimer.cancel();
    _happinessTimer.cancel();
    super.dispose();
  }

  void updateCapybara(Capybara newCapybara) {
    _name = newCapybara.name;
    _color = newCapybara.color;
    _documentId = newCapybara.documentId;
    _birthDate = newCapybara.birthDate;
    _hunger = newCapybara.hunger!;
    _happiness = newCapybara.happiness!;
    _life = newCapybara.life!;
    _alive = newCapybara._alive;
    notifyListeners();
  }
}
