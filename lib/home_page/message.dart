import 'package:blood_bank/components/constants.dart';
import 'package:blood_bank/models/blood_bank_user_model.dart';
import 'package:blood_bank/models/donor_user_model.dart';
import 'package:blood_bank/models/message_model.dart';
import 'package:blood_bank/models/seeker_user_model.dart';
import 'package:blood_bank/models/user_model.dart';
import 'package:blood_bank/pages/messages/chat_screen.dart';
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
  List<Map<String, String>> userDetailList = [];

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
                '${userDetailList[index]["name"]}\n${userDetailList[index]["email"]}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                messageModelList[index].message,
                style: const TextStyle(fontSize: 14),
              ),
              onTap: () async {
                String otherUserId = messageModelList[index].senderid ==
                        FirebaseAuth.instance.currentUser!.uid
                    ? messageModelList[index].reciverid
                    : messageModelList[index].senderid;
                BloodBankUserModel? bloodBankUserModel;
                DonorUserModel? donorUserModel;
                SeekerUserModel? seekerUserModel;
                if (otherUserId.startsWith('donor')) {
                  final value = await firebaseFirestore
                      .collection('donordetails')
                      .doc(otherUserId)
                      .get();
                  final data = value.data();
                  donorUserModel = DonorUserModel.fromJson(data!);
                } else {
                  final value = await firebaseFirestore
                      .collection('users')
                      .doc(otherUserId)
                      .get();
                  final data = value.data();
                  bloodBankUserModel = BloodBankUserModel.fromJson(data!);
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      bloodBankUserModel: bloodBankUserModel,
                      donorUserModel: donorUserModel,
                      seekerUserModel: seekerUserModel,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> getMessageList() async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final value = await firebaseFirestore.collection("chats").get();
    Map<String, MessageModel> latestMessages = {};

    for (int i = 0; i < value.docs.length; i++) {
      final data = value.docs[i].data();
      MessageModel messageModel = MessageModel.fromJson(data);

      if (messageModel.senderid == currentUserId ||
          messageModel.reciverid == currentUserId) {
        String otherUserId = currentUserId == messageModel.senderid
            ? messageModel.reciverid
            : messageModel.senderid;

        if (!latestMessages.containsKey(otherUserId) ||
            messageModel.timestamp
                    .compareTo(latestMessages[otherUserId]!.timestamp) >
                0) {
          latestMessages[otherUserId] = messageModel;
        }
      }
    }

    messageModelList = latestMessages.values.toList();
    userDetailList = await Future.wait(latestMessages.keys.map((userId) async {
      return await getUserModel(userId);
    }));

    setState(() {});
  }

  Future<Map<String, String>> getUserModel(String userId) async {
    if (userId.startsWith('donor')) {
      final value =
          await firebaseFirestore.collection('donordetails').doc(userId).get();
      final data = value.data();
      final donor = DonorUserModel.fromJson(data!);
      return {"name": donor.fullname, "email": donor.email};
    } else {
      final value =
          await firebaseFirestore.collection('users').doc(userId).get();
      final data = value.data();
      final user = UserModel.fromJson(data!);
      if (user.userType == 'seeker') {
        final seekerValue = await firebaseFirestore
            .collection('seekerdetails')
            .doc(userId)
            .get();
        final seekerData = seekerValue.data();
        final seeker = SeekerUserModel.fromJson(seekerData!);
        return {"name": seeker.fullname, "email": seeker.email};
      } else if (user.userType == 'donor') {
        final donorValue = await firebaseFirestore
            .collection('donordetails')
            .doc(userId)
            .get();
        final donorData = donorValue.data();
        final donor = DonorUserModel.fromJson(donorData!);
        return {"name": donor.fullname, "email": donor.email};
      } else {
        final bloodBankValue = await firebaseFirestore
            .collection('bloodbankdetails')
            .doc(userId)
            .get();
        final bloodBankData = bloodBankValue.data();
        final bloodBank = BloodBankUserModel.fromJson(bloodBankData!);
        return {"name": bloodBank.bloodbankname, "email": bloodBank.email};
      }
    }
  }
}
