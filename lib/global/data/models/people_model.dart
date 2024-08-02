class PeopleModel{
  final String? id;
  final String name;
  final String gender;
  final String email;
  final String phone;

  PeopleModel({this.id, required this.name, required this.gender, required this.email, required this.phone});

  factory PeopleModel.fromJson(Map<String, dynamic> json){
    return PeopleModel(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      email: json['email'],
      phone: json['phone']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id":id,
      "name":name,
      "gender":gender,
      "email": email,
      "phone": phone
    };
  }
}