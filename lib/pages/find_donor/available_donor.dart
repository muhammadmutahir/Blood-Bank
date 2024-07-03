import 'package:blood_bank/components/constants.dart';
import 'package:blood_bank/models/donor_user_model.dart';
import 'package:blood_bank/pages/messages/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AvailableDonor extends StatelessWidget {
  final String bloodgroup;
  final String selectcity;
  const AvailableDonor({
    super.key,
    required this.bloodgroup,
    required this.selectcity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Available Donor',
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
      body: StreamBuilder<List<DonorUserModel>>(
        stream: readUser(),
        builder: (context, snapshot) {
          final users = snapshot.data;
          if (snapshot.hasError) {
            return Text('Something went wrong!!! ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (users == null || users.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/nodatafound.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No data found',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView(
              children: users.map((user) => buildUser(context, user)).toList(),
            );
          }
        },
      ),
    );
  }

  Widget buildUser(BuildContext context, DonorUserModel user) => ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/images/cough.png'),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        user.fullname,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 42,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Text(
                          user.bloodgroup,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      _showDetailsBottomSheet(context, user);
                    },
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        subtitle: Divider(
          color: Colors.grey[300],
          thickness: 1,
          height: 1,
          indent: 16,
          endIndent: 16,
        ),
      );

  Stream<List<DonorUserModel>> readUser() => FirebaseFirestore.instance
      .collection('donordetails')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map(
            (doc) => DonorUserModel.fromJson(
              doc.data(),
            ),
          )
          .where(
            (element) =>
                element.bloodgroup == bloodgroup &&
                element.city == selectcity.toLowerCase(),
          )
          .toList());

  void _showDetailsBottomSheet(
      BuildContext context, DonorUserModel donorUserModel) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                donorUserModel.fullname,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Blood Group: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Container(
                    height: 40,
                    width: 42,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        donorUserModel.bloodgroup,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      callcontactno(donorUserModel.contactno);
                    },
                    icon: const Icon(
                      Icons.phone,
                      color: whiteColor,
                    ),
                    label: Text(
                      donorUserModel.contactno,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                  bloodBankUserModel: null,
                                  donorUserModel: donorUserModel)));
                    },
                    icon: const Icon(
                      Icons.message,
                      color: whiteColor,
                    ),
                    label: const Text(
                      'Message',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void callcontactno(String contactno) {
    launch('tel:$contactno');
  }
}
