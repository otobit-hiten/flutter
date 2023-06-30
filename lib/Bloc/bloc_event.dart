part of 'bloc_bloc.dart';

@immutable
abstract class BlocEvent {}

class LoginFetchEvent  extends BlocEvent{
  final String phoneNumber;
  final String pin;
  LoginFetchEvent(this.phoneNumber, this.pin);
}
