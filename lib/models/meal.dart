class Meal {
  String? id;
  String? name;
  String? engName;
  String? image;
  String? video;
  String? category;
  String? description;
  //String? period;
  double? carb;
  double? calories;
  double? protein;
  double? fats;
  bool isSelected;
  List<String>? components;
  double serving = 0;

  Meal({this.id, this.name, this.category, this.image, this.description,
        this.fats, this.protein, this.calories, this.components, this.carb,
        this.video, this.isSelected = true, this.engName, this.serving = 0});
}