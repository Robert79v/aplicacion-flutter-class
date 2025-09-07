class TroopModel {
  final String name;
  final String image;
  final double shield, health, attack;

  TroopModel({
    required this.name,
    required this.image,
    required this.shield,
    required this.health,
    required this.attack,
  });
}

final List<TroopModel> troop = [
  TroopModel(
    name: 'Stormtrooper',
    image: 'assets/stormtrooper.png',
    shield: 20.0,
    health: 50.0,
    attack: 65.0,
  ),
  TroopModel(
    name: 'Darth Vader',
    image: 'assets/darth_vader.png',
    shield: 40.0,
    health: 90.0,
    attack: 85.0,
  ),
  TroopModel(
    name: 'Baby Yoda',
    image: 'assets/baby_yoda.png',
    shield: 30.0,
    health: 100.0,
    attack: 80.0,
  ),
];