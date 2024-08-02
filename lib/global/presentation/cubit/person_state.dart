import 'package:equatable/equatable.dart';
import '../../data/models/person_model.dart';

abstract class PersonState extends Equatable{
  @override
  List<Object?> get props => [];
}

class PersonInitial extends PersonState{}

class PersonLoading extends PersonState{}

class PersonSuccess extends PersonState{
  final List<Person> persons;

  PersonSuccess({required this.persons});
  @override
  List<Object?> get props {
    return [persons];
  }
}

class PersonError extends PersonState{
    final String message;

    PersonError({required this.message});

    @override
    List<Object?> get props => [message];
}