import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novenoc/global/data/repository/vehicle_repository.dart';
import 'package:novenoc/global/helpers/cubit/vehicle_cubit.dart';
import 'package:novenoc/global/helpers/screens/get_all_vehicles_screen.dart';


void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => VehicleRepository(apiUrl: 'https://5ksg4zuhj6.execute-api.us-east-1.amazonaws.com/Prod')),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => VehicleCubit(
              vehicleRepository: RepositoryProvider.of<VehicleRepository>(context),
            ),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: VehicleListView(),
    );
  }
}
