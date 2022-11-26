import 'dart:convert';

class Plans {
  String description;
  String name;
  List<PlanDuration> planDuration;
  Plans({
    required this.description,
    required this.name,
    required this.planDuration,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'name': name,
      'planDuration': planDuration.map((x) => x.toMap()).toList(),
    };
  }

  factory Plans.fromMap(Map<String, dynamic> map) {
    return Plans(
      description: map['description'] ?? '',
      name: map['name'] ?? '',
      planDuration: List<PlanDuration>.from(
          map['planDuration']?.map((x) => PlanDuration.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());
}

class PlanDuration {
  int daysNumber;
  String id;
  String name;
  int price;
  PlanDuration({
    required this.daysNumber,
    required this.id,
    required this.name,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'daysNumber': daysNumber,
      'id': id,
      'name': name,
      'price': price,
    };
  }

  factory PlanDuration.fromMap(Map<String, dynamic> map) {
    return PlanDuration(
      daysNumber: map['daysNumber']?.toInt() ?? 0,
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanDuration.fromJson(String source) =>
      PlanDuration.fromMap(json.decode(source));
}
