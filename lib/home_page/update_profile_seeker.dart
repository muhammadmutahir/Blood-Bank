import 'dart:developer';
import 'dart:typed_data';

import 'package:blood_bank/components/constants.dart';
import 'package:blood_bank/home_page/home_page.dart';
import 'package:blood_bank/models/user_model.dart';
import 'package:blood_bank/utils/utils.dart';
import 'package:blood_bank/widgets/whiteroundbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileSeeker extends StatefulWidget {
  const UpdateProfileSeeker({super.key});
  static const String id = 'UpdateProfileSeeker';

  @override
  State<UpdateProfileSeeker> createState() => _UpdateProfileSeekerState();
}

class _UpdateProfileSeekerState extends State<UpdateProfileSeeker> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  UserModel? userModel;

  Uint8List? image;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  @override
  void dispose() {
    fullnameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  Future<void> _getCurrentUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      final value =
          await _firebaseFirestore.collection("users").doc(user.uid).get();

      userModel = UserModel.fromJson(value.data()!);
      setState(() {
        fullnameController.text = userModel!.name;
        emailController.text = userModel!.email;
      });
    }
  }

  Future<void> _updateUserProfile() async {
    // User? user = _auth.currentUser;
    // if (user != null) {
    //   await _firebaseFirestore.collection("users").doc(user.uid).update({
    //     'name': fullnameController.text,
    //   });
    // }

    if (userModel!.userType == "seeker") {
      await _firebaseFirestore.collection("users").doc(userModel!.id).update({
        'name': fullnameController.text,
      });
      await _firebaseFirestore
          .collection("seekerdetails")
          .doc(userModel!.id)
          .update({
        'fullname': fullnameController.text,
      });
    } else if (userModel!.userType == "donor") {
      await _firebaseFirestore.collection("users").doc(userModel!.id).update({
        'name': fullnameController.text,
      });
      await _firebaseFirestore
          .collection("donordetails")
          .doc(userModel!.id)
          .update({
        'fullname': fullnameController.text,
      });
    } else {
      log(userModel!.id);
      await _firebaseFirestore.collection("users").doc(userModel!.id).update({
        'name': fullnameController.text,
      });
      await _firebaseFirestore
          .collection("bloodbankdetails")
          .doc(userModel!.id)
          .update({
        'bloodbankname': fullnameController.text,
      });
    }
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffEE4141),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
        title: Text(
          'Update Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 83, 83),
                Color(0xff930A0A),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
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
                        top: 90,
                        left: 80,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: fullnameController,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: Color(0xffE5E3E3)),
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                            labelStyle:
                                TextStyle(color: whiteColor, fontSize: 18),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: whiteColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: whiteColor),
                            ),
                            errorStyle: TextStyle(color: Colors.yellow),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow),
                            ),
                          ),
                          validator: validateFullName,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: emailController,
                          readOnly: true,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Color(0xffE5E3E3)),
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle:
                                TextStyle(color: whiteColor, fontSize: 18),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: whiteColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: whiteColor),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        WhiteRoundButton(
                          title: 'Save Changes',
                          loading: loading,
                          onTap: () async {
                            if (_formKey.currentState?.validate() == true) {
                              setState(() {
                                loading = true;
                              });
                              await _updateUserProfile();
                              setState(() {
                                loading = false;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            }
                          },
                        ),
                      ],
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
}
