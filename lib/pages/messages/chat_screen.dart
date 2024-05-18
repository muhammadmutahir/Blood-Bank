import 'dart:math';

import 'package:blood_bank/components/constants.dart';
import 'package:blood_bank/components/uid_generator.dart';
import 'package:blood_bank/models/blood_bank_user_model.dart';
import 'package:blood_bank/models/donor_user_model.dart';
import 'package:blood_bank/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  const ChatScreen({
    super.key,
    required this.bloodBankUserModel,
    required this.donorUserModel,
  });
  final BloodBankUserModel? bloodBankUserModel;
  final DonorUserModel? donorUserModel;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
                      height: 50,
                    ),
                    messageModelList == null || messageModelList.isEmpty
                        ? Text("No messages found")
                        : SizedBox(
                            height: 400,
                            child: ListView.builder(
                              itemCount: messageModelList.length,
                              itemBuilder: (BuildContext context, int index) {
                                TextAlign textAlign =
                                    messageModelList[index].reciverid ==
                                            receiverUid
                                        ? TextAlign.left
                                        : TextAlign.right;
                                return Text(
                                  messageModelList[index].message,
                                  textAlign: textAlign,
                                );
                              },
                            ),
                          ),
                    TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () => sendMessage(textController.text),
                          icon: const Icon(
                            Icons.send,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Future<void> getCurrentUserDetail() async {
    // _seekerUserModel = await _firebaseFirestore
    //     .collection('seekerdetails')
    //     .doc(user!.uid)
    //     .get()
    //     .then(
    //   (value) {
    //     return SeekerUserModel.fromJson(value.data()!);
    //   },
    // );
    // seekerName = _seekerUserModel!.fullname;

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

  void sendMessage(String message) {
    String currentUserID = _auth.currentUser!.uid;

    String messageId = UidGenerator.createID();
    String time = timeToString(TimeOfDay.now());
    String chatDocumentID = generateChatDocumentId(
      currentUserID,
      receiverUid,
    );
    MessageModel messageModel = MessageModel(
      mesgid: messageId,
      senderid: currentUserID,
      reciverid: receiverUid,
      time: time,
      message: message,
    );

    _firebaseFirestore
        .collection('Messages')
        .doc(chatDocumentID)
        .collection('Chat')
        .doc(messageModel.mesgid)
        .set(messageModel.toJson());
    textController.clear();
    setState(() {});
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

    return _firebaseFirestore
        .collection('Messages')
        .doc(receiverUid + currentUserID)
        .collection('Chat')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => MessageModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  String generateChatDocumentId(String senderUid, String receiverUid) {
    List<String> userIds = [senderUid, receiverUid];
    userIds.sort(); // Sorts the list lexicographically
    return userIds.join('_'); // Joins the sorted list with an underscore
  }
}
