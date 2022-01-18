class Meal {
  String? id;
  String? name;
  String? engName;
  String? image;
  String? video;
  String? category;
  String? description;
  String? period;
  int? carb;
  int? calories;
  int? protein;
  int? fats;
  bool isSelected;
  List<String>? components;
  bool measurable = true;

  Meal({this.id, this.name, this.category, this.image, this.period, this.description,
        this.fats, this.protein, this.calories, this.components, this.carb,
        this.video, this.isSelected = true, this.engName});
}