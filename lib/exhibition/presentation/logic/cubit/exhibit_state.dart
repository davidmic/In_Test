part of 'exhibit_cubit.dart';

class ExhibitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Initial extends ExhibitState {}

class Loading extends ExhibitState {}

class Loaded extends ExhibitState {
  final List<Exhibit> exhibits;
  Loaded(this.exhibits);

  @override
  String stringfy() => "Loaded ====> $exhibits";

  @override
  List<Object?> get props => [exhibits];
}

class Error extends ExhibitState {
  final String error;
  Error(this.error);

  @override
  String stringfy() => "Loaded ====> $error";

  @override
  List<Object?> get props => [error];
}
