import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/show_snackbar.dart';
import '../screens/hola_chat_screen.dart';

class Auth {

  // will create a new user with email & password & also will handle any error that could happen
  static Future<void> createUserWithEmailPass(BuildContext context, String email, String pass) async {
    try {
      final credentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
      // ignore: use_build_context_synchronously
      ShowSnackBar.showSnackBar(context, 'Success Registration.', Colors.orange[400]!);
    }on FirebaseAuthException catch(ex) {
      if(ex.code == 'weak-password') {
        ShowSnackBar.showSnackBar(context, 'can\'t use a weak password.', Colors.red[300]!);
      } else if (ex.code == 'email-already-in-use') {
        ShowSnackBar.showSnackBar(context, 'can\'t use an existing email.', Colors.red[300]!);
      }
    } catch(ex) {
      ShowSnackBar.showSnackBar(context, 'error exist. please try again later.', Colors.red[300]!);
    }
  }

  // will sign in an existing user with email & password & also will handle any error that could happen
  static Future<void> signInUserWithEmailPass(BuildContext context, String email, String pass) async {
    try {
      final credentials = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed(HolaChatScreen.rn, arguments: {'userId': credentials.user!.uid, 'userEmail': credentials.user!.email});
    }on FirebaseAuthException catch(ex) {
      if(ex.code == 'user-not-found') {
        ShowSnackBar.showSnackBar(context, 'No user found for that email.', Colors.red[300]!);
      } else if (ex.code == 'wrong-password') {
        ShowSnackBar.showSnackBar(context, 'Wrong password provided for that user.', Colors.red[300]!);
      }
    } catch(ex) {
      print(ex);
      ShowSnackBar.showSnackBar(context, 'error exist. please try again later.', Colors.red[300]!);
    }
  }

}