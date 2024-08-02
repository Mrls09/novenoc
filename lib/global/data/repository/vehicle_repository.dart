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
      body: jsonEncode(vehicle.toJson()..remove('_id')),  // Elimina '_id' antes de enviar
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final createdVehicleId = responseBody['id'];
      print('Vehicle created with id: $createdVehicleId');
    } else {
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
    final uri = Uri.parse('$apiUrl/vehicles/${vehicle.id}');
    final body = jsonEncode({
      'marca': vehicle.marca,
      'modelo': vehicle.modelo,
      'autonomia': vehicle.autonomia,
      'capacidadCarga': vehicle.capacidadCarga,
    });

    print('PUT Request URL: $uri');
    print('PUT Request Body: $body');

    final response = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

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
