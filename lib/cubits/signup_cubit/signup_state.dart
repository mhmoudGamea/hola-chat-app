part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSucess extends SignupState {
  final String successSignup;
  SignupSucess({required this.successSignup});
}

class SignupFailure extends SignupState {
  final String error;
  SignupFailure({required this.error});
}
