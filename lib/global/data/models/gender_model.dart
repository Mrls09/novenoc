class GenderModel {
  final String? id;
  final String name;

  GenderModel({
    required this.id,
    required this.name,
  });

  factory GenderModel.fromJson(Map<String, dynamic> json) {
    return GenderModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
