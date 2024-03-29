part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserCredential userCredential;
  LoginSuccess({required this.userCredential});
}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure({required this.error});
}
