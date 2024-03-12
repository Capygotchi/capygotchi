class Capybara {
  String name;
  DateTime birthDate;
  String color;
  int hunger = 100;
  int happiness = 100;

  // Constructeur
  Capybara({
    required this.name,
    required this.color,
    required this.birthDate, // Ajoutez le paramètre dateOfBirth
    required this.hunger,
    required this.happiness,
  });
  // Méthode pour afficher les détails du Capybara
  void displayInfo(){
    print('Name: $name');
    print('Color: $color');
    print('Date of birth: $birthDate');
    print('Hunger: $hunger');
    print('Happiness: $happiness');
  }

// Ajoutez d'autres méthodes ou attributs au besoin
}
