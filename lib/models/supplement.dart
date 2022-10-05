import 'dart:convert';

class Supplement {
  String? id;
  String? imagePath;
  double? carb = 0;
  double? protein = 0;
  double? fats = 0;
  double? calories = 0;
  String? name;
  Supplement({
    this.carb,
    this.fats,
    this.calories,
    this.name,
    this.id,
    this.imagePath,
    this.protein,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'carb': carb,
      'protein': protein,
      'fats': fats,
      'calories': calories,
      'name': name,
    };
  }

  factory Supplement.fromMap(Map<String, dynamic> map) {
    return Supplement(
      id: map['id'],
      imagePath: map['imagePath'],
      carb: map['carb']?.toDouble(),
      protein: map['protein']?.toDouble(),
      fats: map['fats']?.toDouble(),
      calories: map['calories']?.toDouble(),
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Supplement.fromJson(String source) =>
      Supplement.fromMap(json.decode(source));
}
