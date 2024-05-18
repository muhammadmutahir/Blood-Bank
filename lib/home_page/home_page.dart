import 'dart:typed_data';

import 'package:blood_bank/components/constants.dart';
import 'package:blood_bank/home_page/message.dart';
import 'package:blood_bank/home_page/update_profile_seeker.dart';
import 'package:blood_bank/models/blood_bank_user_model.dart';
import 'package:blood_bank/models/donor_user_model.dart';
import 'package:blood_bank/models/seeker_user_model.dart';
import 'package:blood_bank/pages/donate_blood/donate_blood_req.dart';
import 'package:blood_bank/pages/find_bloodbank/find_blood_bank_request.dart';
import 'package:blood_bank/pages/find_donor/find_donor_request.dart';
import 'package:blood_bank/pages/login.dart';
import 'package:blood_bank/utils/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  static const String id = "HomePage";
  const HomePage({
    super.key,
    // required this.seekerUserModel,
    // required this.donorUserModel,
    // required this.bloodBankUserModel,
  });

  // final SeekerUserModel? seekerUserModel;
  // final DonorUserModel? donorUserModel;
  // final BloodBankUserModel? bloodBankUserModel;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //DonorUserModel? donorUserModel;

  String name = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentUser();
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getCurrentUser();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 240,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(90),
                    child: Text(
                      "WELCOME $name".toUpperCase(),
                      style: TextStyle(color: whiteColor, fontSize: 15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 160),
                  child: Center(
                    child: Container(
                      height: 290,
                      width: 360,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          const BoxShadow(
                            color: Color.fromARGB(255, 139, 128, 128),
                            offset: Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          )
                        ],
                      ),
                      child: CarouselSlider(
                        items: [
                          Image.asset('assets/images/give_blood_save_life.png'),
                          Image.asset('assets/images/donateimage1.png'),
                          Image.asset('assets/images/donateimage2.png'),
                          Image.asset('assets/images/donateimage3.png'),
                          Image.asset('assets/images/donateimage4.png'),
                        ],
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayInterval: const Duration(seconds: 3),
                          enableInfiniteScroll: true,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            button('Find Donor', () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FindDonorRequest()));
            }),
            const SizedBox(
              height: 15,
            ),
            button('Find Blood Bank', () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FindBloodBankRequest()));
            }),
            const SizedBox(
              height: 15,
            ),
            button('Donate Blood', () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DonateBloodReq()));
            }),
          ],
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 260,
                  width: double.infinity,
                  color: const Color(0xffFF7676),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 0, left: 60, top: 55, bottom: 20),
                    child: Stack(
                      children: [
                        image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(image!),
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                    'https://www.pngitem.com/pimgs/m/421-4212266_transparent-default-avatar-png-default-avatar-images-png.png'),
                              ),
                        Positioned(
                          top: 150,
                          left: 2,
                          child: Text(
                            name.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 90,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.account_box,
                    color: Colors.red,
                  ),
                  title: const Text('Update Profile'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateProfileSeeker()));
                  },
                ),
                const Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.message,
                    color: Colors.red,
                  ),
                  title: const Text('Messages'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Message()));
                  },
                ),
                const Divider(
                  color: Colors.grey,
                ),
                // ListTile(
                //   leading: const Icon(
                //     Icons.history,
                //     color: Colors.red,
                //   ),
                //   title: const Text('History'),
                //   onTap: () {},
                // ),
                // const Divider(
                //   color: Colors.grey,
                // ),
                // ListTile(
                //   leading: const Icon(
                //     Icons.local_hospital,
                //     color: Colors.red,
                //   ),
                //   title: const Text('Donation'),
                //   onTap: () {},
                // ),
                // const Divider(
                //   color: Colors.grey,
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 170, left: 20),
                  child: Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.red, width: 2),
                    ),
                    child: TextButton(
                      onPressed: () {
                        _auth.signOut().then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        }).onError((error, stackTrace) {
                          utils().toastMessage(error.toString());
                        });
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.red,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Sign Out',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget button(String text, VoidCallback onPressed) {
    return Container(
      height: 55,
      width: 297,
      decoration: BoxDecoration(
        color: darkRedButtonColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Uint8List? image;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      image = img;
    });
  }

  Future<void> _getCurrentUser() async {
    User? user = _auth.currentUser;
    // uid = user!.uid;
    if (user != null) {
      DocumentSnapshot userdata =
          await _firebaseFirestore.collection("users").doc(user.uid).get();
      setState(() {
        name = userdata['name'];
      });
    }
  }
}
