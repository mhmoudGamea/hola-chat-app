import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  Function(String) onChange;
  String? Function(String?) onValidate;
  bool? isObscure;
  TextInputType? type;

  CustomTextFormField(
      {Key? key,
      required this.onChange,
      required this.onValidate,
      required this.hintText,
      required this.icon,
      this.isObscure,
      this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: onValidate,
      onChanged: onChange,
      obscureText: isObscure ??= false,
      keyboardType: type ??= TextInputType.none,
      decoration: InputDecoration(
        icon: Icon(icon),
        hintText: hintText,
        border: InputBorder.none,
        hintStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.2),
      ),
    );
  }
}
