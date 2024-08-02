class VehicleModel {
  final String? id;
  final String marca;
  final String modelo;
  final int autonomia;
  final int capacidadCarga;

  VehicleModel({
    this.id,
    required this.marca,
    required this.modelo,
    required this.autonomia,
    required this.capacidadCarga,
});

  factory VehicleModel.fromJson(Map<String, dynamic> json){
    return VehicleModel(
      id: json['_id'],
      marca: json['marca'],
      modelo: json['modelo'],
        autonomia: json['autonomia'],
      capacidadCarga: json['capacidadCarga']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      '_id':id,
      'marca':marca,
      'modelo':modelo,
      'autonomia':autonomia,
      'capacidadCarga':capacidadCarga
    };
  }
}