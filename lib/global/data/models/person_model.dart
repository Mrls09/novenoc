import 'gender_model.dart';

class Person {
  final String? id;
  final String name;
  final String lastname;
  final GenderModel gender;

  Person({
    this.id,
    required this.name,
    required this.lastname,
    required this.gender,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      lastname: json['lastname'],
      gender: GenderModel.fromJson(json['gender']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastname':lastname,
      'gender': gender.toJson()
    };
  }
}
