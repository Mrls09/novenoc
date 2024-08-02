import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novenoc/global/data/repository/vehicle_repository.dart';
import 'package:novenoc/global/helpers/screens/get_all_vehicles_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => VehicleRepository(
            apiUrl: 'https://5ksg4zuhj6.execute-api.us-east-1.amazonaws.com/Prod',
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const VehicleListView(),
      ),
    );
  }
}
