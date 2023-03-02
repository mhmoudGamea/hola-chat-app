import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  // will create a new user with email & password & also will handle any error that could happen
  Future<void> createUserWithEmailPass(String email, String pass) async {
    emit(SignupLoading());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      emit(SignupSucess(successSignup: 'Success Registration.'));
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'weak-password') {
        emit(SignupFailure(error: 'can\'t use a weak password.'));
      } else if (ex.code == 'email-already-in-use') {
        emit(SignupFailure(error: 'can\'t use an existing email.'));
      }
    } catch (ex) {
      emit(SignupFailure(error: 'error exist. please try again later.'));
    }
  }
}
