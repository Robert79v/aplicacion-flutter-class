class Starship {
  final String name;
  final String model;
  final String manufacturer;
  final String speed;
  final String crew;
  final String mainImage;
  final List<String> thumbnails;

  Starship({
    required this.name,
    required this.model,
    required this.manufacturer,
    required this.speed,
    required this.crew,
    required this.mainImage,
    required this.thumbnails,
  });

  // Para usarlo con JSON si en el futuro quieres API
  factory Starship.fromJson(Map<String, dynamic> json) {
    return Starship(
      name: json['name'] ?? '',
      model: json['model'] ?? '',
      manufacturer: json['manufacturer'] ?? '',
      speed: json['speed'] ?? '',
      crew: json['crew'] ?? '',
      mainImage: json['mainImage'] ?? '',
      thumbnails: List<String>.from(json['thumbnails'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'model': model,
      'manufacturer': manufacturer,
      'speed': speed,
      'crew': crew,
      'mainImage': mainImage,
      'thumbnails': thumbnails,
    };
  }
}
