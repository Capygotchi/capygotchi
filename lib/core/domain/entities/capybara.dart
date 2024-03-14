import 'dart:async';
import 'package:capygotchi/core/infrastructure/database_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:capygotchi/shared/utils.dart';

enum CapyColor {
  brown,
  brownWithHat,
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
  late DatabaseAPI database;

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
    required String documentId
  }) {
    _name = name;
    _color = CapyColor.brown;
    _birthDate = birthDate ?? DateTime.now();
    _hunger = hunger;
    _happiness = happiness;
    _life = life;
    _documentId = documentId;
    _alive = true;
    _startTimers();
  }

  // Feed capybara
  void feed() {
    if (_hunger < 100) {
      _hunger += 10;
      if (_hunger >= 100) {
        _hunger = 100;
        _happiness -= 20;
      }
    }
    else {
      _happiness -= 20;
      if(_happiness < 0){
        _happiness = 0;
      }
    }
    notifyListeners();
  }

  // Pet capybara
  void pet() {
    if (_happiness < 100) {
      _happiness += 10;
      if (_happiness >= 100) {
        _happiness = 100;
      }
    }
    else {
      _happiness = 80;
    }
    notifyListeners();
  }

  // Méthode pour afficher les détails du Capybara
  void displayInfo() {
    Utils.logDebug(message: 'Name: $_name');
    Utils.logDebug(message: 'Color: $_color');
    Utils.logDebug(message: 'Date of birth: $_birthDate');
    Utils.logDebug(message: 'Hunger: $_hunger');
    Utils.logDebug(message: 'Happiness: $_happiness');
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
    database.updateMonster(capybara: Capybara(
      name: _name,
      color: _color,
      documentId: _documentId,
      birthDate: _birthDate,
      hunger: _hunger,
      happiness: _happiness,
      life: _life
    ), userId: '');
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

      _name += " is dead";
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

  void updateCapybara(Capybara newCapybara) {
    _name = newCapybara.name;
    _color = newCapybara.color;
    _documentId = newCapybara.documentId;
    _birthDate = newCapybara.birthDate;
    _hunger = newCapybara.hunger!;
    _happiness = newCapybara.happiness!;
    _life = newCapybara.life!;
    notifyListeners();
  }
}
