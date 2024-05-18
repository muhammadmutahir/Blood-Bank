import 'package:blood_bank/components/constants.dart';
import 'package:blood_bank/models/message_model.dart';
import 'package:blood_bank/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  static const String id = 'message';
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<MessageModel> messageModelList = [];
  List<String> userNameList = [];
  @override
  void initState() {
    super.initState();
    getMessageList();
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
        body: ListView.builder(
          itemCount: messageModelList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                userNameList[index],
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                messageModelList[index].message,
                style: const TextStyle(fontSize: 14),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> getMessageList() async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final value = await firebaseFirestore.collection("chats").get();
    for (int i = 0; i < value.docs.length; i++) {
      final data = value.docs[i].data();
      MessageModel messageModel = MessageModel.fromJson(data);
      if (messageModelList.isEmpty &&
          (messageModel.senderid == currentUserId ||
              messageModel.reciverid == currentUserId)) {
        messageModelList.add(messageModel);
        String name = await getUserModel(currentUserId == messageModel.senderid
            ? messageModel.reciverid
            : messageModel.senderid);
        userNameList.add(name);
      } else {
        // messageModelList.add(messageModel);
        if (currentUserId == messageModel.senderid) {
          for (int j = 0; j < messageModelList.length; j++) {
            if (messageModel.senderid != messageModelList[j].senderid) {
              messageModelList.removeWhere(
                  (model) => model.senderid == messageModel.senderid);
            }
          }
        } else {
          for (int j = 0; j < messageModelList.length; j++) {
            if (messageModel.reciverid != messageModelList[j].reciverid) {
              messageModelList.removeWhere(
                  (model) => model.reciverid == messageModel.reciverid);
            }
          }
        }
      }
    }
    setState(() {});
  }

  Future<String> getUserModel(String userId) async {
    final value = await firebaseFirestore.collection('users').doc(userId).get();
    final data = value.data();
    UserModel userModel = UserModel.fromJson(data!);
    return userModel.name;
  }
}
