import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../custom_widgets/custom_chat_bubble.dart';
import '../models/message.dart';



class HolaChatScreen extends StatelessWidget {
  static const rn = '/hola_chat_screen';

  CollectionReference messages = FirebaseFirestore.instance.collection(KMessagesCollection);

  final TextEditingController _textFieldController = TextEditingController();

  final ScrollController _listViewController = ScrollController();

  var yes = true;
  var no = false;

  void _submitMessage(String data, String userId, String userEmail) {
    messages.add({'message': data, 'date': DateTime.now(), 'userId': userId, 'userEmail': userEmail});
    _textFieldController.clear();
    _listViewController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  void _openDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 0,
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            title: const Center(
                child: Text(
              'Choose',
              style: TextStyle(
                  fontFamily: 'Cairo', letterSpacing: 1.2, color: Colors.black87, fontSize: 17),
            )),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.camera_alt_rounded, color: KPrimaryColor)),
                IconButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.image_rounded, color: KPrimaryColor)),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var userData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(userData);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(KLogo, fit: BoxFit.cover, width: 80),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(KDate, descending: true).snapshots(),
        builder: (context, snapshot) {
          //print(snapshot.data!.docs[0]['message']);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: KPrimaryColor,
              ),
            );
          } else {
            List<Message> messagesList = [];
            for (var i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _listViewController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) => messagesList[index].userId == userData['userId']
                        ? ChatBubble(messageBody: messagesList[index], userEmail: messagesList[index].userEmail, me: yes, backgroundColor: KPrimaryColor)
                        : ChatBubble(messageBody: messagesList[index], userEmail: messagesList[index].userEmail, me: no, backgroundColor: Colors.grey[300]!.withOpacity(0.7)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.only(top: 5, bottom: 10, right: 10, left: 10),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!.withOpacity(0.6),
                      spreadRadius: 8,
                      blurRadius: 2,
                      offset: const Offset(0, 4),
                    )
                  ]),
                  child: Row(
                    children: [
                      IconButton(
                          constraints: const BoxConstraints(maxWidth: 35),
                          onPressed: () {},
                          icon: const Icon(Icons.mic, color: KPrimaryColor)),
                      IconButton(
                          constraints: const BoxConstraints(maxWidth: 40),
                          onPressed: () => _openDialog(context),
                          icon: const Icon(Icons.camera_alt_rounded, color: KPrimaryColor)),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 15),
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Colors.grey[200], borderRadius: BorderRadius.circular(18)),
                          child: Row(
                            children: [
                              const Icon(Icons.sentiment_neutral_sharp,
                                  color: KPrimaryColor, size: 22),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  child: TextField(
                                    onSubmitted: (data) {
                                      _submitMessage(data, userData['userId'], userData['userEmail']);
                                    },
                                    controller: _textFieldController,
                                    decoration: const InputDecoration(
                                      constraints: BoxConstraints(maxHeight: 45),
                                      hintText: 'Type message',
                                      hintStyle: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 15,
                                          color: Colors.black38,
                                          letterSpacing: 1.1),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              IconButton(
                                  onPressed: () {
                                    _submitMessage(_textFieldController.text, userData['userId'], userData['userEmail']);
                                  },
                                  constraints: const BoxConstraints(maxWidth: 30),
                                  icon: const Icon(Icons.send_rounded, size: 22),
                                  color: KPrimaryColor),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
//Expected a value of type 'SkDeletable', but got one of type 'Null'
