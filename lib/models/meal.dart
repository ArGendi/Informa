class Meal {
  String? id;
  String? name;
  String? image;
  String? video;
  String? category;
  String? description;
  String? period;
  int? carbohydrates;
  int? calories;
  int? protein;
  int? fats;
  bool isSelected;
  List<String>? components;

  Meal({this.id, this.name, this.category, this.image, this.period, this.description,
        this.fats, this.protein, this.calories, this.components, this.carbohydrates,
        this.video, this.isSelected = true});
}