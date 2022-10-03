import 'package:hola_chat/constants.dart';

class Message {
  final String message;
  final String userId;
  final String userEmail;
  Message(this.message, this.userId, this.userEmail);

  factory Message.fromJson(jsonData) {
    return Message(jsonData[KMessage], jsonData[KUserId], jsonData[KUserEmail]);
  }
}