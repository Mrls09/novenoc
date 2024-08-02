import 'package:bloc/bloc.dart';
import '../../data/models/vehicle_model.dart';
import '../../data/repository/vehicle_repository.dart';
import 'vehicle_state.dart';

class VehicleCubit extends Cubit<VehicleState> {
  final VehicleRepository vehicleRepository;

  VehicleCubit({required this.vehicleRepository}) : super(VehicleInitial());

  Future<void> createVehicle(VehicleModel vehicle) async {
    try {
      emit(VehicleLoading());
      await vehicleRepository.createVehicle(vehicle);
      final vehicles = await vehicleRepository.getAllVehicles();
      emit(VehicleSuccess(vehicles: vehicles));
    } catch (e) {
      emit(VehicleError(message: e.toString()));
    }
  }
  Future<void> updateVehicle(VehicleModel vehicle) async {
    try {
      emit(VehicleLoading());
      await vehicleRepository.updateVehicle(vehicle);
      final vehicles = await vehicleRepository.getAllVehicles();
      emit(VehicleSuccess(vehicles: vehicles));
    } catch (e) {
      emit(VehicleError(message: e.toString()));
    }
  }

  Future<void> deleteVehicle(String id) async {
    try {
      emit(VehicleLoading());
      await vehicleRepository.deleteVehicle(id);
      final vehicles = await vehicleRepository.getAllVehicles();
      emit(VehicleSuccess(vehicles: vehicles));
    } catch (e) {
      emit(VehicleError(message: e.toString()));
    }
  }

  Future<void> fetchAllVehicles() async {
    try {
      emit(VehicleLoading());
      final vehicles = await vehicleRepository.getAllVehicles();
      emit(VehicleSuccess(vehicles: vehicles));
    } catch (e) {
      emit(VehicleError(message: e.toString()));
    }
  }
}
