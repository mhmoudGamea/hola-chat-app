import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  // will sign in an existing user with email & password & also will handle any error that could happen
  Future<void> signInUserWithEmailPass(String email, String pass) async {
    emit(LoginLoading());
    try {
      final credentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      emit(LoginSuccess(userCredential: credentials));
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailure(error: 'No user found for that email.'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailure(error: 'Wrong password provided for that user.'));
      }
    } catch (ex) {
      emit(LoginFailure(error: 'error exist. please try again later.'));
    }
  }
}
