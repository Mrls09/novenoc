import 'dart:convert';
import 'package:novenoc/global/data/models/person_model.dart';
import 'package:http/http.dart' as http;

class PersonRepository {
  final String apiUrl;
  final String accessToken;

  PersonRepository({required this.apiUrl, required this.accessToken});

  Future<void> createPerson(Person person) async {
    final response = await http.post(
       Uri.parse('$apiUrl/persons'),
      headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(person.toJson()..remove('id')),
    );
    if (response.statusCode != 200){
      throw Exception('Failed to create person');
    }
  }
  Future<Person> getPerson(String id) async {
    final response = await http.get(
      Uri.parse('$apiUrl/persons/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if(response.statusCode == 200){
      return Person.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed');
    }
  }
  Future<List<Person>> getAllPerson() async {
    final response = await http.get(
      Uri.parse('$apiUrl/persons'),
      headers: <String , String> {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if(response.statusCode == 200){
      List<dynamic> body = jsonDecode(response.body);
      List<Person> persons = body.map((dynamic item) => Person.fromJson(item)).toList();
      return persons;
    }else {
      throw Exception('Failed to get all persons');
    }
  }
  Future<void> deletePerson(String id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/persons/$id'),
      headers: <String,String> {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if(response.statusCode != 200) {
      throw Exception('Failed to delete person');
    }
  }
  Future<void> updatePerson(Person person) async{
    final response = await http.put(
      Uri.parse('$apiUrl/persons'),
      headers: <String , String>{
        'Content-Type': 'applitacion/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(person.toJson()),
    );
    if(response.statusCode != 200){
      throw Exception('Failed to update person');
    }
  }
}