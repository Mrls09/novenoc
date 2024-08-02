import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novenoc/global/data/repository/vehicle_repository.dart';
import '../cubit/vehicle_cubit.dart';
import '../cubit/vehicle_state.dart';
import '../../data/models/vehicle_model.dart';

class VehicleListView extends StatelessWidget {
  const VehicleListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VehicleCubit(
        vehicleRepository: RepositoryProvider.of<VehicleRepository>(context),
      ),
      child: const VehicleListScreen(),
    );
  }
}

class VehicleListScreen extends StatelessWidget {
  const VehicleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vehicleCubit = BlocProvider.of<VehicleCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle List'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              vehicleCubit.fetchAllVehicles();
            },
            child: const Text('Fetch Vehicles'),
          ),
          Expanded(
            child: BlocBuilder<VehicleCubit, VehicleState>(
              builder: (context, state) {
                if (state is VehicleLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is VehicleSuccess) {
                  final vehicles = state.vehicles;
                  return DataTable(
                    columns: const [
                      DataColumn(label: Text('_ID')),
                      DataColumn(label: Text('Marca')),
                      DataColumn(label: Text('Modelo')),
                      DataColumn(label: Text('Autonomía')),
                      DataColumn(label: Text('Capacidad de Carga')),
                      DataColumn(label: Text('Acciones')),
                    ],
                    rows: vehicles.map((vehicle) {
                      return DataRow(cells: [
                        DataCell(Text(vehicle.id ?? 'N/A')),
                        DataCell(Text(vehicle.marca)),
                        DataCell(Text(vehicle.modelo)),
                        DataCell(Text(vehicle.autonomia.toString())),
                        DataCell(Text(vehicle.capacidadCarga.toString())),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _showVehicleForm(context, vehicle: vehicle);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  vehicleCubit.deleteVehicle(vehicle.id!);
                                },
                              ),
                            ],
                          ),
                        ),
                      ]);
                    }).toList(),
                  );
                } else if (state is VehicleError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return const Center(child: Text('Press the button to fetch vehicles'));
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _showVehicleForm(context);
            },
            child: const Text('Add Vehicle'),
          ),
        ],
      ),
    );
  }

  void _showVehicleForm(BuildContext context, {VehicleModel? vehicle}) {
    final _formKey = GlobalKey<FormState>();
    final _marcaController = TextEditingController(text: vehicle?.marca);
    final _modeloController = TextEditingController(text: vehicle?.modelo);
    final _autonomiaController = TextEditingController(text: vehicle?.autonomia.toString());
    final _capacidadCargaController = TextEditingController(text: vehicle?.capacidadCarga.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(vehicle == null ? 'Add Vehicle' : 'Edit Vehicle'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _marcaController,
                  decoration: const InputDecoration(labelText: 'Marca'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the marca';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _modeloController,
                  decoration: const InputDecoration(labelText: 'Modelo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the modelo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _autonomiaController,
                  decoration: const InputDecoration(labelText: 'Autonomía'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the autonomía';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _capacidadCargaController,
                  decoration: const InputDecoration(labelText: 'Capacidad de Carga'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the capacidad de carga';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final vehicleCubit = BlocProvider.of<VehicleCubit>(context);
                  final newVehicle = VehicleModel(
                    id: vehicle?.id,
                    marca: _marcaController.text,
                    modelo: _modeloController.text,
                    autonomia: int.parse(_autonomiaController.text),
                    capacidadCarga: int.parse(_capacidadCargaController.text),
                  );

                  if (vehicle == null) {
                    vehicleCubit.createVehicle(newVehicle);
                  } else {
                    vehicleCubit.updateVehicle(newVehicle);
                  }

                  Navigator.of(context).pop();
                }
              },
              child: Text(vehicle == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }
}
