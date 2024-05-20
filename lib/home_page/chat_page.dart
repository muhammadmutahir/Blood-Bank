import 'dart:math';

import 'package:blood_bank/components/constants.dart';
import 'package:blood_bank/components/uid_generator.dart';
import 'package:blood_bank/models/blood_bank_user_model.dart';
import 'package:blood_bank/models/donor_user_model.dart';
import 'package:blood_bank/models/message_model.dart';
import 'package:blood_bank/models/seeker_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatPage extends StatefulWidget {
  static const String id = 'chat_screen';
  const ChatPage({
    super.key,
    required this.bloodBankUserModel,
    required this.donorUserModel,
    SeekerUserModel? seekerUserModel,
  });
  final BloodBankUserModel? bloodBankUserModel;
  final DonorUserModel? donorUserModel;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  String name = '';
  String phoneno = '';
  String receiverUid = '';

  @override
  void initState() {
    super.initState();
    getCurrentUserDetail();
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
        body: StreamBuilder<List<MessageModel>>(
            stream: getMessageStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              List<MessageModel>? messageModelList = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Container(
                        height: 55,
                        width: 380,
                        decoration: BoxDecoration(
                          border: Border.all(color: appBannarColor, width: 2),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      name,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: appBannarColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                callcontactno(phoneno);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.phone,
                                  color: appBannarColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    messageModelList == null || messageModelList.isEmpty
                        ? const Text("No messages found")
                        : SizedBox(
                            height: 500,
                            child: ListView.builder(
                              //shrinkWrap: true,
                              itemCount: messageModelList.length,
                              itemBuilder: (BuildContext context, int index) {
                                MessageModel message = messageModelList[index];
                                bool isSender =
                                    message.senderid == _auth.currentUser!.uid;
                                return MessageBubble(
                                  message: message,
                                  isSender: isSender,
                                );
                              },
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: textController,
                              decoration: InputDecoration(
                                hintText: "Type your message...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(23),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => sendMessage(textController.text),
                            icon: const Icon(
                              Icons.send,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }

  Future<void> getCurrentUserDetail() async {
    if (widget.bloodBankUserModel != null) {
      name = widget.bloodBankUserModel!.bloodbankname;
      phoneno = widget.bloodBankUserModel!.contactno;
      receiverUid = widget.bloodBankUserModel!.id;
    } else {
      name = widget.donorUserModel!.fullname;
      phoneno = widget.donorUserModel!.contactno;
      receiverUid = widget.donorUserModel!.id;
    }
    setState(() {});
  }

  void callcontactno(String contactno) {
    launchUrl(Uri.parse('tel:$contactno'));
  }

  void sendMessage(String message) async {
    try {
      String currentUserID = _auth.currentUser!.uid;
      String messageId = UidGenerator.createID();
      String time = DateTime.now().toString();

      MessageModel messageModel = MessageModel(
        mesgid: messageId,
        senderid: currentUserID,
        reciverid: receiverUid,
        // time: time,
        message: message,
        timestamp: Timestamp.now(),
      );
      await _firebaseFirestore
          .collection('chats')
          .doc(messageModel.mesgid)
          .set(messageModel.toJson());
      textController.clear();
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  String timeToString(TimeOfDay? timeOfDay) {
    String time = '';
    if (timeOfDay != null) {
      DateTime now = DateTime.now();
      time = DateFormat('hh:mm a').format(
        DateTime(
            now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute),
      );
    }
    return time;
  }

  Stream<List<MessageModel>> getMessageStream() {
    String currentUserID = _auth.currentUser!.uid;

    return _firebaseFirestore.collection('chats').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => MessageModel.fromJson(
                  doc.data(),
                ),
              )
              .where((messageModel) =>
                  messageModel.senderid == currentUserID ||
                  messageModel.reciverid == currentUserID)
              .where((messageModel) =>
                  messageModel.senderid == receiverUid ||
                  messageModel.reciverid == receiverUid)
              .toList()
            ..sort((a, b) => a.timestamp.compareTo(b.timestamp)),
        );
  }

  DateTime _parseTime(String timestamp) {
    final format = DateFormat('EEE, M/d/y');
    return format.parse(timestamp);
  }
}

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isSender;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          //hkshdkfd..........................
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.70,
          ),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: isSender
                ? Color.fromARGB(255, 208, 202, 202)
                : const Color.fromARGB(255, 232, 177, 182),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.message,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 2),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  message.timestamp.toString(),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
