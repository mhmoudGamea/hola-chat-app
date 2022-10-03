// this dart file responsible for showing snackBar for the user in 2 cases [errors by red color, success by orange color]
import 'package:flutter/material.dart';

class ShowSnackBar {
  static showSnackBar(BuildContext context, Object message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      duration: const Duration(seconds: 5),
        content: Text(
      message.toString(),
      style: const TextStyle(fontFamily: 'Cairo', letterSpacing: 1.1, color: Colors.white, fontSize: 15),
    )));
  }
}
