import 'dart:developer';

import 'package:blood_bank/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  static const String id = 'message';
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  void initState() {
    super.initState();
    getSingleUserMesages();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: whiteColor,
            ),
          ),
          title: const Text(
            "Messages",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: whiteColor,
            ),
          ),
          backgroundColor: appBannarColor,
          toolbarHeight: 84,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: whiteColor,
        body: ListView(
          children: const [
            ListTile(
              title: Text(
                'Message 1',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'This is the subheading for message 1',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: Text(
                'Message 2',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'This is the subheading for message 2',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              title: Text(
                'Message 3',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'This is the subheading for message 3',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getSingleUserMesages() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    List<String> uidList = [];
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection('chats').get();
    log(querySnapshot.docs.length.toString());
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      uidList.add(doc.id);
      log(doc.id);
    }
  }
}
