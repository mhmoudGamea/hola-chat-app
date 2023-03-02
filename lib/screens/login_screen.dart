import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hola_chat/cubits/login_cubit/login_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snackbar.dart';
import './signup_screen.dart';
import '../constants.dart';
import '../custom_widgets/custom_button.dart';
import '../custom_widgets/custom_text_form_field.dart';
import 'hola_chat_screen.dart';

class LoginScreen extends StatelessWidget {
  static const rn = '/';
  LoginScreen({super.key});

  bool _isLoading = false;
  String? email;
  String? password;
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          _isLoading = true;
        } else if (state is LoginSuccess) {
          _isLoading = false;
          Navigator.of(context).pushNamed(HolaChatScreen.rn, arguments: {
            'userId': state.userCredential.user!.uid,
            'userEmail': state.userCredential.user!.email,
          });
          ShowToast.toast('Success Login', Colors.green[300]!);
        } else if (state is LoginFailure) {
          _isLoading = false;
          ShowToast.toast(state.error, Colors.red[300]!);
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: Scaffold(
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  kPrimaryColor[500]!,
                  kPrimaryColor[900]!,
                  kPrimaryColor[400]!,
                ])),
            child: Column(
              children: [
                Container(
                  height: 170,
                  padding: const EdgeInsets.only(left: 20, top: 30),
                  alignment: Alignment.topLeft,
                  child: Image.asset(kLogo, fit: BoxFit.cover, width: 200),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 20),
                  alignment: Alignment.topRight,
                  child: const Text(
                    'Welcome Back',
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 25),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 30),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(40)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Form(
                        key: _form,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(252, 132, 69, 1.0),
                                      offset: Offset(0, 4),
                                      blurRadius: 15,
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    CustomTextFormField(
                                        onValidate: (data) {
                                          if (data!.isEmpty) {
                                            return 'email is required';
                                          } else if (!data.contains('@') ||
                                              !data.contains('com')) {
                                            return 'invalid email';
                                          }
                                          return null;
                                        },
                                        onChange: (data) => email = data,
                                        hintText: 'Email',
                                        icon: Icons.email_rounded,
                                        type: TextInputType.emailAddress),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]!)),
                                      ),
                                    ),
                                    CustomTextFormField(
                                        onValidate: (data) {
                                          if (data!.isEmpty) {
                                            return 'password is required';
                                          }
                                          return null;
                                        },
                                        onChange: (data) => password = data,
                                        hintText: 'Password',
                                        icon: Icons.password,
                                        isObscure: true,
                                        type: TextInputType.visiblePassword),
                                  ],
                                ),
                              ), // contain email & password fields
                              const SizedBox(
                                height: 25,
                              ),
                              InkWell(
                                onTap: () async {
                                  if (_form.currentState!.validate()) {
                                    await BlocProvider.of<LoginCubit>(context)
                                        .signInUserWithEmailPass(
                                      email!,
                                      password!,
                                    );
                                  }
                                },
                                child: const CustomButton(
                                  text: 'log in',
                                ),
                              ),
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Don\'t have an account? ',
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        color: Colors.grey,
                                        letterSpacing: 1.1,
                                        fontSize: 15),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        padding: const EdgeInsets.all(0)),
                                    child: const Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          color: kPrimaryColor,
                                          letterSpacing: 1.1,
                                          fontSize: 14),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(SignupScreen.rn);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ) // contain the white container
              ],
            ),
          ),
        ),
      ),
    );
  }
}
