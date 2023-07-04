part of 'bloc_bloc.dart';

@immutable
abstract class BlocEvent {}

class LoginFetchEvent  extends BlocEvent{
  final String phoneNumber;
  final String pin;
  LoginFetchEvent(this.phoneNumber, this.pin);
}

class UpdateEvent extends BlocEvent{
  final String email;
  final String phoneNumber;
  final String gender;
  final DataRoles role;
  final String id;
  UpdateEvent(this.email, this.id, this.phoneNumber, this.gender, this.role);
}