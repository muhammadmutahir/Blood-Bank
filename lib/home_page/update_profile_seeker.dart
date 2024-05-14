import 'dart:math';
import 'dart:typed_data';

import 'package:blood_bank/components/constants.dart';
import 'package:blood_bank/home_page/home_page.dart';
import 'package:blood_bank/utils/utils.dart';
import 'package:blood_bank/widgets/whiteroundbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class updateProfileSeeker extends StatefulWidget {
  const updateProfileSeeker({super.key});
  static const String id = 'UpdateProfileSeeker';

  @override
  State<updateProfileSeeker> createState() => _updateProfileSeekerState();
}

class _updateProfileSeekerState extends State<updateProfileSeeker> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    fullnameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool obsecureText = true;

  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
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
            // Color(0xff46d733),
            // Color(0xff5c9b54),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
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
                    )
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: TextFormField(
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
                            )),
                        validator: validateFullName,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: TextFormField(
                        controller: emailController,
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
                            errorStyle: TextStyle(color: Colors.yellow),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow),
                            )),
                        validator: validateEmail,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: TextFormField(
                        controller: usernameController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(color: Color(0xffE5E3E3)),
                        decoration: const InputDecoration(
                            labelText: 'Username',
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
                            )),
                        validator: validateUsername,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: TextFormField(
                        obscureText: obsecureText,
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(color: Color(0xffE5E3E3)),
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              color: whiteColor,
                              fontSize: 18,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obsecureText = !obsecureText;
                                });
                              },
                              icon: Icon(
                                obsecureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: whiteColor,
                              ),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: whiteColor),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: whiteColor),
                            ),
                            errorStyle: TextStyle(color: Colors.yellow),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow),
                            )),
                        validator: validatePassword,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: WhiteRoundButton(
                            title: 'Save Changes',
                            loading: loading,
                            onTap: () async {
                              if (_formKey.currentState?.validate() == true) {
                                // yahan pr registration k lia jo logic lagani hy wo yahan pr type krni....
                                setState(() {
                                  loading = true;
                                });

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                                setState(() {
                                  loading = false;
                                });
                              }
                            })),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Uint8List? image;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);

    setState(() {
      image = img;
    });
  }
}
