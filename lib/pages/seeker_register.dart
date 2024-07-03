import 'dart:developer';

import 'package:blood_bank/components/constants.dart';
import 'package:blood_bank/home_page/home_page.dart';
import 'package:blood_bank/models/seeker_user_model.dart';
import 'package:blood_bank/models/user_model.dart';
import 'package:blood_bank/utils/utils.dart';
import 'package:blood_bank/widgets/whiteroundbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SeekerRegister extends StatefulWidget {
  const SeekerRegister({super.key, Key});

  static const String id = 'SeekerRegister';

  @override
  State<SeekerRegister> createState() => _SeekerRegisterState();
}

class _SeekerRegisterState extends State<SeekerRegister> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    fullnameController.dispose();
    emailController.dispose();
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
        backgroundColor: const Color(0xffEE4141),
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
          'Seeker Register',
          style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 1000,
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
                  const Image(
                    height: 150,
                    width: 150,
                    image: AssetImage('assets/images/logo.png'),
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
                                errorStyle:
                                    const TextStyle(color: Colors.yellow),
                                errorBorder: const UnderlineInputBorder(
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
                                title: 'Register',
                                loading: loading,
                                onTap: () async {
                                  if (_formKey.currentState?.validate() ==
                                      true) {
                                    // yahan pr registration k lia jo logic lagani hy wo yahan pr type krni....
                                    setState(() {
                                      loading = true;
                                    });
                                    try {
                                      _auth
                                          .createUserWithEmailAndPassword(
                                        email: emailController.text.toString(),
                                        password:
                                            passwordController.text.toString(),
                                      )
                                          .then((value) {
                                        final user = SeekerUserModel(
                                          fullname: fullnameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          id: value.user!.uid,
                                        );
                                        createUser(
                                          user: user,
                                          userId: value.user!.uid,
                                        ).then((value) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePage()));
                                          setState(() {
                                            loading = false;
                                          });
                                          utils().toastMessage(
                                              'Register Successfully');
                                        });
                                      }).onError((error, stackTrace) {
                                        utils().toastMessage(error.toString());
                                        setState(() {
                                          loading = false;
                                        });
                                      });
                                    } catch (e) {
                                      log(e.toString());
                                    }
                                  }
                                })),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future createUser({
    required SeekerUserModel user,
    required String userId,
  }) async {
    UserModel userModel = UserModel(
      id: user.id,
      name: user.fullname,
      email: user.email,
      userType: "seeker",
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userModel.toJson());

    FirebaseFirestore.instance
        .collection('seekerdetails')
        .doc(userId)
        .set(user.toJson());
  }
}
