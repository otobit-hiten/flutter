part of 'bloc_bloc.dart';

@immutable
abstract class BlocState {}

class BlocInitial extends BlocState {}

class LoginLoading extends BlocState {}

class LoginErrorState extends BlocState {}

class LoginSuccessState extends BlocState{
  final LoginModel data;
  LoginSuccessState(this.data);
}