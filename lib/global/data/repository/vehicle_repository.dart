import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/vehicle_model.dart';  // Asegúrate de tener tu modelo de vehículo en esta ruta

class VehicleRepository {
  final String apiUrl;

  VehicleRepository({required this.apiUrl});

  Future<void> createVehicle(VehicleModel vehicle) async {
    final response = await http.post(
      Uri.parse('$apiUrl/vehicles'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(vehicle.toJson()..remove('id')),
    );

    if (response.statusCode != 201) {  // HTTP 201 Created
      throw Exception('Failed to create vehicle');
    }
  }
  Future<List<VehicleModel>> getAllVehicles() async {
    final response = await http.get(
      Uri.parse('$apiUrl/getvehicles/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Access-Control-Allow-Origin" : "*", // Required for CORS support to work
        "Access-Control-Allow-Credentials" : "true"
      },
    );
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<VehicleModel>.from(l.map((model) => VehicleModel.fromJson(model)));
    } else {
      throw Exception('Failed to load vehicles');
    }
  }

  Future<void> updateVehicle(VehicleModel vehicle) async {
    final response = await http.put(
      Uri.parse('$apiUrl/vehicles/$vehicle.id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(vehicle.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update vehicle');
    }
  }

  // Eliminar un vehículo por ID
  Future<void> deleteVehicle(String id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/vehicles/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete vehicle');
    }
  }
}
