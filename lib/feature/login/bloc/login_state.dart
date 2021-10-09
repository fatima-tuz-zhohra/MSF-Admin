part of 'login_bloc.dart';

class LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailedState extends LoginState {
  final Result data;

  LoginFailedState(this.data);
}
