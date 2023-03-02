import 'package:flutter/material.dart';

import '../models/message.dart';

class ChatBubble extends StatelessWidget {
  final Message messageBody;
  final String userEmail;
  final bool me;
  final Color backgroundColor;

  const ChatBubble(
      {Key? key,
      required this.messageBody,
      required this.userEmail,
      required this.me,
      required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: me ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Padding(
            padding: me
                ? const EdgeInsets.only(top: 10.0, left: 15.0, bottom: 0)
                : const EdgeInsets.only(top: 10.0, right: 15.0, bottom: 0),
            child: Text(
              userEmail,
              style: TextStyle(
                  fontFamily: 'Cairo',
                  letterSpacing: 1.1,
                  color: Colors.grey[400],
                  fontSize: 13),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomRight:
                      me ? const Radius.circular(20) : const Radius.circular(0),
                  bottomLeft:
                      me ? const Radius.circular(0) : const Radius.circular(20),
                )),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.70),
            child: Text(
              messageBody.message,
              style: const TextStyle(
                  fontFamily: 'Cairo',
                  letterSpacing: 1.3,
                  color: Colors.black38,
                  fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
//
// class ChatBubbleForFriend extends StatelessWidget {
//   final Message messageBody;
//
//   const ChatBubbleForFriend({Key? key, required this.messageBody}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Container(
//         margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//         decoration: BoxDecoration(
//             color: Colors.grey[300]!.withOpacity(0.7),
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//               bottomRight: Radius.circular(0),
//               bottomLeft: Radius.circular(20),
//             )),
//         constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.70),
//         child: Text(
//           messageBody.message,
//           style: const TextStyle(
//               fontFamily: 'Cairo', letterSpacing: 1.3, color: Colors.black38, fontSize: 15),
//         ),
//       ),
//     );
//   }
// }
